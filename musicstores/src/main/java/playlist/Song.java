package playlist;

public class Song {
    private int id;
    private String title;
    private String artist;
    private String album;
    private String filePath;

    public Song(int id, String title, String artist, String album, String filePath) {
        this.id = id;
        this.title = title;
        this.artist = artist;
        this.album = album;
        this.filePath = filePath;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getArtist() {
        return artist;
    }

    public String getAlbum() {
        return album;
    }

    public String getFilePath() {
        return filePath;
    }

    // Setters (Optional, useful for form binding or editing)
    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public void setAlbum(String album) {
        this.album = album;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}