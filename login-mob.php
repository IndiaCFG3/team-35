<?php
// Initialize the session
// session_start();
 
// Check if the user is already logged in, if yes then redirect him to welcome page
// if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
//     header("location: landing.html.php");
//     exit;
// }
 
// Include config file
require_once "config-mob.php";
 
// Define variables and initialize with empty values
$username = $password = "";
$username_err = $password_err = "";
 
// Processing form data when form is submitted
if($_SERVER["REQUEST_METHOD"] == "POST"){
 
    // Check if username is empty
    if(empty(trim($_POST["username"]))){
        $username_err = "Please enter username.";
    } else{
        $username = trim($_POST["username"]);
    }
    
    // Check if password is empty
    if(empty(trim($_POST["password"]))){
        $password_err = "Please enter your password.";
    } else{
        $password = trim($_POST["password"]);
    }
    
    // Validate credentials
    if(empty($username_err) && empty($password_err)){
        // Prepare a select statement
        $sql = "SELECT id, username, password FROM users WHERE username = ?";
        
        if($stmt = $mysqli->prepare($sql)){
            // Bind variables to the prepared statement as parameters
            $stmt->bind_param("s", $param_username);
            
            // Set parameters
            $param_username = $username;
            
            // Attempt to execute the prepared statement
            if($stmt->execute()){
                // Store result
                $stmt->store_result();
                
                // Check if username exists, if yes then verify password
                if($stmt->num_rows == 1){                    
                    // Bind result variables
                    $stmt->bind_result($id, $username, $hashed_password);
                    if($stmt->fetch()){
                        if(password_verify($password, $hashed_password)){
                            // Password is correct, so start a new session
                            session_start();
                            
                            // Store data in session variables
                            $_SESSION["loggedin"] = true;
                            $_SESSION["id"] = $id;
                            $_SESSION["username"] = $username;                            
                            
                            // Redirect user to welcome page
                            header("location: mob-first-page.html");
                        } else{
                            // Display an error message if password is not valid
                            $password_err = "The password you entered was not valid.";
                        }
                    }
                } else{
                    // Display an error message if username doesn't exist
                    $username_err = "No account found with that username.";
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            // Close statement
            $stmt->close();
        }
    }
    
    // Close connection
    $mysqli->close();
}
?>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>.thumbnail img {
    width: 100%;
}
.thumbnail {
    padding: 0;
}
.thumbnail .caption-full {
    padding: 9px;
}
  .signn { text-align: center;}
#delete-form {
    display: inline;
}</style>
  <style>
      .col-sm-6{
          padding-left: 100px;
      }
      .container-fluid{
          background-color:gray;
      }
.fa {
  padding: 20px;
  font-size: 30px;
  width: 30px;
  text-align: center;
  text-decoration: none;
  margin: 5px 2px;
  border-radius: 50%;
}

.fa:hover {
    opacity: 0.7;
}

.fa-facebook {
  background: #3B5998;
  color: white;
}

.fa-twitter {
  background: #55ACEE;
  color: white;
}

.fa-google {
  background: #dd4b39;
  color: white;
}

.fa-linkedin {
  background: #007bb5;
  color: white;
}

.fa-youtube {
  background: #bb0000;
  color: white;
}

.fa-instagram {
  background: #125688;
  color: white;
}
  </style>
    <style type="text/css">
        body{ font: 14px sans-serif; }
        .wrapper{ width: 350px; padding: 20px; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container">
  <div class="navbar-header">
    <a  href="#home" class="nav-link disabled">Anudip Foundation For Social Welfare</a>
    </div>
</div>
</nav>
    <div class="wrapper">
        <h2>Login Mobilisers </h2>
        <p>Please fill in your credentials to login.</p>
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <div class="form-group <?php echo (!empty($username_err)) ? 'has-error' : ''; ?>">
                <label>Username</label>
                <input type="text" name="username" class="form-control" value="<?php echo $username; ?>">
                <span class="help-block"><?php echo $username_err; ?></span>
            </div>    
            <div class="form-group <?php echo (!empty($password_err)) ? 'has-error' : ''; ?>">
                <label>Password</label>
                <input type="password" name="password" class="form-control">
                <span class="help-block"><?php echo $password_err; ?></span>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Login">
            </div>
            <!-- <p>Don't have an account? <a href="register.php">Sign up now</a>.</p> -->
        </form>
    </div>  
    <div class="container-fluid">
 
  <div class="row">
    <div class="col-sm-6" >
        <h2>Contact Us</h2>
        <p>India Office:</p>
        <p>Cimsys Towers, 3rd Floor, Plot Y-13, Block-EP,</p>
        <p>Sector-5, Salt Lake, PS: Bidhan Nagar (EAST), Kolkata</p>
        <p>700091</p>
        <p>Email: info@anudip.org</p>
        <p>Phone:8145111444</p>
        <p>:US Office</p>
        <p> 14435C Big Basin Way #256
            Saratoga, CA 95070, USA</p>
    </div>
    <div class="col-sm-6" >
        <h2>Connect With Us</h2><br><br>
        <a href="https://www.facebook.com/AnudipFoundation" class="fa fa-facebook"></a>
        <a href="https://twitter.com/anudipf" class="fa fa-twitter"></a>
        <a href="https://www.linkedin.com/company/anudip-foundation-for-social-welfare" class="fa fa-linkedin"></a>
        <a href="https://www.instagram.com/anudipfoundation" class="fa fa-instagram"></a>
        <a href="https://www.anudip.org/videos/" class="fa fa-youtube"></a>
    </div>
    
  </div>
</div>  
</body>
</html>