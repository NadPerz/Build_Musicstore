package playlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.DatabaseConnection;

public class PlaylistDAO {
    // No need to store connection as an instance variable when using singleton
    
    // Default constructor with no parameters
    public PlaylistDAO() {
        // No initialization needed as we'll get connection from singleton
    }
    
    public void createPlaylist(String name, String username) throws SQLException {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "INSERT INTO playlists (name, username, created_at) VALUES (?, ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, username);
            stmt.executeUpdate();
        }
        // We don't close the connection as it's managed by the singleton
    }
    
    public List<Playlist> getAllPlaylists() throws SQLException {
        List<Playlist> playlists = new ArrayList<>();
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "SELECT * FROM playlists";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                playlists.add(new Playlist(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("username")
                ));
            }
        }
        return playlists;
    }
    
    public Playlist getPlaylistById(int playlistId) throws SQLException {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "SELECT * FROM playlists WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Playlist(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("username")
                    );
                }
            }
        }
        return null;
    }
    
    public List<Song> getSongsInPlaylist(int playlistId) throws SQLException {
        List<Song> songs = new ArrayList<>();
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "SELECT s.id, s.title, s.artist, s.album, s.file_path FROM songs s " +
                     "JOIN playlist_songs ps ON s.id = ps.song_id WHERE ps.playlist_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            try (ResultSet rs = stmt.executeQuery()) {
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
        }
        return songs;
    }
    
    public void addSongToPlaylist(int playlistId, int songId) throws SQLException {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (?, ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            stmt.setInt(2, songId);
            stmt.executeUpdate();
        }
    }
    
    public void removeSongFromPlaylist(int playlistId, int songId) throws SQLException {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "DELETE FROM playlist_songs WHERE playlist_id = ? AND song_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            stmt.setInt(2, songId);
            stmt.executeUpdate();
        }
    }
}