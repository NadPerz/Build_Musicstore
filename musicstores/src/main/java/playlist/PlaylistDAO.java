package playlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.DatabaseConnection;
import exception.DatabaseException;

public class PlaylistDAO {
    // No need to store connection as an instance variable when using singleton
    
    // Default constructor with no parameters
    public PlaylistDAO() {
        // No initialization needed as we'll get connection from singleton
    }
    
    public void createPlaylist(String name, String username) {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "INSERT INTO playlists (name, username, created_at) VALUES (?, ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DatabaseException("Failed to create playlist: " + name, 
                                      "INSERT", "playlists", e);
        }
        // We don't close the connection as it's managed by the singleton
    }
    
    public List<Playlist> getAllPlaylists() {
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
        } catch (SQLException e) {
            throw new DatabaseException("Failed to retrieve all playlists", 
                                      "SELECT", "playlists", e);
        }
        return playlists;
    }
    
    public Playlist getPlaylistById(int playlistId) {
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
        } catch (SQLException e) {
            throw new DatabaseException("Failed to retrieve playlist with ID: " + playlistId, 
                                      "SELECT", "playlists", e);
        }
        return null;
    }
    
    public List<Song> getSongsInPlaylist(int playlistId) {
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
        } catch (SQLException e) {
            throw new DatabaseException("Failed to retrieve songs for playlist ID: " + playlistId, 
                                      "SELECT", "songs/playlist_songs", e);
        }
        return songs;
    }
    
    public void addSongToPlaylist(int playlistId, int songId) {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (?, ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            stmt.setInt(2, songId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DatabaseException("Failed to add song ID " + songId + " to playlist ID " + playlistId, 
                                      "INSERT", "playlist_songs", e);
        }
    }
    
    public void removeSongFromPlaylist(int playlistId, int songId) {
        // Get connection from singleton
        Connection conn = DatabaseConnection.getInstance().getConnection();
        
        String sql = "DELETE FROM playlist_songs WHERE playlist_id = ? AND song_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            stmt.setInt(2, songId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DatabaseException("Failed to remove song ID " + songId + " from playlist ID " + playlistId, 
                                      "DELETE", "playlist_songs", e);
        }
    }
}