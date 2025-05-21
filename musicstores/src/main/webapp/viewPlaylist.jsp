<%@ page import="java.util.List" %>
<%@ page import="playlist.Song" %>
<%@ page import="playlist.Playlist" %>
<%!
// Declaration tag for class-level methods and variables
public String createFilename(String title) {
    return title.toLowerCase().replace(" ", "_").replace("-", "_") + ".mp3";
}
%>
<%
// Scriptlet for code executed during request processing
Playlist playlist = (Playlist) request.getAttribute("playlist");
List<Song> songs = (List<Song>) request.getAttribute("songs");
List<Song> allSongs = (List<Song>) request.getAttribute("allSongs");

// Add a check to prevent null pointer exceptions
if (playlist == null) {
    response.sendRedirect("playlists");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Playlist - MyMusicStore</title>
    <link rel="stylesheet" href="css/profile.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .playlist-section {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .song-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #f8f8f8;
            border-radius: 5px;
        }
        .song-info {
            flex-grow: 1;
        }
        .play-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 15px;
            margin-right: 10px;
            cursor: pointer;
            border-radius: 4px;
        }
        .remove-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 4px;
        }
        .player-container {
            background-color: #f0f0f0;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .now-playing {
            font-weight: bold;
            margin-bottom: 8px;
        }
        audio {
            width: 100%;
        }
        .add-song-container {
            margin: 20px 0;
        }
        #songDropdown {
            padding: 8px;
            width: 100%;
            margin-bottom: 10px;
        }
        .add-buttons {
            display: flex;
            gap: 10px;
        }
        .add-play-btn {
            background-color: #2196F3;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 4px;
        }
        .add-btn {
            background-color: #9C27B0;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<!-- Navigation -->
<nav class="navbar">
    <div class="nav-logo">MyMusicStore</div>
    <div class="nav-user">
        <a href="playlists" class="back-button">Back to Playlists</a>
        <a class="logout-button" href="logout">Logout</a>
    </div>
</nav>

<!-- Playlist Content -->
<section class="playlist-section">
    <h2>Playlist: <%= playlist.getName() %></h2>

    <!-- Audio Player -->
    <div class="player-container">
        <h3>Now Playing</h3>
        <p id="nowPlaying" class="now-playing">No song selected</p>
        <audio id="audioPlayer" controls>
            Your browser does not support the audio element.
        </audio>
    </div>

    <!-- Song List -->
    <h3>Songs in this Playlist</h3>
    <div class="song-list">
        <% if (songs != null && !songs.isEmpty()) {
            for (Song song : songs) { 
                String filename = createFilename(song.getTitle());
            %>
                <div class="song-item" data-song-id="<%= song.getId() %>" data-filename="<%= filename %>">
                    <div class="song-info">
                        <%= song.getTitle() %> - <%= song.getArtist() %>
                    </div>
                    <div class="song-actions">
                        <button class="play-btn" onclick="playSong('<%= song.getId() %>', '<%= song.getTitle() %>', '<%= song.getArtist() %>', '<%= filename %>')">
                            <i class="fas fa-play"></i> Play
                        </button>
                        <form action="playlists" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="removeSong">
                            <input type="hidden" name="playlistId" value="<%= playlist.getId() %>">
                            <input type="hidden" name="songId" value="<%= song.getId() %>">
                            <button type="submit" class="remove-btn">
                                <i class="fas fa-trash"></i> Remove
                            </button>
                        </form>
                    </div>
                </div>
            <% }
        } else { %>
            <p>No songs in this playlist yet.</p>
        <% } %>
    </div>

    <!-- Add Song to Playlist -->
    <h3>Add Song to Playlist</h3>
    <div class="add-song-container">
        <form action="playlists" method="post" id="addSongForm">
            <input type="hidden" name="action" value="addSong">
            <input type="hidden" name="playlistId" value="<%= playlist.getId() %>">
            
            <% if (allSongs != null && !allSongs.isEmpty()) { %>
                <label for="songDropdown">Select Song:</label>
                <select name="songId" id="songDropdown" required>
                    <option value="">-- Select a song --</option>
                    <% for (Song song : allSongs) { 
                        String filename = createFilename(song.getTitle());
                    %>
                        <option value="<%= song.getId() %>" 
                                data-title="<%= song.getTitle() %>" 
                                data-artist="<%= song.getArtist() %>"
                                data-filename="<%= filename %>">
                            <%= song.getTitle() %> - <%= song.getArtist() %>
                        </option>
                    <% } %>
                </select>
                <div class="add-buttons">
                    <button type="button" class="add-play-btn" onclick="addAndPlay()">Add & Play Song</button>
                    <button type="submit" class="add-btn">Add Song Only</button>
                </div>
            <% } else { %>
                <p>No songs available to add. Please add songs to the library first.</p>
            <% } %>
        </form>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <p>© 2025 MyMusicStore - Built with ♥ for music lovers</p>
</footer>

<script>
    // Get references to HTML elements
    const audioPlayer = document.getElementById('audioPlayer');
    const nowPlaying = document.getElementById('nowPlaying');
    const songDropdown = document.getElementById('songDropdown');
    
    // Function to play a song
    function playSong(songId, title, artist, filename) {
        // Update the now playing text
        nowPlaying.textContent = `${title} - ${artist}`;
        
        // Try multiple paths - adjust these based on your actual file system structure
        const possiblePaths = [
            `uploads/${filename}`,
            `uploads/bohemian_rhapsody.mp3`,
            `uploads/billie_jean.mp3`,
            `/uploads/${filename}`,
            `audio/${filename}`,
            `songs/${filename}`
        ];
        
        // Try each path until one works
        tryPath(0);
        
        function tryPath(index) {
            if (index >= possiblePaths.length) {
                // We've tried all paths and none worked
                alert("Could not find the audio file. Please check the file paths.");
                return;
            }
            
            const path = possiblePaths[index];
            
            // Create a new Audio element to test if the file exists
            const testAudio = new Audio(path);
            
            testAudio.oncanplaythrough = function() {
                // This path works, set it on the main audio player
                audioPlayer.src = path;
                audioPlayer.load();
                audioPlayer.play().catch(e => {
                    alert("Couldn't play the audio. This might be due to browser autoplay restrictions. Please click play manually.");
                });
            };
            
            testAudio.onerror = function() {
                // Try the next path
                tryPath(index + 1);
            };
            
            // Start loading to trigger events
            testAudio.load();
        }
    }
    
    // Function to add song and play it
    function addAndPlay() {
        if (songDropdown.value === "") {
            alert("Please select a song first");
            return;
        }
        
        // Get selected song details
        const selectedOption = songDropdown.options[songDropdown.selectedIndex];
        const songId = selectedOption.value;
        const title = selectedOption.getAttribute('data-title');
        const artist = selectedOption.getAttribute('data-artist');
        const filename = selectedOption.getAttribute('data-filename');
        
        // Store song info to play after redirect
        localStorage.setItem('playAfterAdd', JSON.stringify({
            songId: songId,
            title: title,
            artist: artist,
            filename: filename
        }));
        
        // Submit the form to add the song
        document.getElementById('addSongForm').submit();
    }
    
    // Check if we should play a song after page load (after adding a song)
    window.onload = function() {
        // Check for saved song to play
        const savedSong = localStorage.getItem('playAfterAdd');
        if (savedSong) {
            try {
                const songData = JSON.parse(savedSong);
                playSong(songData.songId, songData.title, songData.artist, songData.filename);
                localStorage.removeItem('playAfterAdd');
            } catch (e) {
                console.error("Error playing saved song:", e);
            }
        }
        
        // Play first song if available and no saved song to play
        const songItems = document.querySelectorAll('.song-item');
        if (songItems.length > 0 && !savedSong) {
            // Delay a bit to allow DOM to fully load
            setTimeout(() => {
                const firstSong = songItems[0];
                const songId = firstSong.getAttribute('data-song-id');
                const title = firstSong.querySelector('.song-info').textContent.split(' - ')[0].trim();
                const artist = firstSong.querySelector('.song-info').textContent.split(' - ')[1].trim();
                const filename = firstSong.getAttribute('data-filename');
                playSong(songId, title, artist, filename);
            }, 1000);
        }
    };
</script>

</body>
</html>