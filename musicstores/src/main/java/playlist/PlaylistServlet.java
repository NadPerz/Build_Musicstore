package playlist;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import db.DatabaseConnection;

@WebServlet("/playlists")
public class PlaylistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Remove database connection constants since we'll use the singleton
    
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
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
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
                }
                response.sendRedirect("playlists");
                
            } else if ("addSong".equals(action)) {
                int playlistId = Integer.parseInt(request.getParameter("playlistId"));
                int songId = Integer.parseInt(request.getParameter("songId"));
                
                playlistDAO.addSongToPlaylist(playlistId, songId);
                response.sendRedirect("playlists?playlistId=" + playlistId);
                
            } else if ("removeSong".equals(action)) {
                int playlistId = Integer.parseInt(request.getParameter("playlistId"));
                int songId = Integer.parseInt(request.getParameter("songId"));
                
                playlistDAO.removeSongFromPlaylist(playlistId, songId);
                response.sendRedirect("playlists?playlistId=" + playlistId);
                
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}