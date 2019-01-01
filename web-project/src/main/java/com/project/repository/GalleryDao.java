package com.project.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.project.repository.H2DB;
import com.project.domain.Board;
import com.project.domain.Gallery;
import com.project.domain.Gallery_Reply;

public class GalleryDao {
    private static final GalleryDao GALLERY_DAO = new GalleryDao();
    
    public static GalleryDao getInstance() {
        return GALLERY_DAO;
    }
    
    // 기본생성자 : 갤러리 테이블이 존재하지 않으면 생성하는 메소드 호출
    private GalleryDao() {
        createTableIfNotExists();
        
    }
    
    // 테이블 존재하지 않으면 생성
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "create table if not exists gallery ( " + 
                    "  num int primary key, " +
                    "  name varchar(20), " +
                    "  subject varchar(50), " +
                    "  content varchar(2000), " +
                    "  ip varchar(20), " +
                    "  reg_date timestamp, " +
                    "  filename varchar(50) " +
                    ") ";
            
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // createTableIfNotExists()
    
    
    // 갤러리 게시판 글 추가
    public void insertGallery(Gallery gallery) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int num = 0; 
        
        try {
            con = H2DB.getConnection();
            
            sql = "SELECT MAX(num) FROM gallery";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {

                num = rs.getInt(1) + 1; 
            } else {
                num = 1;
            }
            pstmt.close();
            rs.close();

            sql = "INSERT INTO gallery (num, name, subject, content,"
                    + " ip, reg_date, filename) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // 글번호
            pstmt.setString(2, gallery.getName());
            pstmt.setString(3, gallery.getSubject());
            pstmt.setString(4, gallery.getContent());
            pstmt.setString(5, gallery.getIp());
            pstmt.setTimestamp(6, gallery.getReg_date());
            pstmt.setString(7, gallery.getFilename());
            pstmt.executeUpdate();
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    } //insertGallery()
    
    // 갤러리 주글 3개와 리플 offset으로 가져오는 쿼리.
    public List<Gallery> getGalleryListWithReply(int startRow, int pageSize) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Gallery> list = new ArrayList<Gallery>();
        String sql="";
        
        try {
            con = H2DB.getConnection();
            sql = "select a.num, a.name, a.subject, a.content origincontent, a.filename, a.reg_date origindate, " +
                    "b.num rep_num, b.name, b.content replycontent, b.ip,  b.reg_date replydate " +  
                    "from (select * from gallery order by num desc offset ? limit ?) a " + 
                    "        left join " + 
                    "        (select * from gallery_reply) b " +
                    "on a.num = b.origin_num ";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startRow-1);
            pstmt.setInt(2, pageSize);
            
            rs = pstmt.executeQuery();
            
            int num = 0;
            while (rs.next()) {
                if (num != rs.getInt("num")) {
                    num = rs.getInt("num");
                    
                    Gallery gallery = new Gallery();
                    
                    gallery.setNum(rs.getInt("num"));
                    gallery.setName(rs.getString("name"));
                    gallery.setSubject(rs.getString("subject"));
                    gallery.setContent(rs.getString("origincontent"));
                    gallery.setFilename(rs.getString("filename"));
                    gallery.setReg_date(rs.getTimestamp("origindate"));
                    
                    
                    
                    
                }
                
                
                
                
                if (rs.getString("rep_num") != null) {
                    Gallery_Reply reply = new Gallery_Reply();
                    reply.setNum(Integer.parseInt(rs.getString("rep_num")));
                    reply.setName(rs.getString("name"));
                    reply.setContent(rs.getString("replycontent"));
                    reply.setIp(rs.getString("ip"));
                    reply.setReg_date(rs.getTimestamp("replydate"));
                    
                    /*gallery.getRepList().add(reply);*/
                }
                
                /*list.add(gallery);*/
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    }
    
    
    // 갤러리 리스트 가져오기 
    public List<Gallery> getGalleryListWithLimit(int startRow, int pageSize) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Gallery> list = new ArrayList<Gallery>();
        String sql="";

        try {
            con = H2DB.getConnection();
            sql = "select * \r\n" + 
                    "from gallery \r\n" + 
                    "order by num desc \r\n" + 
                    "offset ? limit ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startRow-1);
            pstmt.setInt(2, pageSize);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                
                Gallery gallery = new Gallery();
                
                gallery.setNum(rs.getInt("num"));
                gallery.setName(rs.getString("name"));
                gallery.setSubject(rs.getString("subject"));
                gallery.setContent(rs.getString("content"));
                gallery.setReg_date(rs.getTimestamp("reg_date"));
                gallery.setIp(rs.getString("ip"));
                gallery.setFilename(rs.getString("filename"));
                
                list.add(gallery);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getGalleryListWithLimit()
    
    
    // 전체 갤러리 수  가져오기
    public int getGalleryCount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT COUNT(*) FROM gallery";
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
    
    // 갤러리 글 하나 가져오기
    public Gallery getGallery(int num) {        
          Connection con = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          String sql = "";
          Gallery gallery = null;
          
          try {
            con = H2DB.getConnection();
            // sql num에 해당하는 정보 가져오기
            sql = "SELECT * FROM gallery WHERE num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            // 실행  rs에 저장
            rs = pstmt.executeQuery();
            // rs 데이터 있으면 자바빈 객체생성
            // rs => 자바빈에 저장
            if (rs.next()) {
                // 자바빈 객체생성. 기억장소 할당
                gallery = new Gallery();
                gallery.setContent(rs.getString("content"));
                gallery.setFilename(rs.getString("filename"));
                gallery.setIp(rs.getString("ip"));
                gallery.setName(rs.getString("name"));
                gallery.setNum(rs.getInt("num"));
                gallery.setReg_date(rs.getTimestamp("reg_date"));
                gallery.setSubject(rs.getString("subject"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return gallery;
    } // getGallery()
    
    // 갤러리 글 수정하기
    public int updateGallery(Gallery gallery) {
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
            pstmt.setInt(1, gallery.getNum());
            // rs 실행  저장
            rs = pstmt.executeQuery();
            // rs데이터 있으면  패스워드비교  맞으면
            // update  num에 해당하는 name subject content 수정
            // check = 1 수정성공, 패스워드 틀리면  check = 0       
            if (rs.next()) {
                pstmt.close();
                pstmt = null;

                sql = "UPDATE gallery SET name=?, subject=?, content=?, filename=? WHERE num=?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, gallery.getName());
                pstmt.setString(2, gallery.getSubject());
                pstmt.setString(3, gallery.getContent());
                pstmt.setString(4, gallery.getFilename()); // 추가
                pstmt.setInt(5, gallery.getNum());
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
    }//updateBoard
    
    // 리플 개수 확인
    public int getGalleryReplyCount(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT COUNT(*) FROM gallery_reply where origin_num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
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
    
    // 인기글-답글이 많은 게시글
    public int getManyReplies() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql="";
        int num = 0;

        try {
            con = H2DB.getConnection();
            sql = "select origin_num, count(*) " + 
                  "from gallery_reply " + 
                  "group by origin_num " + 
                  "order by count(*) desc " + 
                  "offset 0 limit 1 ";
            
            pstmt = con.prepareStatement(sql);           
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                num = rs.getInt("origin_num");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return num;

    } // getManyReplies()
    
    
    // 인기글-좋아요가 많은 게시글
    public int getManyLikes() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Gallery gallery = null;
        String sql="";
        int num = 0;

        try {
            con = H2DB.getConnection();
            sql = "select num, count(*) " + 
                  "from gallerylike " + 
                  "group by num " + 
                  "order by num " + 
                  "offset 0 limit 1;";
            
            pstmt = con.prepareStatement(sql);           
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                num = rs.getInt("num");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return num;
    } // getManyLikes()
    
}
