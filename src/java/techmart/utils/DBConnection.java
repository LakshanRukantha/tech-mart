 package techmart.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/techmart";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    // Initialize database connection
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Load the MySQL JDBC driver
        Class.forName(DB_DRIVER);

        // Obtain connection
        Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        return conn;
    }

    // Close database connection
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                // Handle or log any potential error while closing the connection
                e.printStackTrace();
            }
        }
    }
}
