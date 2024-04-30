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

public class DeleteProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("product_id");

        if (productId != null && !productId.isEmpty()) {

            HttpSession userSession = request.getSession();
            if (userSession.getAttribute("email") != null && AdminAuth.isAdminUser(userSession)) {
                try {
                    deleteProduct(productId);
                } catch (Exception e) {
                    System.out.println("Error: " + e.getMessage());
                }
            }
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    String DELETE_PRODUCT_STATEMENT = "DELETE FROM products WHERE product_id = ?";

    private void deleteProduct(String productId) {
        try {
            Connection conn = DBConnection.initializeDatabase();

            PreparedStatement deleteProductStmt = conn.prepareStatement(DELETE_PRODUCT_STATEMENT);
            deleteProductStmt.setString(1, productId);

            int rowsAffected = deleteProductStmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Product with ID " + productId + " deleted successfully.");
            } else {
                System.out.println("Product with ID " + productId + " not found or not deleted.");
            }

            // Close resources
            deleteProductStmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(DeleteProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeleteProductServlet.class.getName()).log(Level.SEVERE, null, ex);
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
