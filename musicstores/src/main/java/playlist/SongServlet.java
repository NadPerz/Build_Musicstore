package playlist;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import exception.DatabaseException;

@WebServlet("/songs")
public class SongServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Create SongDAO instance with default constructor (no connection needed)
            SongDAO songDAO = new SongDAO();
            
            // Get all songs
            List<Song> songs = songDAO.getAllSongs();
            
            // Set attribute and forward to JSP
            request.setAttribute("songs", songs);
            request.getRequestDispatcher("songs.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            // Log the detailed error message
            System.err.println("Database error: " + e.getDetailedMessage());
            e.printStackTrace();
            
            // Set user-friendly error message
            request.setAttribute("error", "Unable to load songs. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            // Catch any other unexpected errors
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An unexpected error occurred", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String title = request.getParameter("title");
        String artist = request.getParameter("artist");
        String album = request.getParameter("album");
        String filePath = request.getParameter("filePath");
        
        // Validate input parameters
        if (title == null || title.trim().isEmpty() || 
            artist == null || artist.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Title and Artist are required fields.");
            response.sendRedirect("songs");
            return;
        }
        
        try {
            // Create SongDAO instance with default constructor (no connection needed)
            SongDAO songDAO = new SongDAO();
            
            // Add song to database
            songDAO.addSong(title.trim(), artist.trim(), 
                          album != null ? album.trim() : "", 
                          filePath != null ? filePath.trim() : "");
            
            // Set success message
            request.getSession().setAttribute("successMessage", 
                "Song '" + title.trim() + "' by " + artist.trim() + " added successfully!");
            
            // Redirect to songs list
            response.sendRedirect("songs");
            
        } catch (DatabaseException e) {
            // Log the detailed error message
            System.err.println("Database error: " + e.getDetailedMessage());
            e.printStackTrace();
            
            // Set user-friendly error message in session
            request.getSession().setAttribute("errorMessage", 
                "Failed to add song. Please check if the song already exists or try again later.");
            
            // Redirect back to form
            response.sendRedirect("songs");
        } catch (Exception e) {
            // Catch any other unexpected errors
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message and redirect
            request.getSession().setAttribute("errorMessage", "An unexpected error occurred while adding the song.");
            response.sendRedirect("songs");
        }
    }
}