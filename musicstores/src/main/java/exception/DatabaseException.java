package exception;

/**
 * Custom exception class for database-related errors
 * Extends RuntimeException to avoid forcing callers to handle checked exceptions
 */
public class DatabaseException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    
    private final String operation;
    private final String tableName;
    
    /**
     * Constructor with message only
     */
    public DatabaseException(String message) {
        super(message);
        this.operation = null;
        this.tableName = null;
    }
    
    /**
     * Constructor with message and cause
     */
    public DatabaseException(String message, Throwable cause) {
        super(message, cause);
        this.operation = null;
        this.tableName = null;
    }
    
    /**
     * Constructor with operation details
     */
    public DatabaseException(String message, String operation, String tableName) {
        super(message);
        this.operation = operation;
        this.tableName = tableName;
    }
    
    /**
     * Constructor with operation details and cause
     */
    public DatabaseException(String message, String operation, String tableName, Throwable cause) {
        super(message, cause);
        this.operation = operation;
        this.tableName = tableName;
    }
    
    /**
     * Get the database operation that failed
     */
    public String getOperation() {
        return operation;
    }
    
    /**
     * Get the table name involved in the operation
     */
    public String getTableName() {
        return tableName;
    }
    
    /**
     * Get detailed error message including operation and table info
     */
    public String getDetailedMessage() {
        StringBuilder sb = new StringBuilder(getMessage());
        
        if (operation != null) {
            sb.append(" [Operation: ").append(operation).append("]");
        }
        
        if (tableName != null) {
            sb.append(" [Table: ").append(tableName).append("]");
        }
        
        return sb.toString();
    }
}