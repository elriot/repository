package com.project.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.project.domain.Board;
import com.project.domain.Survey;

public class SurveyDao {
    
    private static final SurveyDao SURVEY_DAO = new SurveyDao();
    
    public static SurveyDao getInstance() {
        return SURVEY_DAO;
    }
    
    private SurveyDao() {
        createTableIfNotExists();
    }
    
    private void createTableIfNotExists() {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            
            sql = "create table if not exists survey ( " + 
                    "  num integer primary key, " +
                    "  id varchar(20), " +
                    "  reg_date varchar(50), " +
                    "  readcount integer, " +
                    "  finished varchar(20), " +
                    "  question varchar(50), " +
                    "  answer1 varchar(50), " +
                    "  answer2 varchar(50), " +
                    "  answer3 varchar(50), " +
                    "  answer4 varchar(50), " +
                    "  answer5 varchar(50) " +
                    ") ";
            
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // createTableIfNotExists()
    
    
    
    public void insertSurvey(Survey survey) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null; // DB에서 글 번호를 가져옴
        String sql = "";
        int num = 0; //글번호
        
        try {
            con = H2DB.getConnection();
            // 글번호 num구하기. 글이 없을경우 1
            // 글이 있는경우 최근글번호(번호가 가장 큰 값) + 1
            sql = "SELECT MAX(num) FROM Survey";
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
            sql = "INSERT INTO survey (num, id, reg_date, readcount,"
                    + " finished, question, answer1, answer2, answer3, answer4, "
                    + "answer5) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // 글번호
            pstmt.setString(2, survey.getId());
            pstmt.setTimestamp(3, survey.getReg_date());
            pstmt.setInt(4, 0);
            pstmt.setString(5, "no");
            pstmt.setString(6, survey.getQuestion());
            pstmt.setString(7, survey.getAnswer1());
            pstmt.setString(8, survey.getAnswer2());
            pstmt.setString(9, survey.getAnswer3());
            pstmt.setString(10, survey.getAnswer4());
            pstmt.setString(11, survey.getAnswer5());

            pstmt.executeUpdate();
                        
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
    } //insertSurvey()
    
    
    public List<Survey> getSurveysWithLimit(int startRow, int pageSize) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Survey> list = new ArrayList<Survey>();
        // 자주 일어나는 문자 연결에 대해서 String과는 다르게 쓰레기 객체를 생성하지 않음
        String sql="";

        try {
            con = H2DB.getConnection();
            sql = "select * " + 
                    "from survey " + 
                    "where finished='no' " +
                    "order by num desc " + 
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
                Survey survey = new Survey();
                // rs => 자바빈 저장
                survey.setNum(rs.getInt("num"));
                survey.setId(rs.getString("id"));
                survey.setReg_date(rs.getTimestamp("reg_date"));
                survey.setReadcount(rs.getInt("readcount"));
                survey.setFinished(rs.getString("finished"));
                survey.setQuestion(rs.getString("question"));
                survey.setAnswer1(rs.getString("answer1"));
                survey.setAnswer2(rs.getString("answer2"));
                survey.setAnswer3(rs.getString("answer3"));
                survey.setAnswer4(rs.getString("answer4"));
                survey.setAnswer5(rs.getString("answer5"));

                // 자바빈 => list 한칸 추가
                list.add(survey);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getSurveysWithLimit()
    
    public List<Survey> getFinishedSurveyWithLimit(int startRow, int pageSize) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Survey> list = new ArrayList<Survey>();
        // 자주 일어나는 문자 연결에 대해서 String과는 다르게 쓰레기 객체를 생성하지 않음
        String sql="";

        try {
            con = H2DB.getConnection();
            sql = "select * " + 
                    "from survey " + 
                    "where finished='yes' " +
                    "order by num desc " + 
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
                Survey survey = new Survey();
                // rs => 자바빈 저장
                survey.setNum(rs.getInt("num"));
                survey.setId(rs.getString("id"));
                survey.setReg_date(rs.getTimestamp("reg_date"));
                survey.setReadcount(rs.getInt("readcount"));
                survey.setFinished(rs.getString("finished"));
                survey.setQuestion(rs.getString("question"));
                survey.setAnswer1(rs.getString("answer1"));
                survey.setAnswer2(rs.getString("answer2"));
                survey.setAnswer3(rs.getString("answer3"));
                survey.setAnswer4(rs.getString("answer4"));
                survey.setAnswer5(rs.getString("answer5"));

                // 자바빈 => list 한칸 추가
                list.add(survey);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }       
        return list;
    } // getFinishedSurveyWithLimit()
    
    
    
    // 투표가 완료되지않은 글 개수 가져오기
    public int getSurveyingCount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT COUNT(*) FROM survey where finished='no' ";
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
    
    // 투표가 완료된 글 개수 가져오기
    public int getSurveyFinishedCount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int count = 0;
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT COUNT(*) FROM survey where finished='yes' ";
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
    
    
    // 조회수 1올리기
    public void updateReadCount(int num){
       Connection con = null;
       PreparedStatement pstmt = null;
       String sql = "";
       
       try {
           con = H2DB.getConnection();
           //sql update num에 해당하는 Readcount 1증가 하게 수정
           // (기존값에서 +1)
           sql = "UPDATE survey SET readcount = readcount+1  WHERE num=?";
           pstmt = con.prepareStatement(sql);
           pstmt.setInt(1, num);
           pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // updateReadCount
    
    
    
    public Survey getSurvey(int num) {               
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        Survey survey = null;
        
        try {
          con = H2DB.getConnection();
          // sql num에 해당하는 정보 가져오기
          sql = "SELECT * FROM survey WHERE num=?";
          pstmt = con.prepareStatement(sql);
          pstmt.setInt(1, num);
          // 실행  rs에 저장
          rs = pstmt.executeQuery();
          // rs 데이터 있으면 자바빈 객체생성
          // rs => 자바빈에 저장
          if (rs.next()) {
              // 자바빈 객체생성. 기억장소 할당
              survey = new Survey();
              survey.setNum(rs.getInt("num"));
              survey.setId(rs.getString("id"));
              survey.setReg_date(rs.getTimestamp("reg_date"));
              survey.setReadcount(rs.getInt("readcount"));
              survey.setFinished(rs.getString("finished"));
              survey.setQuestion(rs.getString("question"));
              survey.setAnswer1(rs.getString("answer1"));
              survey.setAnswer2(rs.getString("answer2"));
              survey.setAnswer3(rs.getString("answer3"));
              survey.setAnswer4(rs.getString("answer4"));
              survey.setAnswer5(rs.getString("answer5"));
          }
      } catch (Exception e) {
          e.printStackTrace();
      } finally {
          H2DB.closeJDBC(con, pstmt, rs);
      }
      return survey;
  } // getSurvey()
    
    // 설문 마감하기
    public void finishSurvey(int num){
       Connection con = null;
       PreparedStatement pstmt = null;
       String sql = "";
       
       try {
           con = H2DB.getConnection();
           //
           sql = "UPDATE survey SET finished='yes' WHERE num=?";
           pstmt = con.prepareStatement(sql);
           pstmt.setInt(1, num);
           pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, null);
        }
    } // finishSurvey
    
    
 
    // 설문조사 글 삭제
    public void deleteSurvey(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();

            sql = "DELETE FROM survey WHERE num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            // 실행
            pstmt.executeUpdate();
            
            
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                H2DB.closeJDBC(con, pstmt, null);
        }      
        
    } //deleteSurvey
    
 // 글 읽었을때 surveyCount 테이블이 없으면 추가
    public void insertIntoCountTable(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            con = H2DB.getConnection();
            // sql 전체 글 개수 가져오기
            sql = "SELECT * FROM surveycount where num=? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            // 실행  rs
            rs = pstmt.executeQuery();
            // rs에 데이터 가 있으면 count 저장         
            if(!rs.next()) {
                pstmt.close();
                pstmt = null;
                sql = null;

                sql = "insert into surveycount values (?, 0, 0, 0, 0, 0) ";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, num);
                pstmt.executeUpdate();
            }                          
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            H2DB.closeJDBC(con, pstmt, rs);
        }              
    }// insertIntoCountTable

}
