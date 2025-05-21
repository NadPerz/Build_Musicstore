<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <title>Create New Password</title>
  <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' rel='stylesheet'>
  <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css' rel='stylesheet'>
  <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
  <style>
    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #e8d0dc 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .container-wrapper {
      max-width: 520px;
      width: 100%;
      margin: 40px auto;
    }
    
    .card {
      border: none;
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      animation: fadeInUp 0.6s ease-out forwards;
    }
    
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translate3d(0, 30px, 0);
      }
      to {
        opacity: 1;
        transform: translate3d(0, 0, 0);
      }
    }
    
    .card-header {
      background-color: #A35C7A;
      color: white;
      text-align: center;
      padding: 25px 15px;
      border-bottom: none;
    }
    
    .card-header h1 {
      font-size: 24px;
      margin: 0;
      font-weight: 700;
    }
    
    .card-header .lock-icon {
      display: block;
      width: 80px;
      height: 80px;
      line-height: 80px;
      background-color: rgba(255, 255, 255, 0.2);
      border-radius: 50%;
      margin: 0 auto 15px;
      text-align: center;
    }
    
    .card-header .lock-icon i {
      font-size: 32px;
    }
    
    .card-body {
      padding: 30px 25px;
    }
    
    .form-group {
      margin-bottom: 25px;
      position: relative;
    }
    
    .form-control {
      height: 50px;
      border-radius: 10px;
      padding-left: 45px;
      border: 1px solid #ced4da;
      transition: all 0.3s ease;
    }
    
    .form-control:focus {
      border-color: #A35C7A;
      box-shadow: 0 0 0 3px rgba(163, 92, 122, 0.2);
    }
    
    .input-icon {
      position: absolute;
      left: 15px;
      top: 16px;
      color: #A35C7A;
    }
    
    .password-requirements {
      background-color: #f8f9fa;
      border-radius: 10px;
      padding: 15px;
      margin-bottom: 25px;
      border-left: 3px solid #A35C7A;
    }
    
    .password-requirements h6 {
      color: #A35C7A;
      margin-bottom: 10px;
      font-weight: 600;
    }
    
    .requirement-item {
      display: flex;
      align-items: center;
      margin-bottom: 5px;
      font-size: 13px;
      color: #6c757d;
    }
    
    .requirement-item i {
      margin-right: 8px;
      font-size: 12px;
    }
    
    .btn-primary {
      background-color: #A35C7A;
      border-color: #A35C7A;
      border-radius: 10px;
      padding: 12px 25px;
      font-weight: 600;
      letter-spacing: 0.5px;
      box-shadow: 0 5px 15px rgba(163, 92, 122, 0.3);
      transition: all 0.3s ease;
    }
    
    .btn-primary:hover, .btn-primary:focus {
      background-color: #8d4e6a;
      border-color: #8d4e6a;
      box-shadow: 0 5px 20px rgba(163, 92, 122, 0.5);
      transform: translateY(-2px);
    }
    
    .card-footer {
      background-color: #f8f9fa;
      border-top: 1px solid #eee;
      padding: 20px 25px;
      text-align: center;
    }
    
    .register-link {
      color: #A35C7A;
      font-weight: 600;
      transition: all 0.2s ease;
    }
    
    .register-link:hover {
      color: #8d4e6a;
      text-decoration: none;
    }
    
    .password-toggle {
      position: absolute;
      right: 15px;
      top: 16px;
      color: #6c757d;
      cursor: pointer;
      transition: all 0.2s ease;
    }
    
    .password-toggle:hover {
      color: #A35C7A;
    }
    
    .password-match-message {
      margin-top: 5px;
      font-size: 12px;
      display: none;
    }
    
    .password-match-message.valid {
      color: #28a745;
      display: block;
    }
    
    .password-match-message.invalid {
      color: #dc3545;
      display: block;
    }
    
    @media (max-width: 576px) {
      .container-wrapper {
        margin: 20px 15px;
      }
      
      .card-header h1 {
        font-size: 22px;
      }
    }
  </style>
</head>
<body>
  <div class="container-wrapper">
    <div class="card">
      <div class="card-header">
        <span class="lock-icon">
          <i class="fas fa-key"></i>
        </span>
        <h1>Create New Password</h1>
        <p class="mb-0 mt-2">Please enter a strong password for your account</p>
      </div>
      
      <form action="newPassword" method="POST">
        <div class="card-body">
          <!-- Password Requirements -->
          <div class="password-requirements">
            <h6><i class="fas fa-shield-alt mr-2"></i>Password Requirements</h6>
            <div class="requirement-item">
              <i class="far fa-circle"></i>
              <span>At least 8 characters long</span>
            </div>
            <div class="requirement-item">
              <i class="far fa-circle"></i>
              <span>Contains uppercase letters</span>
            </div>
            <div class="requirement-item">
              <i class="far fa-circle"></i>
              <span>Contains numbers</span>
            </div>
            <div class="requirement-item">
              <i class="far fa-circle"></i>
              <span>Contains special characters</span>
            </div>
          </div>
        
          <!-- New Password Input -->
          <div class="form-group">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" name="password" id="password" placeholder="New Password" class="form-control" required>
            <span class="password-toggle" id="togglePassword">
              <i class="far fa-eye"></i>
            </span>
          </div>
          
          <!-- Confirm Password Input -->
          <div class="form-group">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" name="confPassword" id="confPassword" placeholder="Confirm New Password" class="form-control" required>
            <span class="password-toggle" id="toggleConfPassword">
              <i class="far fa-eye"></i>
            </span>
            <div id="passwordMatchMessage" class="password-match-message">
              <i class="fas fa-check-circle mr-1"></i>Passwords match
            </div>
          </div>
          
          <!-- Submit Button -->
          <div class="form-group mb-0">
            <button type="submit" class="btn btn-primary btn-block">
              <i class="fas fa-check-circle mr-2"></i>Reset Password
            </button>
          </div>
        </div>
      </form>
      
      <div class="card-footer">
        <p class="mb-0">Don't have an account? <a href="#" class="register-link">Register Now!</a></p>
      </div>
    </div>
  </div>
  
  <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js'></script>
  <script>
    $(document).ready(function() {
      // Toggle password visibility
      $('#togglePassword').click(function() {
        const passwordField = $('#password');
        const passwordFieldType = passwordField.attr('type');
        const newType = passwordFieldType === 'password' ? 'text' : 'password';
        passwordField.attr('type', newType);
        
        // Change icon
        $(this).find('i').toggleClass('fa-eye fa-eye-slash');
      });
      
      $('#toggleConfPassword').click(function() {
        const passwordField = $('#confPassword');
        const passwordFieldType = passwordField.attr('type');
        const newType = passwordFieldType === 'password' ? 'text' : 'password';
        passwordField.attr('type', newType);
        
        // Change icon
        $(this).find('i').toggleClass('fa-eye fa-eye-slash');
      });
      
      // Check if passwords match
      $('#confPassword').on('keyup', function() {
        const password = $('#password').val();
        const confPassword = $(this).val();
        
        if (confPassword === '') {
          $('#passwordMatchMessage').removeClass('valid invalid').hide();
        } else if (password === confPassword) {
          $('#passwordMatchMessage').removeClass('invalid').addClass('valid').show();
          $('#passwordMatchMessage').html('<i class="fas fa-check-circle mr-1"></i>Passwords match');
        } else {
          $('#passwordMatchMessage').removeClass('valid').addClass('invalid').show();
          $('#passwordMatchMessage').html('<i class="fas fa-times-circle mr-1"></i>Passwords do not match');
        }
      });
      
      // Password strength validation (simple example)
      $('#password').on('keyup', function() {
        const password = $(this).val();
        
        // Check length
        if (password.length >= 8) {
          $('.requirement-item:eq(0) i').removeClass('far fa-circle').addClass('fas fa-check-circle text-success');
        } else {
          $('.requirement-item:eq(0) i').removeClass('fas fa-check-circle text-success').addClass('far fa-circle');
        }
        
        // Check uppercase
        if (/[A-Z]/.test(password)) {
          $('.requirement-item:eq(1) i').removeClass('far fa-circle').addClass('fas fa-check-circle text-success');
        } else {
          $('.requirement-item:eq(1) i').removeClass('fas fa-check-circle text-success').addClass('far fa-circle');
        }
        
        // Check numbers
        if (/\d/.test(password)) {
          $('.requirement-item:eq(2) i').removeClass('far fa-circle').addClass('fas fa-check-circle text-success');
        } else {
          $('.requirement-item:eq(2) i').removeClass('fas fa-check-circle text-success').addClass('far fa-circle');
        }
        
        // Check special characters
        if (/[^A-Za-z0-9]/.test(password)) {
          $('.requirement-item:eq(3) i').removeClass('far fa-circle').addClass('fas fa-check-circle text-success');
        } else {
          $('.requirement-item:eq(3) i').removeClass('fas fa-check-circle text-success').addClass('far fa-circle');
        }
      });
    });
  </script>
</body>
</html>