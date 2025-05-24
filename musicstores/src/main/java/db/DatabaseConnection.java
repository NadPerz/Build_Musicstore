package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import exception.DatabaseException;

public class DatabaseConnection {
    // Static variable to hold the single instance
    private static DatabaseConnection instance;
    
    //db connection details 
    
    private static final String URL = "jdbc:mysql://localhost:3306/musicstores";
    private static final String USER = "root";  
    private static final String PASSWORD = "Nadija@20022025";
//    not recommended for production environments.
    
    // Connection object  hold the actual java.sql.Connection  interact with the database.
    private Connection connection; 
    
    
    //Connection Management
    // Private constructor to prevent instantiation This is the cornerstone of the Singleton pattern. By making the constructor private,
    // prevent any other class from directly creating new instances of DatabaseConnection using new DatabaseConnection()
    
    
    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the JDBC driver jvm needs to load appropriate driver clz
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD); //DriverManager is a utility  establish a connection provided URL, username, and password.
            System.out.println("Database connection established successfully.");
        } catch (ClassNotFoundException e) {  // MySQL JDBC driver class cannot be found (e.g., if the JAR file is missing
            String errorMsg = "MySQL JDBC Driver not found: " + e.getMessage();
            System.err.println(errorMsg);
            throw new DatabaseException("Failed to load MySQL JDBC driver",       
                                      "DRIVER_LOAD", "N/A", e);
        } catch (SQLException e) {  // SQL-related errors that occur during the connection attempt
            String errorMsg = "Database connection failed: " + e.getMessage();
            System.err.println(errorMsg);
            throw new DatabaseException("Failed to establish database connection to: " + URL, //primary error message for the exception human-readable description dynamically including the URL 
                                      "CONNECTION", "N/A", e); //value(use helpful catgeraization and logging), not applicable 
        }
    }
    
    // Static method to get the instance
    public static synchronized DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }
    
    // Method to get the connection
    public Connection getConnection() {
        try {
            // Check if connection is still valid (existing connection)
            if (connection == null || connection.isClosed()) {
                System.out.println("Connection is closed, attempting to reconnect...");
                reconnect(); //try to reconnect again when connection is loss
            }
            return connection;
        } catch (SQLException e) {
            throw new DatabaseException("Failed to validate database connection", 
                                      "CONNECTION_CHECK", "N/A", e); //, wrong adding credentials, db not runing in this movemnet this claus will print 
        }
    }
    
    // Method to reconnect if connection is lost
    private void reconnect() {
        try {
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database reconnection successful.");
        } catch (SQLException e) {
            throw new DatabaseException("Failed to reconnect to database: " + URL, 
                                      "RECONNECTION", "N/A", e);
        }
    }
    
    // Method to test the connection
    public boolean testConnection() {
        try {
            return connection != null && !connection.isClosed() && connection.isValid(5);
        } catch (SQLException e) {
            System.err.println("Connection test failed: " + e.getMessage());
            return false;
        }
    }
    
    // Method to close the connection
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed successfully.");
            } catch (SQLException e) {
                throw new DatabaseException("Failed to close database connection", 
                                          "CONNECTION_CLOSE", "N/A", e);
            }
        }
    }
    
    // Method to get connection status information
    public String getConnectionInfo() {
        try {
            if (connection != null && !connection.isClosed()) {
                return String.format("Connected to: %s | User: %s | Valid: %s", 
                                   URL, USER, connection.isValid(2));
            } else {
                return "Connection is closed or null";
            }
        } catch (SQLException e) {
            return "Error getting connection info: " + e.getMessage();
        }
    }
}