package playlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.DatabaseConnection;

public class SongDAO {
    // Default constructor - no parameters needed since we use singleton
    public SongDAO() {
        // No initialization needed as we'll get connection from singleton
    }
    
    public void addSong(String title, String artist, String album, String filePath) throws SQLException {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "INSERT INTO songs (title, artist, album, file_path) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, title);
            stmt.setString(2, artist);
            stmt.setString(3, album);
            stmt.setString(4, filePath);
            stmt.executeUpdate();
        }
        // Connection remains open as it's managed by the singleton
    }
    
    public List<Song> getAllSongs() throws SQLException {
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
        }
        return songs;
    }
    
    // You might want to add other methods like getSongById, updateSong, deleteSong, etc.
    public Song getSongById(int songId) throws SQLException {
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
        }
        return null;
    }
    
    public boolean updateSong(Song song) throws SQLException {
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
        }
    }
    
    public boolean deleteSong(int songId) throws SQLException {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "DELETE FROM songs WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, songId);
            return stmt.executeUpdate() > 0;
        }
    }
}