package com.project.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.project.domain.Member;
import com.project.domain.Omember;

public class OmemberDao {
  
    private static final OmemberDao OMEMBER_DAO = new OmemberDao();   
    
    public static OmemberDao getInstance() {
        return OMEMBER_DAO;
    }
    
    private OmemberDao() {
        createTableIfNotExists();
    }
    
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql  ="";
       
        try {
            con = H2DB.getConnection();
            sql =  "create table if not exists omember (" + 
                    "id varchar(20), " + 
                    "passwd varchar(20), " + 
                    "battletag varchar(20), " + 
                    "gender varchar(20), " + 
                    "email varchar(50), " + 
                    "playmain varchar(20), " + 
                    "birthday varchar(20), " + 
                    "reg_date timestamp, " + 
                    "approved varchar(20) " + 
                    ") ";
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
                    
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // createTableIfNotExists()
    
    
    // 회원 테이블에 추가
    public void insertMember (Omember omember) {
       
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try { // 
            con = H2DB.getConnection();
            String sql = "INSERT INTO omember (id, passwd, battletag, "
                    + "gender, email, playmain, birthday, reg_date, approved) "
                    + "values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, omember.getId());
            pstmt.setString(2, omember.getPasswd());
            pstmt.setString(3, omember.getBattletag());
            pstmt.setString(4, omember.getGender());
            pstmt.setString(5, omember.getEmail());
            pstmt.setString(6, omember.getPlaymain());
            pstmt.setString(7, omember.getBirthday());
            pstmt.setTimestamp(8, omember.getReg_date());
            if(omember.getId().equals("admin")) {
                pstmt.setString(9, "yes");
            } else {
                pstmt.setString(9, "no");
            }
            
            
           
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();    
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // insertMember
    
    // id 중복 체크
    public int idCheck(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int check = 0; 
        
        try {
            con = H2DB.getConnection();
            sql = "SELECT * FROM omember WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                check = 0;  
            } else {
                check = 1;  
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return check;
    } // idCheck()
    
    
    public String approvedCheck(String id) {

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String approvedCheck = ""; 

        try {
            con = H2DB.getConnection(); 
            String sql = "SELECT approved FROM omember WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                approvedCheck = rs.getString("approved");
            } else {
                approvedCheck = "noSignedId";
            }
         
                    
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
       
        return approvedCheck;
    } // userCheck()
    
    // 회원 한명 정보 가져오기
    public Omember getOmember(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Omember omember = null;
        try {
            con = H2DB.getConnection(); 

            String sql = "SELECT * FROM omember WHERE id=? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);         
            rs = pstmt.executeQuery();            

            if (rs.next()){
                omember = new Omember();
                omember.setId(rs.getString("id"));
                omember.setPasswd(rs.getString("passwd"));
                omember.setBattletag(rs.getString("battletag"));
                omember.setGender(rs.getString("gender"));
                omember.setEmail(rs.getString("email"));
                omember.setPlaymain(rs.getString("playmain"));
                omember.setBirthday(rs.getString("birthday"));
                omember.setReg_date(rs.getTimestamp("reg_date"));
                omember.setApproved(rs.getString("approved"));
            }               
        } catch (Exception e) {     
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return omember;
    } // getOmember
    
    // 회원 아이디, 비밀번호 체크 - 로그인
    public int userCheck(String id, String passwd) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int check = 0; 

        try {
            con = H2DB.getConnection(); // 
            String sql = "SELECT passwd FROM omember WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                
                if (passwd.equals(rs.getString("passwd"))) {
                    check = 1; // 비밀번호 일치
                } else {
                    check = 0; // 비밀번호 일치하지 않음
                }
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return check;
    } // userCheck()
    
    
    // 회원 정보 수정
    public void updateOmember(Omember omember) {
  
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = H2DB.getConnection();
            

            String sql = "SELECT * FROM omember WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, omember.getId());

            rs = pstmt.executeQuery();

            if (rs.next()){
                if(omember.getPasswd().equals(rs.getString("passwd"))){
                    pstmt.close(); // 
                    pstmt = null;
                    sql = "UPDATE omember SET battletag=?, gender=?, playmain=?, birthday=?, email=? WHERE id=?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, omember.getBattletag());
                    pstmt.setString(2, omember.getGender());
                    pstmt.setString(3, omember.getPlaymain());
                    pstmt.setString(4, omember.getBirthday());
                    pstmt.setString(5, omember.getEmail());
                    pstmt.setString(6, omember.getId());

                    pstmt.executeUpdate();

                } else {

                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }   

    } // updateOmember
    
    
    // 가입 승인된 회원 목록
    public List<Omember> getApprovedMembers(){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Omember> list = new ArrayList<Omember>();
        
        try {
            con = H2DB.getConnection();

            String sql = "SELECT * FROM omember where approved=? order by reg_date asc";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "yes");

            rs = pstmt.executeQuery();
            

            while(rs.next()){
                Omember omember = new Omember();
                omember.setId(rs.getString("id"));
                omember.setPasswd(rs.getString("passwd"));
                omember.setBattletag(rs.getString("battletag"));
                omember.setGender(rs.getString("gender"));
                omember.setEmail(rs.getString("email"));
                omember.setPlaymain(rs.getString("playmain"));
                omember.setBirthday(rs.getString("birthday"));
                omember.setReg_date(rs.getTimestamp("reg_date"));
                omember.setApproved(rs.getString("approved"));
                list.add(omember); 
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }    
        return list;
    }// getMembers()
    
    // 가입 승인 되지 않은 회원목록
    public List<Omember> getNotApprovedMembers(){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Omember> list = new ArrayList<Omember>();
        
        try {
            con = H2DB.getConnection();

            String sql = "SELECT * FROM omember where approved=? order by reg_date asc";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "no");

            rs = pstmt.executeQuery();

            while(rs.next()){
                Omember omember = new Omember();
                omember.setId(rs.getString("id"));
                omember.setPasswd(rs.getString("passwd"));
                omember.setBattletag(rs.getString("battletag"));
                omember.setGender(rs.getString("gender"));
                omember.setEmail(rs.getString("email"));
                omember.setPlaymain(rs.getString("playmain"));
                omember.setBirthday(rs.getString("birthday"));
                omember.setReg_date(rs.getTimestamp("reg_date"));
                omember.setApproved(rs.getString("approved"));
                list.add(omember);
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }    
        return list;
    }// getMembers()
    
    
    // 가입 승인 처리하기 
    public void setApprovedOmember(Omember omember) {   	  
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = H2DB.getConnection();

            String sql = "UPDATE omember SET approved=? WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "yes");
            pstmt.setString(2, omember.getId());

            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }   
    } // setApprovedOmember
    
    
    // 회원 탈퇴
    public void withdrawalMember(Omember omember) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = H2DB.getConnection();

            String sql = "SELECT * FROM omember WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, omember.getId()); 

            rs = pstmt.executeQuery();

            
            if(rs.next()){
                pstmt.close();
                pstmt = null;
                sql = "DELETE FROM omember WHERE id=?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, omember.getId());
                pstmt.executeUpdate();
                
            }
        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }

    } // deleteMember()
    
    public List<String> getEmailList(){
               
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<String> list = new ArrayList<String>();
        String email = "";
        
        try {
            con = H2DB.getConnection();

            String sql = "SELECT email FROM omember WHERE approved=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "yes"); 

            rs = pstmt.executeQuery();
            
            while (rs.next()){
                email = rs.getString(1);
                list.add(email);                
            }
        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }     
        
        return list;
    }
    
    // 통계결과 1.
    public List<Map> getCountPlaymain(){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Map> mapList = new ArrayList<Map>();
        Map<Object, Object> map = null;
        String playmain = "";
        Integer count = 0;     
        
        try {
            con = H2DB.getConnection();

            String sql = "select playmain, count(*) count from omember where approved='yes' group by playmain order by count desc ";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            

            while(rs.next()){
                map = new HashMap<Object, Object>();
                playmain = rs.getString(1);
                count = rs.getInt(2);
               
                map.put("playmain", playmain);
                map.put("count", count);
                mapList.add(map);
                
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }    
        return mapList;
    }// getCountPlaymain()
    
    // 통계결과 2.
    public List<Map> getCountGender(){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Map> mapList = new ArrayList<Map>();
        Map<Object, Object> map = null;
        String playmain = "";
        Integer count = 0;     
        
        try {
            con = H2DB.getConnection();

            String sql = "select gender, count(*) count from omember where approved='yes' group by gender order by count desc ";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            

            while(rs.next()){
                map = new HashMap<Object, Object>();
                playmain = rs.getString(1);
                count = rs.getInt(2);
               
                map.put("gender", playmain);
                map.put("count", count);
                mapList.add(map);
                
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }    
        return mapList;
    }// getCountPlaymain()
    
    
    // 포지션별 집계 결과 JSON
    @SuppressWarnings("unchecked")
    public JSONArray getCountPlaymainJSON() {
        JSONArray jsonArray = new JSONArray();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = H2DB.getConnection();
            String sql = "select playmain, count(*) count from omember where approved='yes' group by playmain order by count desc ";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            JSONArray arrColumn = new JSONArray();
            arrColumn.add("playmain");
            arrColumn.add("count");
            jsonArray.add(arrColumn);
            

            while(rs.next()) {
                JSONArray arrRecord = new JSONArray();
                arrRecord.add(rs.getString("playmain"));
                arrRecord.add(rs.getInt("count"));
                
                jsonArray.add(arrRecord);              
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }    

        return jsonArray;
    }
    
    
    // 성별 집계 결과 JSON
    @SuppressWarnings("unchecked")
    public JSONArray getCountGenderJSON() {
        JSONArray jsonArray = new JSONArray();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = H2DB.getConnection();
            String sql = "select gender, count(*) count from omember where approved='yes' group by gender order by count desc ";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            JSONArray arrColumn = new JSONArray();
            arrColumn.add("gender");
            arrColumn.add("count");
            jsonArray.add(arrColumn);
            

            while(rs.next()) {
                JSONArray arrRecord = new JSONArray();
                arrRecord.add(rs.getString("gender"));
                arrRecord.add(rs.getInt("count"));
                
                jsonArray.add(arrRecord);              
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }    
        
        return jsonArray;
    }
    
    
    // 웰컴리스트(최근 가입 승인된 순)
    public List<String> getWelcomeMembers(){
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<String> list = new ArrayList<String>();
        String id = "";
        
        try {
            con = H2DB.getConnection();

            String sql = "select id from omember where approved='yes' order by reg_date desc offset 0 limit 3 ";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()){
                id = rs.getString(1);
                list.add(id);                
            }
        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }     
        
        return list;
    } // getWelcomeMembers
    


}
