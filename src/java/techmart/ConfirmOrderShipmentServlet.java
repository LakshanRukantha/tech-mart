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

public class ConfirmOrderShipmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String orderId = request.getParameter("order_id");

        if (orderId != null && !orderId.isEmpty()) {

            HttpSession userSession = request.getSession();
            if (userSession.getAttribute("email") != null && AdminAuth.isAdminUser(userSession)) {
                try {
                    confirmOrderShipment(orderId);
                } catch (Exception e) {
                    System.out.println("Error: " + e.getMessage());
                }
            }
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
    
        String CONFIRM_ORDER_STATEMENT = "UPDATE orders SET is_shipped = true WHERE order_id = ?";

    private void confirmOrderShipment(String orderId) {
        try {
            Connection conn = DBConnection.initializeDatabase();

            PreparedStatement confirmOrderStmt = conn.prepareStatement(CONFIRM_ORDER_STATEMENT);
            confirmOrderStmt.setString(1, orderId);

            confirmOrderStmt.executeUpdate();
            
            // Close resources
            confirmOrderStmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(ConfirmOrderShipmentServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConfirmOrderShipmentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
