package com.project.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.project.domain.Board;
import com.project.domain.SurveyCount;

public class SurveyCountDao {
    
 private static final SurveyCountDao SURVEYCOUNT_DAO = new SurveyCountDao();
    
    public static SurveyCountDao getInstance() {
        return SURVEYCOUNT_DAO;
    }
    
    private SurveyCountDao() {
        createTableIfNotExists();
    }
    
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "create table if not exists surveycount ( " + 
                    "  num integer primary key, " +
                    "  count1 integer, " +
                    "  count2 integer, " +
                    "  count3 integer, " +
                    "  count4 integer, " +
                    "  count5 integer, " +
                    "  foreign key (num) references survey(num) on delete cascade " + 
                    ") ";
            
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // createTableIfNotExists()
    
    
    // 투표수  확인
    public int getSurveyCount(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT COUNT(*) FROM surveycount where num=? ";
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
    } //getLikeCount     
    
    // 투표수 업데이트
    public void addCountSurvey(int num, String radioValue) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int addCount=0;
        
        try {
            con = H2DB.getConnection();
            sql = "SELECT * FROM surveycount where num=? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);

            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                addCount = rs.getInt(radioValue) + 1; 
                
            }              
            
            pstmt.close();
            pstmt = null;
            sql = null;
            sql = "UPDATE surveycount SET "+radioValue+"=? WHERE num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, addCount);
            pstmt.setInt(2, num);
            pstmt.executeUpdate();
                  
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    } //addCountSurvey()
    
    // 투표수 업데이트
    public void deleteLike(int num, String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            sql = "DELETE FROM gallerylike WHERE num=? AND name=? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.setString(2, id);
            pstmt.executeUpdate();
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    } //insertGallery()
    
    // 설문조사 결과 가져오기
    public SurveyCount getSurveyResult(int num) {        
          Connection con = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          String sql = "";
          SurveyCount count  = null;
          
          try {
            con = H2DB.getConnection();

            sql = "SELECT * FROM surveycount WHERE num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            

            rs = pstmt.executeQuery();


            if (rs.next()) {

                count = new SurveyCount();
                count.setNum(rs.getInt("num"));
                count.setCount1(rs.getInt("count1"));
                count.setCount2(rs.getInt("count2"));
                count.setCount3(rs.getInt("count3"));
                count.setCount4(rs.getInt("count4"));
                count.setCount5(rs.getInt("count5"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return count;
    } // getSurveyCount()
    
    // 해당 게시글 총 투표수 가져오기
    public int getSurveyTotalCount(int num) {        
          Connection con = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          String sql = "";
          int count = 0;
          
          try {
            con = H2DB.getConnection();

            sql = "select sum(count1+count2+count3+count4+count5) sum from surveycount where num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            

            rs = pstmt.executeQuery();


            if (rs.next()) {
                count = rs.getInt(1);


            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return count;
    } // getSurveyTotalCount()

}
