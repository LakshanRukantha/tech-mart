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
import techmart.utils.DBConnection;
import techmart.utils.UserUtil;

public class DeleteFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String DELETE_FROM_CART_STATEMENT = "DELETE FROM cart WHERE product_id=?";
            String productId = request.getParameter("product_id");
            HttpSession userSession = request.getSession();
            String userEmail = UserUtil.getUserEmail(userSession);
            
            if(userEmail != null){
                Connection conn = DBConnection.initializeDatabase();
            
            PreparedStatement deleteFromCartStmt = conn.prepareStatement(DELETE_FROM_CART_STATEMENT);
            deleteFromCartStmt.setString(1, productId);
            
            deleteFromCartStmt.executeUpdate();
            }
            
            response.sendRedirect("./cart.jsp");
            
        } catch (SQLException ex) {
            Logger.getLogger(DeleteFromCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeleteFromCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
