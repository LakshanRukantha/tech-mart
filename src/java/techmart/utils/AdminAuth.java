package techmart.utils;

import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminAuth {
     public static final String ADMIN_ROLE = "admin";

    public static boolean isAdminUser(HttpSession session) {

        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null || userEmail.isEmpty()) {
            return false;
        }

        String userRole = getUserRoleFromDatabase(userEmail);

        // Check if user role is admin
        return ADMIN_ROLE.equals(userRole);
    }

    // Method to fetch user role from database based on email
    private static String getUserRoleFromDatabase(String userEmail) {
        String userRole = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.initializeDatabase();
            String query = "SELECT role FROM users WHERE email = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, userEmail);
            rs = stmt.executeQuery();
            if (rs.next()) {
                userRole = rs.getString("role");
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return userRole;
    }
}
