package techmart;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import techmart.utils.DBConnection;


@WebServlet(name = "SignInServlet", urlPatterns = {"/SignInServlet"})
public class SignInServlet extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignInServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignInServlet at " + request.getContextPath() + "</h1>");
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
        PrintWriter pw=response.getWriter();
       String email=request.getParameter("email");
        String password=request.getParameter("password");
        try{
            Connection conn = DBConnection.initializeDatabase();
            String checklogin="SELECT * FROM users WHERE email= ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(checklogin);
            ps.setString(1, email);
            ps.setString(2,password);
            ResultSet result=ps.executeQuery();
            if(result.next()){
                HttpSession session=request.getSession();
                session.setAttribute("email", email);
                session.setMaxInactiveInterval(86400);
                response.sendRedirect("index.jsp");
            }else{
                request.setAttribute("invalidLogin", "Invalid Email or Password! Please Enter Correct Details..");
                request.getRequestDispatcher("signin.jsp").forward(request, response);
                
            }
         
        }catch( SQLException ex)
        {
            pw.println(ex.getMessage());
        }catch(ClassNotFoundException ex)
        {
            Logger.getLogger(SignInServlet.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
