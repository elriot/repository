package com.project.repository;

import java.sql.*;

public class H2DB {
        
    
    public static Connection getConnection() throws Exception {
        Connection con = null;

        // 1. �뱶�씪�씠踰� 濡쒕뵫
        Class.forName("org.h2.Driver");
        // 2 DB�뿰寃�
        // �뙆�씪 URL - jdbc:h2:~/test
        // �꽌踰� URL - jdbc:h2:tcp://localhost/~/test
        con = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/test", "sa", "");
        return con;

    }   

    public static void closeJDBC (Connection con, PreparedStatement pstmt
            , ResultSet rs) { 
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();// 而ㅻ꽖�뀡 ��留곸쓣 �띁�쓣�븣 close()�뒗 鍮뚮젮�삩 而ㅻ꽖�뀡�쓣 諛섎궔�븯�뒗 寃�
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } // closeJDBC()�쓽 �걹
}


