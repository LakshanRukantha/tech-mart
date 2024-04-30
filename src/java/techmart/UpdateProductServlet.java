package techmart;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import techmart.utils.DBConnection;

public class UpdateProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                response.setContentType("text/html;charset=UTF-8");
        PrintWriter pw = response.getWriter();
        String PRODUCT_UPDATE_STATEMENT = "UPDATE products SET name=?, description=?, price=?, quantity=? WHERE product_id=?";

        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        String productPrice = request.getParameter("productPrice");
        String productQuantity = request.getParameter("productQuantity");

        if (productId.isEmpty() || productName.isEmpty() || productDescription.isEmpty() || productPrice.isEmpty() || productQuantity.isEmpty()){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().println("Error: Missing or invalid some product values!");
            return;
        } else {
            try {
                Connection conn = DBConnection.initializeDatabase();
                PreparedStatement productUpdateStmt = conn.prepareStatement(PRODUCT_UPDATE_STATEMENT);

                productUpdateStmt.setString(1, productName);
                productUpdateStmt.setString(2, productDescription);
                productUpdateStmt.setString(3, productPrice);
                productUpdateStmt.setString(4, productQuantity);
                productUpdateStmt.setString(5, productId);

                int rowsAffected = productUpdateStmt.executeUpdate();

                if (rowsAffected <= 0) {
                    request.setAttribute("statusMessage", "Registration Failed!");
                    request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                } else {
                   response.sendRedirect("dashboard.jsp");
                }

            } catch (SQLException ex) {
                
                pw.println(ex.getMessage());
            } catch (ClassNotFoundException ex) {
                // Log the error or provide feedback to the user
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
