package musicStore_registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to database
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/musicstores?useSSL=false",
                "root",
                "Nadija@20022025"
            );

            // Prepare SQL query with correct column names
            PreparedStatement pst = con.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Use correct column name: 'username'
                session.setAttribute("name", rs.getString("username"));
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }

            // Clean up
            if (rs != null) rs.close();
            if (pst != null) pst.close();

        } catch (ClassNotFoundException e) {
            response.getWriter().println("Error: JDBC driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            response.getWriter().println("Error: Database connection failed or SQL error.");
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
