<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>OTP Verification | Account Recovery</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
  <style type="text/css">
    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #e8d0dc 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      padding: 20px 0;
    }
    
    .otp-card {
      max-width: 450px;
      width: 100%;
      margin: 0 auto;
    }
    
    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      animation: fadeInUp 0.6s ease-out forwards;
      transition: all 0.3s ease;
    }
    
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
    }
    
    .card-header {
      background-color: #A35C7A;
      padding: 30px 20px;
      text-align: center;
      border-bottom: none;
    }
    
    .icon-container {
      width: 90px;
      height: 90px;
      background-color: rgba(255, 255, 255, 0.2);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 15px;
    }
    
    .lock-icon {
      color: white;
      font-size: 42px;
    }
    
    .card-header h2 {
      color: white;
      font-weight: 600;
      margin-bottom: 0;
      font-size: 26px;
    }
    
    .card-body {
      padding: 30px;
    }
    
    .text-danger {
      background-color: rgba(220, 53, 69, 0.1);
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 20px;
    }
    
    .form-group {
      margin-bottom: 25px;
    }
    
    .input-group {
      position: relative;
      box-shadow: 0 3px 15px rgba(0, 0, 0, 0.05);
      border-radius: 10px;
      overflow: hidden;
    }
    
    .input-group-text {
      background-color: #f8f9fa;
      border: none;
      border-right: 1px solid #eee;
      color: #A35C7A;
      padding-left: 15px;
      padding-right: 15px;
    }
    
    .form-control {
      height: 50px;
      border: none;
      padding-left: 20px;
      font-size: 16px;
      letter-spacing: 2px;
      font-weight: 600;
    }
    
    .form-control:focus {
      box-shadow: none;
      border-color: #A35C7A;
    }
    
    .btn-primary {
      background-color: #A35C7A;
      border-color: #A35C7A;
      padding: 12px;
      font-weight: 600;
      border-radius: 10px;
      font-size: 16px;
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
    
    .otp-info {
      text-align: center;
      color: #666;
      margin-top: 20px;
      font-size: 14px;
    }
    
    .resend-link {
      color: #A35C7A;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s ease;
    }
    
    .resend-link:hover {
      color: #8d4e6a;
      text-decoration: none;
    }
    
    .timer {
      font-weight: 600;
      color: #A35C7A;
      margin-top: 5px;
    }
    
    /* OTP Input Styling */
    .otp-container {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
      margin-bottom: 25px;
    }
    
    .otp-input {
      width: 50px;
      height: 60px;
      text-align: center;
      font-size: 24px;
      font-weight: 600;
      border-radius: 10px;
      border: 1px solid #ddd;
      transition: all 0.2s ease;
    }
    
    .otp-input:focus {
      border-color: #A35C7A;
      box-shadow: 0 0 0 3px rgba(163, 92, 122, 0.2);
    }
    
    /* Animation */
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
    
    @media (max-width: 576px) {
      .otp-input {
        width: 40px;
        height: 50px;
        font-size: 20px;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6 otp-card">
        <div class="card">
          <div class="card-header">
            <div class="icon-container">
              <i class="fas fa-lock lock-icon"></i>
            </div>
            <h2>Enter Verification Code</h2>
          </div>
          <div class="card-body">
            <!-- Error Message Area -->
            <div class="error-message" id="errorMessage" style="display: none;">
              <p class="text-danger">
                <i class="fas fa-exclamation-circle mr-2"></i>
                <span id="errorText">Invalid OTP. Please try again.</span>
              </p>
            </div>
            
            <p class="text-center mb-4">We've sent a verification code to your email. Please enter the code below.</p>
            
            <form id="otp-form" action="ValidateOtp" method="post">
              <!-- OTP Input Fields -->
              <div class="form-group">
                <label for="otp">Verification Code</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">
                      <i class="fas fa-key"></i>
                    </span>
                  </div>
                  <input id="otp" name="otp" class="form-control" type="text" placeholder="Enter OTP" required maxlength="6">
                </div>
                <small class="form-text text-muted mt-2">
                  <i class="fas fa-info-circle mr-1"></i>
                  Enter the 6-digit code we sent to your email
                </small>
              </div>
              
              <!-- Alternative OTP Input (Separated fields) -->
              <!--
              <div class="form-group">
                <label>Verification Code</label>
                <div class="otp-container">
                  <input type="text" class="otp-input" maxlength="1" autofocus>
                  <input type="text" class="otp-input" maxlength="1">
                  <input type="text" class="otp-input" maxlength="1">
                  <input type="text" class="otp-input" maxlength="1">
                  <input type="text" class="otp-input" maxlength="1">
                  <input type="text" class="otp-input" maxlength="1">
                </div>
              </div>
              -->
              
              <div class="form-group mb-4">
                <button type="submit" class="btn btn-primary btn-block">
                  <i class="fas fa-check-circle mr-2"></i>Verify & Continue
                </button>
              </div>
              
              <input type="hidden" name="token" id="token" value="">
            </form>
            
            <div class="otp-info">
              <p>Didn't receive the code? <a href="#" class="resend-link">Resend OTP</a></p>
              <div class="timer">
                <i class="fas fa-hourglass-half mr-1"></i>
                <span id="countdown">01:30</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>
  <script>
    // Display error message if present
    $(document).ready(function() {
      // This would need to be integrated with your server-side error handling
      // For demonstration, uncomment to show error
      // $("#errorMessage").show();
      
      // OTP timer countdown
      var timeLeft = 90;
      var countdownEl = document.getElementById('countdown');
      
      var countdownTimer = setInterval(function() {
        timeLeft--;
        
        var minutes = Math.floor(timeLeft / 60);
        var seconds = timeLeft % 60;
        
        countdownEl.innerHTML = (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
        
        if (timeLeft <= 0) {
          clearInterval(countdownTimer);
          countdownEl.innerHTML = "00:00";
        }
      }, 1000);
      
      // For the alternative OTP input (if used)
      $(".otp-input").keyup(function(e) {
        if (this.value.length === this.maxLength) {
          $(this).next('.otp-input').focus();
        }
        
        // On backspace, go to previous input
        if (e.key === "Backspace" && this.value.length === 0) {
          $(this).prev('.otp-input').focus();
        }
      });
    });
  </script>
</body>
</html>