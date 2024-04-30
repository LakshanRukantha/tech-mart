package techmart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import techmart.utils.AdminAuth;
import techmart.utils.DBConnection;

public class DeleteUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        
        if (userId != null && !userId.isEmpty()) {
            
            HttpSession userSession = request.getSession();
            if(userSession.getAttribute("email") != null && AdminAuth.isAdminUser(userSession)){
                try{
                    deleteUser(userId);
                }catch(Exception e){
                    System.out.println("Error: " + e.getMessage());
                }
            }
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        }
    }

    String DELETE_USER_STATEMENT = "DELETE FROM users WHERE user_id = ?";
    
    private void deleteUser(String userId) {
        try {
            Connection conn = DBConnection.initializeDatabase();
            
            PreparedStatement deleteUserStmt = conn.prepareStatement(DELETE_USER_STATEMENT);
            deleteUserStmt.setString(1, userId);
            
            int rowsAffected = deleteUserStmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("User with ID " + userId + " deleted successfully.");
            } else {
                System.out.println("User with ID " + userId + " not found or not deleted.");
            }
            
            // Close resources
            deleteUserStmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(DeleteUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeleteUser.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
