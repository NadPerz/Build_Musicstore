<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login</title>
  <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
  <link rel="stylesheet" href="css/registrationStyle.css">
</head>
<body>

<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">

<div class="container">
  <div class="left">
    <h2>Welcome Back</h2>
    <p>Sign in to continue</p>

    <form method="post" action="LoginServlet" class="register-form" id="login-form">
      <div class="form-group">
        <label for="username">Your Email</label>
        <input type="text" name="username" id="username" placeholder="nadijaviyaktha@gmail.com" />
      </div>

      <div class="form-group">
        <label for="password">Your Password</label>
        <input type="password" name="password" id="password" placeholder="pass@jsi**##" />
      </div>

      <div class="form-group checkbox-group">
        <!-- <label class="checkbox-label">
          <input type="checkbox" name="remember-me" id="remember-me" class="agree-term" />
          Remember me
        </label> -->
        <a href="forgotPassword.jsp">Forgot Password?</a>
        
      </div>

      <div class="form-group form-button">
        <input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
      </div>
    </form>

    <div class="signup-link">
      Don't have an account? <a href="registration.jsp">Sign Up</a>
    </div>
  </div>

  <div class="right">
    <img src="images/musicStorelogin.jpg" alt="Login image">
    <div class="right-content">
      <h2>Where words fail, music speaks.</h2>
      <p>"Music gives a soul to the universe, wings to the mind, flight to the imagination and life to everything."</p>
    </div>
  </div>
</div>

<!-- JS for alerts -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    var status = document.getElementById("status").value;
    if (status === "failed") {
      swal("Sorry", "Wrong Username or Password", "error");
    }else if(status === "resetSuccess"){
   	 swal("hooray !", "Password reset successful", "success");
    }else if(status === "resetFailed"){
   	 swal("ooh noo!", "Password reset error", "error");
    }
  });
</script>

</body>
</html>
