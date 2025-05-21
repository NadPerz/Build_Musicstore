package playlist;

public class Playlist {
    private int id;
    private String name;
    private String username;

    public Playlist(int id, String name, String username) {
        this.id = id;
        this.name = name;
        this.username = username;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    // Setters (if needed)
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}