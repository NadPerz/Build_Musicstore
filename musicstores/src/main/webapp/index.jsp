<!-- index.jsp -->
<%@ page import="playlist.Playlist" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
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
    <title>My Music Profile</title>
    <link rel="stylesheet" href="css/profile.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
<nav class="navbar">
    <div class="nav-logo">MyMusicStore</div>
    <div class="nav-user">
        <span class="user-name"><i class="fas fa-user-circle"></i> <%= username %></span>
        <a class="logout-button" href="logout">Logout</a>
    </div>
</nav>
<header class="profile-header">
    <div class="profile-info">
        <img src="assets/img/boy-light-svgrepo-com.svg" alt="User Avatar" class="avatar"/>
        <div>
            <h1 class="username"><%= username %></h1>
            <p class="user-role">Premium Member</p>
        </div>
    </div>
</header>
<section class="library">
    <h2>Your Playlists</h2>
       <!-- Modified form with action parameter -->
        <form action="playlists" method="post">
            <input type="hidden" name="action" value="create" />
            <input type="text" name="playlistName" placeholder="New Playlist Name" required />
            <button type="submit">Create Playlist</button>
        </form>
    <div class="playlist-grid">
        <% 
            List<Playlist> playlists = (List<Playlist>) request.getAttribute("playlists");
            if (playlists != null) {
                for (Playlist pl : playlists) {
        %>
        <div class="playlist-card">
            <!-- Modified link to go through the servlet -->
                <a href="playlists?playlistId=<%= pl.getId() %>">
                <img src="assets/img/take-a-bath-svgrepo-com.svg" alt="Playlist" />
                <p><%= pl.getName() %></p>
            </a>
        </div>
        <% } } %>
    </div>
</section>
<footer class="footer">
    <p>© 2025 MyMusicStore - Built for music lovers</p>
</footer>
</body>
</html>
