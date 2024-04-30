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
        // Step 1: Establishing a Connection
        try {
            Connection conn;
            conn = DBConnection.initializeDatabase();
            // Step 2:Create a statement using connection object
             PreparedStatement preparedStatement = conn.prepareStatement(SELECT_SEARCH);
             preparedStatement.setInt(1, category_id);
            preparedStatement.setString(2, name);
            
            // Step 3: Execute the query or update query
            ResultSet rs = preparedStatement.executeQuery();

            List<Product> productList = new ArrayList<>();
            
            while (rs.next()) {
                String productName = rs.getString("name");
                String description = rs.getString("description");
                String image_url = rs.getString("image_url");
                String price = rs.getString("price");
                
                Product product = new Product(productName, description, image_url, price);
    productList.add(product);
            }
            
            request.setAttribute("productList", productList);
RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
dispatcher.forward(request, response);
        } catch (SQLException ex) {
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    

        //processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
