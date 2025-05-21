<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <title>Password Reset | Account Recovery</title>
  <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet'>
  <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css' rel='stylesheet'>
  <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
  <style>
    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #e8d0dc 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #505050;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      font-size: 14px;
      line-height: 1.6;
      padding: 20px;
    }

    .container {
      max-width: 800px;
    }

    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      transition: all 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    }

    .forgot {
      background-color: #fff;
      padding: 30px;
      border-radius: 15px 15px 0 0;
      border-bottom: 1px solid #f0f0f0;
    }

    .forgot h2 {
      color: #A35C7A;
      margin-bottom: 20px;
      font-weight: 600;
      font-size: 26px;
    }

    .text-primary {
      color: #A35C7A !important;
    }

    .forgot p {
      color: #666;
      margin-bottom: 25px;
      font-size: 15px;
    }

    .list-unstyled {
      padding-left: 10px;
    }

    .list-unstyled li {
      margin-bottom: 15px;
      display: flex;
      align-items: baseline;
    }

    .text-medium {
      font-weight: 600;
      margin-right: 10px;
      display: inline-block;
      width: 24px;
      height: 24px;
      line-height: 24px;
      text-align: center;
      background-color: #A35C7A;
      color: white;
      border-radius: 50%;
      font-size: 12px;
    }

    .card-body {
      padding: 30px;
    }

    .form-group label {
      font-weight: 600;
      color: #555;
      margin-bottom: 10px;
      display: block;
    }

    .form-control {
      border-radius: 8px;
      padding: 12px 15px;
      height: auto;
      border: 1px solid #ddd;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      color: #495057;
      background-color: #fff;
      border-color: #A35C7A;
      box-shadow: 0 0 0 3px rgba(163, 92, 122, 0.2);
    }

    .form-text {
      margin-top: 8px;
      font-size: 13px;
    }

    .card-footer {
      background-color: #f9f9f9;
      padding: 20px 30px;
      border-top: none;
      border-radius: 0 0 15px 15px;
    }

    .btn {
      padding: 12px 24px;
      font-size: 14px;
      font-weight: 600;
      border-radius: 8px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      transition: all 0.3s ease;
    }

    .btn-success {
      background-color: #A35C7A;
      border-color: #A35C7A;
    }

    .btn-success:hover, .btn-success:focus {
      background-color: #8d4e6a;
      border-color: #8d4e6a;
      box-shadow: 0 5px 15px rgba(163, 92, 122, 0.4);
    }

    .btn-danger {
      background-color: #fff;
      border-color: #ddd;
      color: #555;
    }

    .btn-danger:hover, .btn-danger:focus {
      background-color: #f1f1f1;
      border-color: #ddd;
      color: #333;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }

    /* Animation for card */
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

    .card {
      animation: fadeInUp 0.6s ease-out forwards;
    }

    /* Responsive adjustments */
    @media (max-width: 576px) {
      .card-footer {
        text-align: center;
      }
      
      .btn {
        display: block;
        width: 100%;
        margin-bottom: 10px;
      }
    }
  </style>
</head>
<body oncontextmenu='return false' class='snippet-body'>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8 col-md-10">
        <div class="card">
          <div class="forgot">
            <h2><i class="fas fa-lock mr-2"></i>Forgot your password?</h2>
            <p>Reset your password in three easy steps. We're committed to protecting your account security.</p>
            <ol class="list-unstyled">
              <li><span class="text-medium">1</span> Enter your email address below</li>
              <li><span class="text-medium">2</span> Our system will send you a secure OTP code</li>
              <li><span class="text-medium">3</span> Enter the OTP on the next page to create a new password</li>
            </ol>
          </div>
          <form class="mt-0" action="forgotPassword" method="POST">
            <div class="card-body">
              <div class="form-group">
                <label for="email-for-pass"><i class="fas fa-envelope mr-2"></i>Email Address</label>
                <input class="form-control" type="email" name="email" id="email-for-pass" placeholder="Enter your registered email" required="">
                <small class="form-text text-muted"><i class="fas fa-info-circle mr-1"></i>We'll send a verification code to this email address</small>
              </div>
            </div>
            <div class="card-footer d-flex justify-content-between">
              <button class="btn btn-danger" type="button">
                <i class="fas fa-arrow-left mr-2"></i>Back to Login
              </button>
              <button class="btn btn-success" type="submit">
                <i class="fas fa-paper-plane mr-2"></i>Send Reset Code
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
</body>
</html>