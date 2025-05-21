<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Sign Up</title>
  <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
  <link rel="stylesheet" href="css/registrationStyle.css">
</head>
<body>

<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">

<div class="container">
  <div class="left">
    <h2>Create Your Account</h2>
    <p>Sign up to get started</p>

    <form method="post" action="RegistrationServlet" class="register-form" id="register-form">
      <div class="form-group">
        <label for="name">Your Name</label>
        <input type="text" name="name" id="name" placeholder="Nadija Perera" />
      </div>

      <div class="form-group">
        <label for="email">Your Email</label>
        <input type="email" name="email" id="email" placeholder="nadijaviyaktha@gmail.com" />
      </div>

      <div class="form-group">
        <label for="pass">Password</label>
        <input type="password" name="pass" id="pass" placeholder="pass@jsi**##" />
      </div>

      <div class="form-group">
        <label for="re_pass">Repeat Password</label>
        <input type="password" name="re_pass" id="re_pass" placeholder="pass@jsi**##" />
      </div>

      <div class="form-group">
        <label for="contact">Contact No</label>
        <input type="text" name="contact" id="contact" placeholder="071 226 7727" />
      </div>

     <div class="form-group checkbox-group">
		  <label class="checkbox-label">
		    <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
		    I agree all statements in <a href="#" class="term-service">Terms of service</a>
		  </label>
	</div>



      <div class="form-group form-button">
        <input type="submit" name="signup" id="signup" class="form-submit" value="Register" />
      </div>
    </form>

    <div class="signup-link">
      Already have an account? <a href="login.jsp">Sign In</a>
    </div>
  </div>

  <div class="right">
    <img src="images/musicStorelogin.jpg" alt="Sign up image">
    <div class="right-content">
      <h2>Create your life rather than live it.</h2>
      <p>"Life seems to go on without effort when I am filled with music."</p>
    </div>
  </div>
</div>

<!-- JS for alerts -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    var status = document.getElementById("status").value;
    if (status === "Success") {
      swal("Congrats", "Account Created Successfully", "success");
    }
  });
</script>

</body>
</html>
