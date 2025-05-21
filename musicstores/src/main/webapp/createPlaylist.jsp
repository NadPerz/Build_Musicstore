<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    }
    String username = (String)session.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Create Playlist - MyMusicStore</title>
    <link rel="stylesheet" href="css/profile.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>

<!-- Navigation -->
<nav class="navbar">
    <div class="nav-logo">MyMusicStore</div>
    <div class="nav-user">
        <span class="user-name"><i class="fas fa-user-circle"></i> <%= username %></span>
        <a class="logout-button" href="logout">Logout</a>
    </div>
</nav>

<!-- Create Playlist Form -->
<section class="create-playlist-section">
    <div class="container">
        <h2>Create New Playlist</h2>
        <form action="playlists" method="post" class="playlist-form">
            <input type="hidden" name="action" value="create" />
            <div class="form-group">
                <label for="playlistName">Playlist Name:</label>
                <input type="text" id="playlistName" name="playlistName" required placeholder="Enter playlist name">
            </div>
            <div class="form-actions">
                <button type="submit" class="create-button">Create Playlist</button>
                <a href="playlists" class="cancel-button">Cancel</a>
            </div>
        </form>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <p>© 2025 MyMusicStore - Built with ♥ for music lovers</p>
</footer>

</body>
</html>
