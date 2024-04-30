package techmart;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import techmart.utils.DBConnection;
import javax.servlet.http.HttpSession;

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
        String IS_USER_EXISTS = "SELECT COUNT(*) FROM users WHERE email=?";
        
        try {
            Connection conn = DBConnection.initializeDatabase();
            
            PreparedStatement isUserExists = conn.prepareStatement(IS_USER_EXISTS);
            isUserExists.setString(1, email);
            ResultSet existUsersResult = isUserExists.executeQuery();
            existUsersResult.next();
            int existUsersCount = existUsersResult.getInt(1);
            
            System.out.print("Exist Count: " + existUsersCount);
            
            if (existUsersCount > 0) {
                request.setAttribute("errorMessage", "User with email " + email + " already exists!");
                // Forward the request to the JSP page
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            PreparedStatement ps = conn.prepareStatement(REGISTER_STATEMENT);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            
            int count = ps.executeUpdate();
            
            if(count <= 0){
                request.setAttribute("failedMessage", "Registration Failed!");
                // Forward the request to the JSP page
                request.getRequestDispatcher("register.jsp").forward(request, response);
                
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setMaxInactiveInterval(86400);
                response.sendRedirect("index.jsp");
            }
            
        } catch (SQLException ex) {
            pw.println(ex.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}