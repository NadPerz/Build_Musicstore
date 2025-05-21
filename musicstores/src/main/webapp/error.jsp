<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <div class="alert alert-danger">
            <h4 class="alert-heading">Error</h4>
            <p>${error}</p>
        </div>
        <a href="songs" class="btn btn-primary">Back to Songs</a>
    </div>
</body>
</html> 