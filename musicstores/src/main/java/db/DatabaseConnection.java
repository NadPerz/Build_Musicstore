package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Static variable to hold the single instance
    private static DatabaseConnection instance;
    
    private static final String URL = "jdbc:mysql://localhost:3306/musicstores";
    private static final String USER = "root";  
    private static final String PASSWORD = "Nadija@20022025";
    
    // Connection object
    private Connection connection;
    
    // Private constructor to prevent instantiation
    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the JDBC driver
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
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
        return connection;
    }
    
    // Method to close the connection
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}