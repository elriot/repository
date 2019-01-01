package com.project.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.project.repository.H2DB;
import com.project.domain.Gallery;
import com.project.domain.Gallery_Reply;

public class Gallery_ReplyDao {
    
    private static final Gallery_ReplyDao GALLERY_REPLYDAO = new Gallery_ReplyDao();
    
    public static Gallery_ReplyDao getInstance() {
        return GALLERY_REPLYDAO;
    }
    
    // 기본생성자 : 갤러리 테이블이 존재하지 않으면 생성하는 메소드 호출
    private Gallery_ReplyDao() {
        createTableIfNotExists();
        
    }
    
    // 테이블 존재하지 않으면 생성
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "create table if not exists gallery_reply ( " + 
                    "  num int primary key, " +
                    "  origin_num int, " +
                    "  name varchar(20), " +
                    "  reg_date timestamp, " +
                    "  content varchar(2000), " +
                    "  ip varchar(20), " +
                    "  re_ref int, " +
                    "  re_lev int, " +
                    "  re_seq int " +
                    ") ";
            
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // createTableIfNotExists()
    
    
    // 답글 추가
    public void insertGalleryReply(Gallery_Reply gallery_reply, int originNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int num = 0; 
        
        try {
            con = H2DB.getConnection();
            
            sql = "SELECT MAX(num) FROM gallery_reply";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            
            if(rs.next()) {                
                num = rs.getInt(1) + 1; 
            } else {
                num = 1;
            }
            pstmt.close();
            rs.close();

            sql = "INSERT INTO gallery_reply (num, origin_num, name, content,"
                    + " ip, re_ref, re_lev, re_seq, reg_date) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // 글번호
            pstmt.setInt(2, originNum);
            pstmt.setString(3, gallery_reply.getName());
            pstmt.setString(4, gallery_reply.getContent());
            pstmt.setString(5, gallery_reply.getIp());
            pstmt.setInt(6, originNum);
            pstmt.setInt(7, 0);
            pstmt.setInt(8, 0);
            pstmt.setTimestamp(9, gallery_reply.getReg_date());
            pstmt.executeUpdate();
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    }
    
    // 글 하나에 해당하는 리플 리스트 가져오기
    public List<Gallery_Reply> getGalleryReplyListWithLimit(int startRow, int pageSize) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Gallery_Reply> list = new ArrayList<Gallery_Reply>();
        String sql="";

        try {
            con = H2DB.getConnection();
            sql = "select * " + 
                    "from gallery_reply " + 
                    "order by num desc " + 
                    "offset ? limit ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startRow-1);
            pstmt.setInt(2, pageSize);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                
                Gallery_Reply reply = new Gallery_Reply();
                
              
                reply.setNum(rs.getInt("num"));
                reply.setName(rs.getString("name"));
                reply.setContent(rs.getString("content"));
                reply.setReg_date(rs.getTimestamp("reg_date"));
                reply.setIp(rs.getString("ip"));
                reply.setOrigin_num(rs.getInt("origin_num"));
                reply.setRe_ref(rs.getInt("re_ref"));
                reply.setRe_lev(rs.getInt("re_lev"));
                reply.setRe_seq(rs.getInt("re_seq"));
                
                
                list.add(reply);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getGalleryListWithLimit()
    
 // 글 하나에 해당하는 리플 리스트 가져오기
    public List<Gallery_Reply> getGalleryReplyList(int originNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Gallery_Reply> list = new ArrayList<Gallery_Reply>();
        String sql="";

        try {
            con = H2DB.getConnection();
            sql = "select * " + 
                    "from gallery_reply " + 
                    "where origin_num=?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, originNum);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                
                Gallery_Reply reply = new Gallery_Reply();
                
              
                reply.setNum(rs.getInt("num"));
                reply.setName(rs.getString("name"));
                reply.setContent(rs.getString("content"));
                reply.setReg_date(rs.getTimestamp("reg_date"));
                reply.setIp(rs.getString("ip"));
                reply.setOrigin_num(rs.getInt("origin_num"));
                reply.setRe_ref(rs.getInt("re_ref"));
                reply.setRe_lev(rs.getInt("re_lev"));
                reply.setRe_seq(rs.getInt("re_seq"));
                
                
                list.add(reply);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getGalleryReplyList()
    
    

    // 자바의 array를 JSON array로 맵핑되도록 가져오는 형태
    public JSONArray getReplyJSON(int originNum) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        JSONArray jsonArray = new JSONArray();
        
        try {
            con = H2DB.getConnection();
            // 해당 글 번호의
            String sql = "SELECT * FROM gallery_reply where origin_num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, originNum);
            // 3. rs 저장
            rs = pstmt.executeQuery();
            
            while(rs.next()){
                // JSONObject는 Map을 구현. HashMap과 동일하게 사용
                JSONObject obj = new JSONObject();
                // rs => JSONObject에 저장
                // Key : 멤버변수 이름, Value : 실제 데이터 값
                // 자료타입을 String 형태로 가져오는것이 안전함
                obj.put("num", rs.getString("num"));
                obj.put("origin_num", rs.getString("origin_num"));
                obj.put("name", rs.getString("name"));
                obj.put("content", rs.getString("content"));
                obj.put("ip", rs.getString("ip"));
                obj.put("reg_date", rs.getString("reg_date"));
                obj.put("re_ref", rs.getString("re_ref"));
                obj.put("re_lev", rs.getString("re_lev"));
                obj.put("re_seq", rs.getString("re_seq"));
                
                //JSONObject=> JSONArray에 한개 추가
                jsonArray.add(obj);
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }    
        return jsonArray;
    }// getMembers()
    
    // 리플을  JSON 객체로


}
