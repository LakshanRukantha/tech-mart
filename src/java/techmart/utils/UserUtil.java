package techmart.utils;

import java.sql.Connection;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

public class UserUtil {
    public static String getUserEmail(HttpSession session) {
        if (session != null && session.getAttribute("email") != null) {
            return (String) session.getAttribute("email");
        }
        return null;
    }
public static String getUserName(String email) {
        if (email != null && !email.isEmpty()) {
            Connection conn = null;
            PreparedStatement getUserStmt = null;
            ResultSet rs = null;
            
            try {
                String GET_USER_STATEMENT = "SELECT name FROM users WHERE email=?";
                
                conn = DBConnection.initializeDatabase();

                getUserStmt = conn.prepareStatement(GET_USER_STATEMENT);
                getUserStmt.setString(1, email);

                rs = getUserStmt.executeQuery();

                if (rs.next()) {
                    return rs.getString("name");
                } else {
                    return null;
                }
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(UserUtil.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (getUserStmt != null) getUserStmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserUtil.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return null;
    }
}    

