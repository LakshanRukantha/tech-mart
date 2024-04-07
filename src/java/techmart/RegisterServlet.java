package techmart;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String REGISTER_STATEMENT = "INSERT INTO users(name, email, password) VALUES(?,?,?)";
        
        try {
            //        load jdbc driver
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            pw.println(ex.getMessage());
        }
        
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/techmart", "root", "");
            PreparedStatement ps = conn.prepareStatement(REGISTER_STATEMENT);
            
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            
            int count = ps.executeUpdate();
            
            if(count<=0){
                pw.println("Registration Failed!");
            }else{
                pw.println("Registration Successfull");
            }
            
        } catch (SQLException ex) {
            pw.println(ex.getMessage());
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
