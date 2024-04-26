package techmart;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import techmart.utils.DBConnection;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)

public class CreateProductServlet extends HttpServlet {

    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter pw = response.getWriter();

    String name = request.getParameter("productName");
    String description = request.getParameter("productDescription");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");
    Part part = request.getPart("productImage");
    String fileName = extractFileName(part);
    String category_id = request.getParameter("productCategory");

    // Get the real path of the directory where you want to save the image
    String uploadDir = getServletContext().getRealPath("/") + "images/";

    // Write the file to the destination directory
    if (name.isEmpty() || description.isEmpty() || price.isEmpty() || quantity.isEmpty() || part.getSize() <= 0 || category_id.isEmpty()) {
    response.sendError(0, "Missing Some Values");
    } else {
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
        uploadDirFile.mkdirs(); // Create the directory if it doesn't exist
        }

    try (InputStream input = part.getInputStream()) {
        Files.copy(input, Paths.get(uploadDir, fileName), StandardCopyOption.REPLACE_EXISTING);
        System.out.println("File Uploaded.");
    } catch (IOException e) {
        // Handle exception
        e.printStackTrace();
    }
}
    
    String CREATE_PRODUCT_STATEMENT = "INSERT INTO products(name, description, price, quantity, image_url, category_id) VALUES(?,?,?,?,?,?)";
    
    try (InputStream input = part.getInputStream()) {
        Files.copy(input, Paths.get(uploadDir, fileName), StandardCopyOption.REPLACE_EXISTING);
        System.out.print("File Uploaded.");
    } catch (IOException e) {
        // Handle exception
        e.printStackTrace();
    }
    
    try{
        Connection conn;
            conn = DBConnection.initializeDatabase();
            PreparedStatement ps = conn.prepareStatement(CREATE_PRODUCT_STATEMENT);
            
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setBigDecimal(3, new BigDecimal(price)); // Assuming price is of type DECIMAL or NUMERIC
            ps.setInt(4, Integer.parseInt(quantity)); // Assuming quantity is of type INTEGER
            ps.setString(5, "images/" + fileName); // Assuming the image path is relative to the web context
            ps.setInt(6, Integer.parseInt(category_id)); // Assuming category_id is of type INTEGER
    
            int count = ps.executeUpdate();
            
            if(count<=0){
                pw.write("Product created failed!");
            }else{
                pw.write("Product created successfully!");
            }
    
    // Close the connection
            conn.close();
    
    // Redirect or display success message
    // (not shown in this code snippet)
        } catch (SQLException | NumberFormatException ex) {
            pw.println(ex.getMessage());
            ex.printStackTrace(); // Print the stack trace for debugging
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
}
    
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
