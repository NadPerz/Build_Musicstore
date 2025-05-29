package playlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.DatabaseConnection;
import exception.DatabaseException;

//Clear Method Naming

public class SongDAO {
    // Default constructor - no parameters needed since we use singleton
    public SongDAO() {
        // No initialization needed as we'll get connection from singleton
    }
    
    public void addSong(String title, String artist, String album, String filePath) {
        
    	// Get connection from singleton
//    	DAO operations share the same database connection, which is efficient and prevents resource leaks.
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "INSERT INTO songs (title, artist, album, file_path) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) { //avoid SQL injection vulnerabilities PreparedStatement interface Statement
            stmt.setString(1, title); //Resource Managemen , ResultSet objects ensures that these resources are automatically closed
            stmt.setString(2, artist); // even if exceptions occur. This is a robust way to manage database resources.
            stmt.setString(3, album);
            stmt.setString(4, filePath);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DatabaseException("Failed to add song: " + title + " by " + artist, 
                                      "INSERT", "songs", e);
        }
        // Connection remains open as it's managed by the singleton
    }
    
    public List<Song> getAllSongs() {
        List<Song> songs = new ArrayList<>();
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "SELECT * FROM songs";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                songs.add(new Song(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getString("album"),
                    rs.getString("file_path")
                ));
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to retrieve all songs", 
                                      "SELECT", "songs", e);
        }
        return songs;
    }
    
    public Song getSongById(int songId) {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "SELECT * FROM songs WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, songId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Song(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("artist"),
                        rs.getString("album"),
                        rs.getString("file_path")
                    );
                }
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to retrieve song with ID: " + songId, 
                                      "SELECT", "songs", e);
        }
        return null;
    }
    
    public boolean updateSong(Song song) {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "UPDATE songs SET title = ?, artist = ?, album = ?, file_path = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, song.getTitle());
            stmt.setString(2, song.getArtist());
            stmt.setString(3, song.getAlbum());
            stmt.setString(4, song.getFilePath());
            stmt.setInt(5, song.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DatabaseException("Failed to update song with ID: " + song.getId(), 
                                      "UPDATE", "songs", e);
        }
    }
    
    public boolean deleteSong(int songId) {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "DELETE FROM songs WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) { // PreparedStatement interface Statement
            stmt.setInt(1, songId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DatabaseException("Failed to delete song with ID: " + songId, 
                                      "DELETE", "songs", e);
        }
    }
}