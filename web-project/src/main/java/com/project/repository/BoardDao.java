package com.project.repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.project.domain.Board;
import com.project.domain.Gallery;

public class BoardDao {
    
    private static final BoardDao BOARD_DAO = new BoardDao();
    
    public static BoardDao getInstance() {
        return BOARD_DAO;
    }
    
    private BoardDao() {
        createTableIfNotExists();
        int rowCount = getBoardCount();
        if (rowCount == 0) {
            insertDummyRecords();
        }
    }
    
    private void insertDummyRecords() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "INSERT INTO board (num, name, passwd, subject, content, filename, re_ref, re_lev, re_seq, readcount, reg_date, ip, notice) ";
            sql += " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            
            pstmt = con.prepareStatement(sql);
            
            final int BATCH_SIZE = 1000;
            int count = 0;
            
            for (int i=1; i<=9999; i++) {
                pstmt.setInt(1, i); // 글번호
                pstmt.setString(2, "글쓴이" + i);
                pstmt.setString(3, "1234");
                pstmt.setString(4, "글제목입니다." + i);
                pstmt.setString(5, "글내용입니다." + i);
                pstmt.setString(6, null);
                pstmt.setInt(7, i); // re_ref == num
                pstmt.setInt(8, 0);   // re_lev
                pstmt.setInt(9, 0);   // re_seq
                pstmt.setInt(10, 0);  // readcount 조회수
                pstmt.setTimestamp(11, new Timestamp(System.currentTimeMillis()));
                pstmt.setString(12, null);
                pstmt.setString(13, "no");
                // 실행
                pstmt.addBatch();
                
                count++; // addBatch 카운트
                if (count % BATCH_SIZE == 0) {
                    pstmt.executeBatch(); // DB에 sql전송
                }                    
            } //for()
            pstmt.executeBatch(); // 남은 데이터 전송
           
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // insertDummyRecords()
    
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "create table if not exists board ( " + 
                    "  num int primary key, " +
                    "  name varchar(20), " +
                    "  passwd varchar(20), " +
                    "  subject varchar(50), " +
                    "  content varchar(2000), " +
                    "  ip varchar(20), " +
                    "  reg_date timestamp, " +
                    "  readcount int, " +
                    "  re_ref int, " +
                    "  re_lev int, " +
                    "  re_seq int, " +
                    "  filename varchar(50), " +
                    "  notice varchar(20) " +
                    ") ";
            
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // createTableIfNotExists()
    
	
	// 게시판 주글(일반글) 한개 추가
    public void insertBoard(Board board) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null; // DB에서 글 번호를 가져옴
        String sql = "";
        int num = 0; //글번호
        
        try {
            con = H2DB.getConnection();
            // 글번호 num구하기. 글이 없을경우 1
            // 글이 있는경우 최근글번호(번호가 가장 큰 값) + 1
            sql = "SELECT MAX(num) FROM board";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                // 글이 있는 경우. 최대값+1, getInt 괄호 안의 값은 인덱스 값(1번 행) 
                num = rs.getInt(1) + 1; 
            } else {
                num = 1;
            }
            pstmt.close();
            rs.close();
            // 주글 (일반글) num == re_ref 같게 입력
            sql = "INSERT INTO board (num, name, passwd, subject, content,"
                    + " filename, re_ref, re_lev, re_seq, readcount, "
                    + "reg_date, ip, notice) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // 글번호
            pstmt.setString(2, board.getName());
            pstmt.setString(3, board.getPasswd());
            pstmt.setString(4, board.getSubject());
            pstmt.setString(5, board.getContent());
            pstmt.setString(6, board.getFilename());
            pstmt.setInt(7, num); // re_ref == num
            pstmt.setInt(8, 0); // re_lev 같은 그룹 내에서의 들여쓰기
            pstmt.setInt(9, 0); // re_seq 같은 그룹 내에서의 순번
            pstmt.setInt(10, 0); // readcount 조회수
            pstmt.setTimestamp(11, board.getReg_date());
            pstmt.setString(12, board.getIp());
            pstmt.setString(13, "no");
            pstmt.executeUpdate();
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    } //insertBoard()
	

	// 게시판 글 가져오기
	public List<Board> getBoards(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board> list = new ArrayList<Board>();
		// 자주 일어나는 문자 연결에 대해서 String과는 다르게 쓰레기 객체를 생성하지 않음
		StringBuilder sb = new StringBuilder();

		try {
			con = H2DB.getConnection();
			sb.append("select a.* ");
			sb.append("from ");
			sb.append("    (select rownum as rnum, a.* ");
			sb.append("    from (select * from board order by re_ref desc, re_seq asc) a ");
			sb.append("    where rownum <= ?) a ");
			sb.append("where rnum >= ? ");
			
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);
			//실행
			rs = pstmt.executeQuery();
			// 데이터 있으면 자바빈 객체 생성
			// rs => 자바빈 저장 => list에 한개 추가
			while (rs.next()) {
				// 자바빈 객체생성 준비
				Board board = new Board();
				// rs => 자바빈 저장
				board.setContent(rs.getString("content"));
				board.setFilename(rs.getString("filename"));
				board.setIp(rs.getString("ip"));
				board.setName(rs.getString("name"));
				board.setNum(rs.getInt("num"));
				board.setPasswd(rs.getString("passwd"));
				board.setRe_lev(rs.getInt("re_lev"));
				board.setRe_ref(rs.getInt("re_ref"));
				board.setRe_seq(rs.getInt("re_seq"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setSubject(rs.getString("subject"));
				board.setNotice(rs.getString("notice"));
				// 자바빈 => list 한칸 추가
				list.add(board);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			H2DB.closeJDBC(con, pstmt, rs);
		}		
		return list;
	} // getBoards()
	
	
	public List<Board> getBoards(int startRow, int endRow, String search) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Board> list = new ArrayList<Board>();
        // 자주 일어나는 문자 연결에 대해서 String과는 다르게 쓰레기 객체를 생성하지 않음
        StringBuilder sb = new StringBuilder();

        try {
            con = H2DB.getConnection();
            sb.append("select a.* ");
            sb.append("from ");
            sb.append("    (select rownum as rnum, a.* ");
            sb.append("    from (select * from board where subject like ? order by re_ref desc, re_seq asc) a ");
            sb.append("    where rownum <= ?) a ");
            sb.append("where rnum >= ? ");
            
            pstmt = con.prepareStatement(sb.toString());
            pstmt.setString(1, "%" + search + "%");
            pstmt.setInt(2, endRow);
            pstmt.setInt(3, startRow);
            //실행
            rs = pstmt.executeQuery();
            // 데이터 있으면 자바빈 객체 생성
            // rs => 자바빈 저장 => list에 한개 추가
            while (rs.next()) {
                // 자바빈 객체생성 준비
                Board board = new Board();
                // rs => 자바빈 저장
                board.setContent(rs.getString("content"));
                board.setFilename(rs.getString("filename"));
                board.setIp(rs.getString("ip"));
                board.setName(rs.getString("name"));
                board.setNum(rs.getInt("num"));
                board.setPasswd(rs.getString("passwd"));
                board.setRe_lev(rs.getInt("re_lev"));
                board.setRe_ref(rs.getInt("re_ref"));
                board.setRe_seq(rs.getInt("re_seq"));
                board.setReadcount(rs.getInt("readcount"));
                board.setReg_date(rs.getTimestamp("reg_date"));
                board.setSubject(rs.getString("subject"));
                board.setNotice(rs.getString("notice"));
                // 자바빈 => list 한칸 추가
                list.add(board);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getBoards()
	
	
	public List<Board> getBoardsWithLimit(int startRow, int pageSize) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Board> list = new ArrayList<Board>();
        // 자주 일어나는 문자 연결에 대해서 String과는 다르게 쓰레기 객체를 생성하지 않음
        String sql="";

        try {
            con = H2DB.getConnection();
            sql = "select * " + 
                    "from board " + 
                    "order by re_ref desc, re_seq asc " + 
                    "offset ? limit ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startRow-1);
            pstmt.setInt(2, pageSize);
            //실행
            rs = pstmt.executeQuery();
            // 데이터 있으면 자바빈 객체 생성
            // rs => 자바빈 저장 => list에 한개 추가
            while (rs.next()) {
                // 자바빈 객체생성 준비
                Board board = new Board();
                // rs => 자바빈 저장
                board.setContent(rs.getString("content"));
                board.setFilename(rs.getString("filename"));
                board.setIp(rs.getString("ip"));
                board.setName(rs.getString("name"));
                board.setNum(rs.getInt("num"));
                board.setPasswd(rs.getString("passwd"));
                board.setRe_lev(rs.getInt("re_lev"));
                board.setRe_ref(rs.getInt("re_ref"));
                board.setRe_seq(rs.getInt("re_seq"));
                board.setReadcount(rs.getInt("readcount"));
                board.setReg_date(rs.getTimestamp("reg_date"));
                board.setSubject(rs.getString("subject"));
                board.setNotice(rs.getString("notice"));
                // 자바빈 => list 한칸 추가
                list.add(board);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getBoards()
	
	// 전체 글개수 가져오기
	public int getBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = H2DB.getConnection();
			// sql 전체 글 개수 가져오기
			sql = "SELECT COUNT(*) FROM board";
			pstmt = con.prepareStatement(sql);
			// 실행  rs
			rs = pstmt.executeQuery();
			// rs에 데이터 가 있으면 count 저장
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			H2DB.closeJDBC(con, pstmt, rs);
		}		
		return count;
	}
	
	
	// 검색 글개수 가져오기
    public int getBoardCount(String search) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT COUNT(*) FROM board WHERE subject like ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + search + "%");
            // 실행  rs
            rs = pstmt.executeQuery();
            // rs에 데이터 가 있으면 count 저장
            
            if(rs.next()) {
                count = rs.getInt(1);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return count;
    }
	
	// 조회수 1올리기
	public void updateReadCount(int num){
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   String sql = "";
	   
	   try {
	       con = H2DB.getConnection();
	       //sql update num에 해당하는 Readcount 1증가 하게 수정
	       // (기존값에서 +1)
	       sql = "UPDATE board SET readcount = readcount+1  WHERE num=?";
	       pstmt = con.prepareStatement(sql);
	       pstmt.setInt(1, num);
	       pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
    	    H2DB.closeJDBC(con, pstmt, null);
    	}
	}
	
	// 글 1개 가져오기. 글 내용 상세보기
	public Board getBoard(int num) {	    
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "";
	      Board board = null;
	      
	      try {
            con = H2DB.getConnection();
            // sql num에 해당하는 정보 가져오기
            sql = "SELECT * FROM board WHERE num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            // 실행  rs에 저장
            rs = pstmt.executeQuery();
            // rs 데이터 있으면 자바빈 객체생성
            // rs => 자바빈에 저장
            if (rs.next()) {
                // 자바빈 객체생성. 기억장소 할당
                board = new Board();
                board.setContent(rs.getString("content"));
                board.setFilename(rs.getString("filename"));
                board.setIp(rs.getString("ip"));
                board.setName(rs.getString("name"));
                board.setNum(rs.getInt("num"));
                board.setPasswd(rs.getString("passwd"));
                board.setRe_lev(rs.getInt("re_lev"));
                board.setRe_ref(rs.getInt("re_ref"));
                board.setRe_seq(rs.getInt("re_seq"));
                board.setReadcount(rs.getInt("readcount"));
                board.setReg_date(rs.getTimestamp("reg_date"));
                board.setSubject(rs.getString("subject"));
                board.setNotice(rs.getString("notice"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return board;
	} // getBoard()
	
	public int updateBoard(Board board) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
	    int check = 0;	    
        try {
            con = H2DB.getConnection();
            // sql   num에 해당하는 passwd 가져오기
            sql = "SELECT passwd FROM board WHERE num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, board.getNum());
            // rs 실행  저장
            rs = pstmt.executeQuery();
            // rs데이터 있으면  패스워드비교  맞으면
            // update  num에 해당하는 name subject content 수정
            // check = 1 수정성공, 패스워드 틀리면  check = 0       
            if (rs.next()) {
                if (board.getPasswd().equals(rs.getString("passwd"))) {
                    pstmt.close();
                    pstmt = null;
                    
                    sql = "UPDATE board SET name=?, subject=?, content=?, filename=? WHERE num=?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, board.getName());
                    pstmt.setString(2, board.getSubject());
                    pstmt.setString(3, board.getContent());
                    pstmt.setString(4, board.getFilename()); // 추가
                    pstmt.setInt(5, board.getNum());
                    // 실행
                    pstmt.executeUpdate();                  
                    check = 1;
                } else {
                    check = 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }	    
	    return check;
	}//updateBoard
	
	// 게시판 글 삭제
	public int deleteBoard(int num, String passwd) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int check = 0;
        
        try {
            con = H2DB.getConnection();
            // num에 해당하는 passwd 가져오기
            sql = "SELECT passwd FROM board WHERE num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            // 실행 rs 저장
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (passwd.equals(rs.getString("passwd"))) {
                    pstmt.close();
                    pstmt = null;       
                    // delete
                    sql = "DELETE FROM board WHERE num=?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, num);
                    // 실행
                    pstmt.executeUpdate();
                   
                    check = 1;
                } else {
                    check = 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }	   
	    return check;
	}
	
	// 관리자의 권한으로 게시판 글 삭제
	public int deleteBoardByAdmin(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;

		try {
			con = H2DB.getConnection();

			sql = "SELECT * FROM board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 실행 rs 저장
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pstmt.close();
				pstmt = null;
				// delete
				sql = "DELETE FROM board WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				// 실행
				pstmt.executeUpdate();

				check = 1;
			} else {
				check = 0;

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			H2DB.closeJDBC(con, pstmt, rs);
		}
		return check;
	}
	
	// 답글 쓰기 (re_seq 1씩 업데이트 후 답글 insert)
	public void reInsertBoard(Board board) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int num = 0;
        
        try {
            con = H2DB.getConnection();
            // update & insert 한개의 처리단위인데 오류 발생시 앞쪽의 트렌젝션만 수행되는 경우 데이터번경 없기 위해..
            // 트랜젝션 관리기법
            // 기본설정인 자동커밋을 수동커밋으로 제어함
            
            con.setAutoCommit(false);
            // sql 그룹 내의  답변 순서 재배치 
            // update re_seq
            sql = "UPDATE board SET re_seq=re_seq+1 WHERE re_ref=? AND re_seq > ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, board.getRe_ref());
            pstmt.setInt(2, board.getRe_seq());
            pstmt.executeUpdate();
            
            // 글번호 num 구하기 max(num)+1
            pstmt.close(); pstmt = null;
            sql="SELECT MAX(num) FROM board";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                num = rs.getInt(1) +1 ;
                board.setNum(num);
            } else {
                num = 1;
            }
            
            // 답글 insert
            // re_ref 그대로 re_lev 1증가 re_seq 1증가
            pstmt.close(); pstmt = null;
            sql = "INSERT INTO board (num, name, passwd, subject, content,"
                    + " filename, re_ref, re_lev, re_seq, readcount, "
                    + "reg_date, ip, notice) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // 글번호
            pstmt.setString(2, board.getName());
            pstmt.setString(3, board.getPasswd());
            pstmt.setString(4, board.getSubject());
            pstmt.setString(5, board.getContent());
            pstmt.setString(6, board.getFilename());
            pstmt.setInt(7, board.getRe_ref()); // 글그룹 = 동일
            pstmt.setInt(8, board.getRe_lev()+1); // re_lev 들여쓰기 +1
            pstmt.setInt(9, board.getRe_seq()+1); // re_seq 그룹내 순서+1
            pstmt.setInt(10, 0); // readcount 조회수
            pstmt.setTimestamp(11, board.getReg_date());
            pstmt.setString(12, board.getIp());
            pstmt.setString(13, "no");
            pstmt.executeUpdate();
            
            // commit 수행
            con.commit();
            // autoCommit 기본 속성을 true로 변경(다른 작업 수행시 변동 없게..) 
            con.setAutoCommit(true);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                // 오류 발생 시 원래 상태로 되돌리기
                con.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } finally {
            
            H2DB.closeJDBC(con, pstmt, rs);
        }
	    
	} // reInsertBoard()
	
	
	// 공지사항 가져오기
	public Board getBoardNotice() {	    
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "";
	      Board board = null;
	      
	      try {
            con = H2DB.getConnection();
            // sql num에 해당하는 정보 가져오기
            sql = "SELECT * FROM board WHERE notice=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "notice");
            // 실행  rs에 저장
            rs = pstmt.executeQuery();
            // rs 데이터 있으면 자바빈 객체생성
            // rs => 자바빈에 저장
            if (rs.next()) {
                // 자바빈 객체생성. 기억장소 할당
                board = new Board();
                board.setContent(rs.getString("content"));
                board.setFilename(rs.getString("filename"));
                board.setIp(rs.getString("ip"));
                board.setName(rs.getString("name"));
                board.setNum(rs.getInt("num"));
                board.setPasswd(rs.getString("passwd"));
                board.setRe_lev(rs.getInt("re_lev"));
                board.setRe_ref(rs.getInt("re_ref"));
                board.setRe_seq(rs.getInt("re_seq"));
                board.setReadcount(rs.getInt("readcount"));
                board.setReg_date(rs.getTimestamp("reg_date"));
                board.setSubject(rs.getString("subject"));
                board.setNotice(rs.getString("notice"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return board;
	}
	
	// 공지사항 취소하기
	public void noBoardNotice(Board board) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
    
        try {
            con = H2DB.getConnection();
            // sql   num에 해당하는 passwd 가져오기
            sql = "SELECT * FROM board WHERE notice=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "notice");
            // rs 실행  저장
            rs = pstmt.executeQuery();
            // rs데이터 있으면  패스워드비교  맞으면
            // update  num에 해당하는 name subject content 수정
            // check = 1 수정성공, 패스워드 틀리면  check = 0       
            if (rs.next()) {
            	pstmt.close();
                pstmt = null;
                
                sql = "UPDATE board SET notice=? WHERE notice=?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, "no");
                pstmt.setString(2, "notice");
                // 실행
                pstmt.executeUpdate();    

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }	    
	}//updateBoard
	
	
	// 공지사항 설정하기
	public void setBoardNotice(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			con = H2DB.getConnection();

			sql = "SELECT * FROM board WHERE notice=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "notice");

			rs = pstmt.executeQuery();
			if (rs.next()) {


				sql = "UPDATE board SET notice=? WHERE notice=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "no");
				pstmt.setString(2, "notice");
				// 실행
				pstmt.executeUpdate();


				sql = "UPDATE board SET notice=? WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "notice");
				pstmt.setInt(2, num);
				// 실행
				pstmt.executeUpdate();

			}
			sql = "UPDATE board SET notice=? WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "notice");
			pstmt.setInt(2, num);
			// 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			H2DB.closeJDBC(con, pstmt, rs);
		}
	}// setBoardNotice
	
	
	public List<Integer> getHotContents() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Integer> list = new ArrayList();

        String sql="";

        try {
            con = H2DB.getConnection();
            sql = "select num " + 
                    "from board " + 
                    "order by readcount desc " + 
                    "offset 0 limit 3";

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {

                int num = 0;
                // rs => 자바빈 저장
                num = rs.getInt("num");

                list.add(num);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getHotContents()

}


 // BoardDao
