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

public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String ADD_TO_CART_STATEMENT = "INSERT INTO cart(user_email, product_id) VALUES(?,?)";
            String productId = request.getParameter("product_id");
            HttpSession userSession = request.getSession();
            String userEmail = UserUtil.getUserEmail(userSession);
            
            Connection conn = DBConnection.initializeDatabase();
            
            PreparedStatement addToCartStmt = conn.prepareStatement(ADD_TO_CART_STATEMENT);
            addToCartStmt.setString(1, userEmail);
            addToCartStmt.setString(2, productId);
            
            addToCartStmt.executeUpdate();
            
            response.sendRedirect("./cart.jsp");
            
        } catch (SQLException ex) {
            Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
