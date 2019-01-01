package com.project.repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.project.domain.*;
import com.project.repository.*;


// DB�쓽 member �뀒�씠釉붿쓣 議곗옉�빐二쇰뒗 �겢�옒�뒪
public class MemberDao {
    
    private static final MemberDao MEMBER_DAO = new MemberDao();   
	
    // �떛湲��넠�뙣�꽩
	public static MemberDao getInstance() {
        return MEMBER_DAO;
    }
	
	private MemberDao() {
	    createTableIfNotExists();
	}
	
	private void createTableIfNotExists() {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql  ="";
	   
	    try {
            con = H2DB.getConnection();
            sql =  "create table if not exists member (" +
                    "id varchar(12) primary key," +
                    "passwd varchar(12) not null," +                
                    "name varchar(20) not null," +
                    "reg_date timestamp not null," +
                    "age int," +
                    "gender varchar(5)," +
                    "email varchar(30)," +
                    "address varchar(100)," +
                    "tel varchar(30)," +
                    "mtel varchar(30)" +
                    ");";
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
                    
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
	} // createTableIfNotExists()
	
	
	// insert 硫붿냼�뱶 
	public void insertMember (Member member) {
		// JDBC 李몄“蹂��닔
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try { // 1.�뱶�씪�씠踰꾨줈�뵫  2.DB�뿰寃�
			con = H2DB.getConnection();
			String sql = "INSERT INTO member (id, passwd, name, "
					+ "reg_date, email, address, tel, mtel, age, gender) "
					+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getReg_date());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getTel());
			pstmt.setString(8, member.getMtel());
			// age-Integer媛믪엫. �엯�젰�븞�븯硫� null�씤�뜲 setInt濡� int 媛믩쭔 媛��뒫�븿
			
			if (member.getAge() == null) {
			    pstmt.setNull(9, Types.NULL);
			} else {
			    pstmt.setInt(9, member.getAge());
			}			
			// pstmt.setInt(9, member.getAge()==null? 0: member.getAge());
			
/*			if (member.getAge()==null) {
			    member.setAge(0);
			} else {
			    member.getAge();
			}*/
			
            pstmt.setString(10, member.getMtel());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();	
		} finally {
			H2DB.closeJDBC(con, pstmt, null);
		}
	} // insertMember�쓽 �걹
	
	
	
	// �궗�슜�옄 濡쒓렇�씤 泥댄겕�븯�뒗 硫붿냼�뱶. id, passwd媛� 媛�吏�
    public int userCheck(String id, String passwd) {
        // JDBC 李몄“蹂��닔
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int check = -1; // 遺��젙�쟻�씤 媛믪쓣 湲곕낯媛믪쑝濡� �몺.

        try {
            con = H2DB.getConnection(); // 而ㅻ꽖�뀡 媛��졇�삤湲�
            // 3. id�뿉 �빐�떦�븯�뒗 passwd 媛��졇�삤湲�
            String sql = "SELECT passwd FROM member WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            // 4. �떎�뻾 rs�뿉 ���옣
            rs = pstmt.executeQuery();
            // 5.
            // rs�뿉 �뜲�씠�꽣(�뻾)媛� �엳�쑝硫� �븘�씠�뵒�엳�쓬
            // �뙣�뒪�썙�뱶鍮꾧탳 留욎쑝硫� 濡쒓렇�씤�씤利�(�꽭�뀡媛믪깮�꽦 "id")
            // �뙣�뒪�썙�뱶鍮꾧탳 ��由щ㈃ "�뙣�뒪�썙�뱶��由�" 濡쒓렇�씤�럹�씠吏�濡� �씠�룞
            // rs�뿉 �뜲�씠�꽣(�뻾)媛� �뾾�쑝硫� "�븘�씠�뵒�뾾�쓬" 濡쒓렇�씤�럹�씠吏�濡� �씠�룞
            if (rs.next()) {
                // �븘�씠�뵒�엳�쓬
                if (passwd.equals(rs.getString("passwd"))) {
                    check = 1; // �븘�씠�뵒, �뙣�뒪�썙�뱶 �씪移�
                } else {
                    check = 0; // �뙣�뒪�썙�뱶媛� 遺덉씪移�.
                }
            } else {
                check = -1; // �븘�씠�뵒 遺덉씪移�.
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
       
        return check;
    } // userCheck()
	
	// �쟾泥댄쉶�썝紐⑸줉 媛��졇�삤湲�
	public List<Member> getMembers() throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Member> list = new ArrayList<Member>();
		
		try {
			con = H2DB.getConnection();
			// sql �쉶�썝�쟾泥� 媛��졇�삤湲�
			String sql = "SELECT * FROM member ORDER BY reg_date ASC";
			pstmt = con.prepareStatement(sql);
			// 3. rs ���옣
			rs = pstmt.executeQuery();
			
			// rs �뜲�씠�꽣 �엳�쑝硫� �옄諛붾퉰 媛앹껜�깮�꽦
			// rs => �옄諛붾퉰 硫ㅻ쾭蹂��닔�뿉 ���옣
			// �옄諛붾퉰 => 由ъ뒪�듃 �븳移� 異붽�
			while(rs.next()){
				Member Member = new Member();
				Member.setId(rs.getString("id"));
				Member.setPasswd(rs.getString("passwd"));
				Member.setName(rs.getString("name"));
				Member.setReg_date(rs.getTimestamp("reg_date"));
				Member.setAge(rs.getInt("age"));
				Member.setGender(rs.getString("gender"));
				Member.setEmail(rs.getString("email"));
				list.add(Member); // 諛곗뿴由ъ뒪�듃�뿉 異붽�
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		    H2DB.closeJDBC(con, pstmt, rs);
		}	 
		return list;
	}// getMembers()
	
	//�쉶�썝 �븳�궗�엺�쓽 �젙蹂� 媛��졇�삤湲�
	public Member getMember(String id) {
		// JDBC 蹂��닔
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member Member = null;
		try {
			con = H2DB.getConnection();	
			// 3. id�뿉 �빐�떦�븯�뒗 紐⑤뱺�젙蹂� 媛��졇�삤湲�
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);			
			// 4. rs �떎�뻾 ���옣
			rs = pstmt.executeQuery();			
			// 5. rs => �옄諛붾퉰�뿉 ���옣
			if (rs.next()){
				Member = new Member();
				Member.setId(rs.getString("id"));
				Member.setPasswd(rs.getString("passwd"));
				Member.setName(rs.getString("name"));
				Member.setReg_date(rs.getTimestamp("reg_date"));
				Member.setAge(rs.getInt("age"));
				Member.setGender(rs.getString("gender"));
				Member.setEmail(rs.getString("email"));
			}				
		} catch (Exception e) {		
			e.printStackTrace();
		} finally {
		    H2DB.closeJDBC(con, pstmt, rs);
		}
		return Member;
	} // getMember�쓽 �걹
	
	
	//�쉶�썝�젙蹂� �닔�젙
	public int updateMember(Member member) throws Exception {
		// JDBC 蹂��닔
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0; // �떎�뙣媛믪쑝濡� 珥덇린�솕
		
		try {
			con = H2DB.getConnection();
			// 3. id�뿉 �빐�떦�븯�뒗 passwd 媛��졇�삤湲�.
			String sql = "SELECT passwd FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			// 4. �떎�뻾 rs ���옣
			rs = pstmt.executeQuery();
			// 5. rs �뜲�씠�꽣 �엳�쑝硫� �븘�씠�뵒�엳�쓬. 
			// �뙣�뒪�썙�뱶 鍮꾧탳 留욎쑝硫� update �닔�뻾�븯濡� check = 1;
			// �뙣�뒪�썙�뱶 鍮꾧탳 ��由щ㈃ check = 0; 
			if (rs.next()){
				if(member.getPasswd().equals(rs.getString("passwd"))){
					pstmt.close(); // select�슜 臾몄옣 媛앹껜 �떕湲�
					pstmt = null;
					sql = "UPDATE member SET name=?, age=?, gender=?, email=? WHERE id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, member.getName());
					pstmt.setInt(2, member.getAge());
					pstmt.setString(3, member.getGender());
					pstmt.setString(4, member.getEmail());
					pstmt.setString(5, member.getId());
					// �떎�뻾
					pstmt.executeUpdate();
					check = 1;
				} else {
					check = 0; // �뙣�뒪�썙�뱶 �씪移섑븯吏� �븡�쓬
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		    H2DB.closeJDBC(con, pstmt, rs);
		}	
		return check;
	} // updateMember
	
	// �쉶�썝�궘�젣. id, passwd �옄諛붾퉰
	public int deleteMember(Member member) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;	
		
		try {
			con = H2DB.getConnection();
		
			// 3. id�뿉 �빐�떦�븯�뒗 passwd 媛��졇�삤湲�
			String sql = "SELECT passwd FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId()); // id : �꽭�뀡 泥댄겕�븯湲� �쐞�빐 媛��졇�삩 id 蹂��닔 媛�
			// 4. �떎�뻾 rs ���옣
			rs = pstmt.executeQuery();
			// 5. �뜲�씠�꽣媛� �엳怨� �뙣�뒪�썙�뱶 鍮꾧탳 留욎쑝硫� delete �썑 loginFrom.jsp濡� �씠�룞
			// �뙣�뒪�썙�뱶 ��由щ㈃ "�뙣�뒪�썙�뱶��由�" �뮘濡� �씠�룞
			
			if(rs.next()){
				if(member.getPasswd().equals(rs.getString("passwd"))){
					pstmt.close();
					pstmt = null;
					sql = "DELETE FROM member WHERE id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, member.getId());
					// �떎�뻾
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

	} // deleteMember()
	
    // idCheck 硫붿냼�뱶
    public int idCheck(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int check = 0; // 1以묐났�븘�떂, 0以묐났�엫
        
        try {
            con = H2DB.getConnection();
            sql = "SELECT * FROM member WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            // �떎�뻾 rs
            rs = pstmt.executeQuery();
            // rs �뜲�씠�꽣 �엳�쑝硫� �븘�씠�뵒以묐났 check=0
            //         �뾾�쑝硫� check=1
            if (rs.next()) {
                check = 0;  // �븘�씠�뵒 以묐났
            } else {
                check = 1;  // �븘�씠�뵒 �뾾�쓬
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return check;
    } // idCheck()
    

} // Class MemberDao
	
	