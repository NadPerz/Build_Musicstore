package playlist;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import db.DatabaseConnection;

@WebServlet("/songs")
public class SongServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Remove database connection constants as they're now in the singleton
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Create SongDAO instance with default constructor (no connection needed)
            SongDAO songDAO = new SongDAO();
            
            // Get all songs
            List<Song> songs = songDAO.getAllSongs();
            
            // Set attribute and forward to JSP
            request.setAttribute("songs", songs);
            request.getRequestDispatcher("songs.jsp").forward(request, response);
            
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String title = request.getParameter("title");
        String artist = request.getParameter("artist");
        String album = request.getParameter("album");
        String filePath = request.getParameter("filePath");
        
        try {
            // Create SongDAO instance with default constructor (no connection needed)
            SongDAO songDAO = new SongDAO();
            
            // Add song to database
            songDAO.addSong(title, artist, album, filePath);
            
            // Redirect to songs list
            response.sendRedirect("songs");
            
        } catch (SQLException e) {
            // Add error message to request and forward back to form
            request.setAttribute("error", "Failed to add song: " + e.getMessage());
            doGet(request, response);
        }
    }
}