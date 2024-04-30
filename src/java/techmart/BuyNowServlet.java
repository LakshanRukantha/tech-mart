package techmart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import techmart.utils.DBConnection;
import techmart.utils.UserUtil;

public class BuyNowServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    String GET_PRODUCT_INFO = "SELECT * FROM products WHERE product_id=?";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int selectedProductId = Integer.parseInt(request.getParameter("product_id"));
        HttpSession userSession = request.getSession();
        String userEmail = UserUtil.getUserEmail(userSession);

        if (userEmail != null && !userEmail.isEmpty()) {
            try {
                Connection conn = DBConnection.initializeDatabase();
                PreparedStatement buyProductStmt = conn.prepareStatement(GET_PRODUCT_INFO);

                buyProductStmt.setInt(1, selectedProductId);

                ResultSet rs = buyProductStmt.executeQuery();

                Product product = null;
                if (rs.next()) {
                    int productId = rs.getInt("product_id");
                    String productName = rs.getString("name");
                    String description = rs.getString("description");
                    String imageUrl = rs.getString("image_url");
                    String price = rs.getString("price");
                    int quantity = rs.getInt("quantity");

                    product = new Product(productId, productName, description, imageUrl, price, quantity);
                }

                request.setAttribute("product", product);
                System.out.println(product.getProductName());
                RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
                dispatcher.forward(request, response);

            } catch (SQLException ex) {
                Logger.getLogger(BuyNowServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(BuyNowServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/register.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
