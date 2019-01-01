package com.project.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import com.project.domain.GalleryLike;

public class GalleryLikeDao {
    
    private static final GalleryLikeDao LIKE_DAO = new GalleryLikeDao();
    
    public static GalleryLikeDao getInstance() {
        return LIKE_DAO;
    }
    
    // 기본생성자 : 좋아요 테이블이 없으면 생성
    private GalleryLikeDao() {
        createTableIfNotExists();
        
    }
    
    // 테이블 존재하지 않으면 생성
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "create table if not exists gallerylike ( " + 
                    "  num int, " +
                    "  name varchar(20) " +
                    ") ";
            
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // createTableIfNotExists()
    
    // 해당 게시물에 좋아요 한 적 있는지 확인후 있으면 1리턴 없으면 0리턴 
    public int getLikeCheck(String id, int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            sql = "SELECT count(*) from GALLERYLIKE where num=? and name=? ";
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
    
    
    // 좋아요 개수 확인
    public int getLikeCount(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT COUNT(*) FROM gallerylike where num=? ";
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
    
    
    // 좋아요 추가
    public void addLike(int num, String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            sql = "insert into gallerylike values (?, ?) ";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // 글번호
            pstmt.setString(2, id);
            pstmt.executeUpdate();
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    } //addLike()
    
    // 좋아요 삭제
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
    

}
