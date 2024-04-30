package techmart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import techmart.utils.DBConnection;

@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {
    
    private static final String SELECT_SEARCH = "SELECT * FROM products WHERE category_id=? AND name=?";
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        int category_id = Integer.parseInt(request.getParameter("category"));
        String name = request.getParameter("search");
        
        if(category.isEmpty() || name.isEmpty()){
            response.sendError(0, "Missing Some Values");
        }
        
        try {
            Connection conn;
            conn = DBConnection.initializeDatabase();
            
            PreparedStatement preparedStatement = conn.prepareStatement(SELECT_SEARCH);
            preparedStatement.setInt(1, category_id);
            preparedStatement.setString(2, name);
            
            ResultSet rs = preparedStatement.executeQuery();

            List<Product> productList = new ArrayList<>();
            
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                String productName = rs.getString("name");
                String description = rs.getString("description");
                String image_url = rs.getString("image_url");
                String price = rs.getString("price");
                int quantity = rs.getInt("quantity");
                
                Product product = new Product(productId, productName, description, image_url, price, quantity);
                productList.add(product);
            }
            
            request.setAttribute("productList", productList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
