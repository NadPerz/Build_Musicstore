package playlist;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import exception.DatabaseException;

@WebServlet("/playlists")
public class PlaylistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String playlistIdParam = request.getParameter("playlistId");
        
        try {
            // Create DAO instances using default constructors (no connection needed)
            PlaylistDAO playlistDAO = new PlaylistDAO();
            SongDAO songDAO = new SongDAO();
            
            if (playlistIdParam != null) {
                int playlistId = Integer.parseInt(playlistIdParam);
                Playlist playlist = playlistDAO.getPlaylistById(playlistId);
                
                if (playlist != null) {
                    List<Song> songs = playlistDAO.getSongsInPlaylist(playlistId);
                    List<Song> allSongs = songDAO.getAllSongs();
                    
                    request.setAttribute("playlist", playlist);
                    request.setAttribute("songs", songs);
                    request.setAttribute("allSongs", allSongs);
                    request.getRequestDispatcher("viewPlaylist.jsp").forward(request, response);
                } else {
                    // Playlist ID is invalid
                    response.sendRedirect("playlists"); // fallback to all playlists view
                }
            } else {
                List<Playlist> playlists = playlistDAO.getAllPlaylists();
                request.setAttribute("playlists", playlists);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (DatabaseException e) {
            // Log the detailed error message
            System.err.println("Database error: " + e.getDetailedMessage());
            e.printStackTrace();
            
            // Set user-friendly error message
            request.setAttribute("error", "Unable to access playlist data. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Invalid playlist ID format
            response.sendRedirect("playlists");
        } catch (Exception e) {
            // Catch any other unexpected errors
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An unexpected error occurred", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            // Create DAO instance using default constructor (no connection needed)
            PlaylistDAO playlistDAO = new PlaylistDAO();
            
            if ("create".equals(action)) {
                String name = request.getParameter("playlistName");  // make sure this matches the form input name
                String username = (String) request.getSession().getAttribute("name");
                
                if (name != null && !name.trim().isEmpty() && username != null) {
                    playlistDAO.createPlaylist(name.trim(), username);
                    // Set success message
                    request.getSession().setAttribute("successMessage", "Playlist '" + name.trim() + "' created successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Invalid playlist name or user session.");
                }
                response.sendRedirect("playlists");
                
            } else if ("addSong".equals(action)) {
                int playlistId = Integer.parseInt(request.getParameter("playlistId"));
                int songId = Integer.parseInt(request.getParameter("songId"));
                
                playlistDAO.addSongToPlaylist(playlistId, songId);
                request.getSession().setAttribute("successMessage", "Song added to playlist successfully!");
                response.sendRedirect("playlists?playlistId=" + playlistId);
                
            } else if ("removeSong".equals(action)) {
                int playlistId = Integer.parseInt(request.getParameter("playlistId"));
                int songId = Integer.parseInt(request.getParameter("songId"));
                
                playlistDAO.removeSongFromPlaylist(playlistId, songId);
                request.getSession().setAttribute("successMessage", "Song removed from playlist successfully!");
                response.sendRedirect("playlists?playlistId=" + playlistId);
                
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (DatabaseException e) {
            // Log the detailed error message
            System.err.println("Database error: " + e.getDetailedMessage());
            e.printStackTrace();
            
            // Set user-friendly error message in session
            request.getSession().setAttribute("errorMessage", "Database operation failed. Please try again.");
            
            // Redirect back to appropriate page
            String playlistIdParam = request.getParameter("playlistId");
            if (playlistIdParam != null && !playlistIdParam.isEmpty()) {
                response.sendRedirect("playlists?playlistId=" + playlistIdParam);
            } else {
                response.sendRedirect("playlists");
            }
        } catch (NumberFormatException e) {
            // Invalid number format in parameters
            request.getSession().setAttribute("errorMessage", "Invalid playlist or song ID.");
            response.sendRedirect("playlists");
        } catch (Exception e) {
            // Catch any other unexpected errors
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An unexpected error occurred", e);
        }
    }
}