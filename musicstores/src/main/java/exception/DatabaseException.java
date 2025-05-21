package exception;

/**
 * Exception for database operation failures in the Music Store application.
 */
public class DatabaseException extends Exception {
    
    private static final long serialVersionUID = 1L;
    
    /**
     * Constructs a new DatabaseException with default message.
     */
    public DatabaseException() {
        super("Database operation failed");
    }
    
    /**
     * Constructs a new DatabaseException with the specified detail message.
     * 
     * @param message the detail message
     */
    public DatabaseException(String message) {
        super(message);
    }
    
    /**
     * Constructs a new DatabaseException with the specified detail message and cause.
     * 
     * @param message the detail message
     * @param cause the cause of the exception
     */
    public DatabaseException(String message, Throwable cause) {
        super(message, cause);
    }
    
    /**
     * Constructs a new DatabaseException with the specified cause.
     * 
     * @param cause the cause of the exception
     */
    public DatabaseException(Throwable cause) {
        super(cause);
    }
}