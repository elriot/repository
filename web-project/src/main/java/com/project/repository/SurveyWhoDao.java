package com.project.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SurveyWhoDao {
    private static final SurveyWhoDao SURVEYWHO_DAO = new SurveyWhoDao();
    
    public static SurveyWhoDao getInstance() {
        return SURVEYWHO_DAO;
    }
    
    // 기본생성자 : 좋아요 테이블이 없으면 생성
    private SurveyWhoDao() {
        createTableIfNotExists();
        
    }
    
    // 테이블 존재하지 않으면 생성
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "create table if not exists surveywho ( " + 
                    "  num integer, " +
                    "  id varchar(20), " +
                    "  vote integer, " +
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
    
    // 해당 게시물에 투표 한 적 있는지 확인후 있으면 1리턴 없으면 0리턴 
    public int getSurveyCheck(String id, int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            sql = "SELECT count(*) from surveywho where num=? and id=? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.setString(2, id);
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
    
    
    // 투표결과 저장
    public void addVote(int num, String id, int count) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            sql = "insert into surveywho values (?, ?, ?) ";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // 글번호
            pstmt.setString(2, id);
            pstmt.setInt(3, count);
            pstmt.executeUpdate();
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    } //addVote()
    
    // 투표결과 가져오기
    public int getUserVoteResult(int num, String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int userVote=0;
        
        try {
            con = H2DB.getConnection();
            sql = "select vote from surveywho where id=? and num=? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setInt(2, num);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                userVote = rs.getInt(1);
            }
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }
        return userVote;
    } //userVoteResult()
    

    
    
}
