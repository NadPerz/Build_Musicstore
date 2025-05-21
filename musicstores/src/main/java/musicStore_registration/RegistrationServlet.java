package musicStore_registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from the request
        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String umobile = request.getParameter("contact");
        
        // For debugging
        PrintWriter out = response.getWriter();
        out.print(username);
        out.print(email);
        out.print(password);
        out.print(umobile);
        
        RequestDispatcher dispatcher = null;
        Connection con = null;
        
        try {
            // Load the JDBC driver
//            Class.forName("com.mysql.cj.jdbc.Driver");
            
        	
        	Class.forName("com.mysql.cj.jdbc.Driver");

        	
        	
        	
            // Connect to the database with updated password
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/musicstores?useSSL=false", "root", "Nadija@20022025");
            
            // Prepare the SQL statement and set parameters in correct order
            PreparedStatement pst = con.prepareStatement("insert into users(username, email, password, umobile) values(?,?,?,?)");
            pst.setString(1, username);
            pst.setString(2, email);  // Fixed order - email as second parameter
            pst.setString(3, password);    // Fixed order - password as third parameter
            pst.setString(4, umobile); // Fixed order - mobile as fourth parameter
            
            // Execute the statement
            int rowCount = pst.executeUpdate();
            dispatcher = request.getRequestDispatcher("registration.jsp");
            
            // Set status attribute based on result
            if(rowCount > 0) {
                request.setAttribute("status", "Success");
            } else {
                request.setAttribute("status", "failed");
            }
            
            dispatcher.forward(request, response);
            
        } catch(Exception e) {
            // Print the exception details to help with debugging
            out.println("<h2>Database Error:</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            // Close connection with null check to prevent NullPointerException
            if(con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}