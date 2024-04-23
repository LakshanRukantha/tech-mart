package techmart.libs;

import java.sql.Connection; 
import java.sql.DriverManager; 
import java.sql.SQLException;

public class DBConnection {
    public static Connection initializeDatabase() 
        throws SQLException, ClassNotFoundException 
    { 
        // Initialize all the information regarding 
        // Database Connection 
        String dbDriver = "com.mysql.cj.jdbc.Driver"; 
        String dbURL = "jdbc:mysql://localhost:3306/"; 
        // Database name to access 
        String dbName = "techmart"; 
        String dbUsername = "root"; 
        String dbPassword = "";
  
        Class.forName(dbDriver); 
        Connection conn = DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword); 
        return conn; 
    } 
}
