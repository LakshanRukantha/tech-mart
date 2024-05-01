package techmart;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import techmart.utils.DBConnection;
import techmart.utils.UserUtil;

@MultipartConfig // This annotation is needed for capture data other than "application/x-www-form-urlencoded"
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String PLACE_ORDER_STATEMENT = "INSERT INTO orders (product_id, ordering_email, user_email, quantity, price, address, name) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String GET_PRODUCT_STOCK_COUNT = "SELECT quantity FROM products WHERE product_id = ?";
        String REDUCE_ITEM_STATEMENT = "UPDATE products SET quantity = ? WHERE product_id = ?";

        PrintWriter pw = response.getWriter();
        HttpSession userSession = request.getSession();
        String userEmail = UserUtil.getUserEmail(userSession);
        if (userEmail != null && !userEmail.isEmpty()) {
            try {
                Connection conn = DBConnection.initializeDatabase();

                int productId = Integer.parseInt(request.getParameter("productId"));
                String fullName = request.getParameter("fullName");
                String orderEmail = request.getParameter("orderEmail");
                String orderAddress = request.getParameter("orderAddress");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                double productPrice = Double.parseDouble(request.getParameter("productPrice"));
                double price = quantity * productPrice;

                // Check product stock availability
                PreparedStatement getProductStockCountStmt = conn.prepareStatement(GET_PRODUCT_STOCK_COUNT);
                getProductStockCountStmt.setInt(1, productId);
                ResultSet rs = getProductStockCountStmt.executeQuery();

                int currentStock = 0;
                if (rs.next()) {
                    currentStock = rs.getInt("quantity");
                }

                if (quantity > currentStock) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    pw.println("Error: Insufficient stock!");
                    return;
                }

                // Proceed with order placement
                PreparedStatement placeOrderStmt = conn.prepareStatement(PLACE_ORDER_STATEMENT);
                placeOrderStmt.setInt(1, productId);
                placeOrderStmt.setString(2, orderEmail);
                placeOrderStmt.setString(3, userEmail);
                placeOrderStmt.setInt(4, quantity);
                placeOrderStmt.setDouble(5, price);
                placeOrderStmt.setString(6, orderAddress);
                placeOrderStmt.setString(7, fullName);

                int count = placeOrderStmt.executeUpdate();

                if (count <= 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    pw.println("Error: Order failed please try again later!");
                    return;
                }
                pw.println("Order placed successfully!");
                // Reduce stock count
                int newStock = currentStock - quantity;
                PreparedStatement reduceItemStmt = conn.prepareStatement(REDUCE_ITEM_STATEMENT);
                reduceItemStmt.setInt(1, newStock);
                reduceItemStmt.setInt(2, productId);
                reduceItemStmt.executeUpdate();

                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(PlaceOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(PlaceOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.sendRedirect("register.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
