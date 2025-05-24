package exception;

/**
 * Custom exception class for database-related errors
 * Extends RuntimeException to avoid forcing callers to handle checked exceptions
 */

//1. Better Error Messages: Context-aware error reporting
//2. Operation Tracking: Knows which database operation failed
//3. Table Information: Identifies which table was involved
//4. User-Friendly: Converts technical SQL errors to readable messages


//Exception Features:
//	• operation: What database operation was being performed
//	• tableName: Which table was being accessed
//	• Extends RuntimeException: No forced exception handling


/**
 * RuntimeException it avoids forcing boilerplate try-catch blocks throughout this
 *  application for common database issues. 
 *  This design promotes cleaner code while still allowing specific handling when necessary.
 *  making them unchecked. This means don't have to declare them in method signatures
 *   or catch them explicitly everywhere, 
 *  leading to less cluttered code.
 */


public class DatabaseException extends RuntimeException {
    private static final long serialVersionUID = 1L;
//    ensuring version compatibility during deserialization.
    
    
    private final String operation;
    private final String tableName;
    
    /**
     *  This allows developers to create exceptions with varying levels of detail depending on the context of the error.
     * Constructor with message only
     * making them unchecked. This means don't have to declare them in method signatures or catch them explicitly everywhere, 
     * leading to less cluttered code.
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
    
    
//	• getDetailedMessage(): Comprehensive error information
    /**
     *  This method is highly useful. It centralizes the logic for constructing a comprehensive error message,
     *   combining the base message with the operation and table details. 
     *   This ensures consistent and informative error reporting.
     */
    
    
    
    
    public String getDetailedMessage() {
        StringBuilder sb = new StringBuilder(getMessage());
        //get the msg from throwable clz 
        
        if (operation != null) {
            sb.append(" [Operation: ").append(operation).append("]");
        }
        
        if (tableName != null) {
            sb.append(" [Table: ").append(tableName).append("]");
        }
        
        return sb.toString();
    }
}