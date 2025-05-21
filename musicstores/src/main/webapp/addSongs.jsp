<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="playlist.Song" %>
<%@ page import="java.util.List" %>
<%
    // Check if user is logged in
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get playlist ID and songs list
    int playlistId = Integer.parseInt(request.getParameter("playlistId"));
    List<Song> allSongs = (List<Song>) request.getAttribute("allSongs");
    List<Song> playlistSongs = (List<Song>) request.getAttribute("songs");
    
    // Create a filtered list of songs not in the playlist yet
    java.util.List<Song> availableSongs = new java.util.ArrayList<>();
    if (allSongs != null && playlistSongs != null) {
        for (Song song : allSongs) {
            boolean alreadyInPlaylist = false;
            for (Song playlistSong : playlistSongs) {
                if (song.getId() == playlistSong.getId()) {
                    alreadyInPlaylist = true;
                    break;
                }
            }
            if (!alreadyInPlaylist) {
                availableSongs.add(song);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Songs to Playlist</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/profile.css">
    <style>
        .song-list {
            margin-top: 20px;
        }
        .song-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            margin-bottom: 8px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }
        .song-info {
            flex-grow: 1;
        }
        .song-title {
            font-weight: bold;
            font-size: 1.1em;
        }
        .song-artist {
            color: #6c757d;
        }
        .song-album {
            font-style: italic;
            color: #6c757d;
            font-size: 0.9em;
        }
        .action-button {
            margin-left: 10px;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #6c757d;
            color: white;
            border-radius: 4px;
            text-decoration: none;
        }
        .back-link:hover {
            background-color: #5a6268;
            color: white;
            text-decoration: none;
        }
        .empty-list {
            padding: 20px;
            text-align: center;
            background-color: #f8f9fa;
            border-radius: 4px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="playlists">MyMusicStore</a>
            <div class="ml-auto">
                <span class="navbar-text mr-3">
                    <i class="fas fa-user"></i> <%= session.getAttribute("name") %>
                </span>
                <a class="btn btn-outline-light btn-sm" href="logout">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-4">
        <h2>Add Songs to Playlist</h2>
        
        <% if (availableSongs.isEmpty()) { %>
            <div class="empty-list">
                <p>All songs are already in this playlist.</p>
            </div>
        <% } else { %>
            <div class="song-list">
                <% for (Song song : availableSongs) { %>
                    <div class="song-item">
                        <div class="song-info">
                            <div class="song-title"><%= song.getTitle() %></div>
                            <div class="song-artist"><%= song.getArtist() %></div>
                            <div class="song-album">Album: <%= song.getAlbum() %></div>
                        </div>
                        <form action="playlists" method="post">
                            <input type="hidden" name="action" value="addSong">
                            <input type="hidden" name="playlistId" value="<%= playlistId %>">
                            <input type="hidden" name="songId" value="<%= song.getId() %>">
                            <button type="submit" class="btn btn-primary btn-sm action-button">Add to Playlist</button>
                        </form>
                    </div>
                <% } %>
            </div>
        <% } %>

        <a href="playlists?playlistId=<%= playlistId %>" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Playlist
        </a>
    </div>

    <!-- Bootstrap & Font Awesome JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>
</body>
</html>