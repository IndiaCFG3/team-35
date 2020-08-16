<html>
  <head>
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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

    <!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-P5L6NHL');</script>
<!-- End Google Tag Manager -->


    <title>Registration Form</title>
    <link rel="stylesheet" href="styles.css">
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css"> -->
  </head>
  <body>
  <body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container">
  <div class="navbar-header">
    <a  href="#home" class="nav-link disabled">Anudip Foundation For Social Welfare</a>
    </div>
</div>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-P5L6NHL"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->


    <?php

  //$conn = mysqli_connect("localhost","root","","register");
    $name = $email = $phone = $course = $branch = "";
    $nameErr = $emailErr = $phoneErr = $courseErr = $branchErr = "";
    $nameErr2 = $emailErr2 = $phoneErr2 = $courseErr2 = $branchErr2 = "";

    function test_input($data) {
      $data = trim($data);
      $data = stripslashes($data);
      $data = htmlspecialchars($data);
      return $data;
    }

  if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    
    if (empty($_POST["name"])) {
      $nameErr = "Name is required";
    }
    else {
      $name = test_input($_POST["name"]);
      if(!preg_match("/^[a-zA-Z ]*$/",$name)) {
        $nameErr = "Only Letters and white space allowed";
      }
      else{
        $nameErr2 = "true";
      }
    }
    
    if(empty($_POST["email"])) {
      $emailErr = "Email is required";
    }
    else {
      $email = test_input($_POST["email"]);
      if(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $emailErr = "Invalid Email Format";
      }
      else{
        $emailErr2 = "true";
      }
    }
    
    if(empty($_POST["phone"])) {
      $phoneErr = "Phone number is required";
    }
    else {
      $phone = test_input($_POST["phone"]);
      if(!preg_match("/^[0-9]{10}+$/",$phone)) {
        $phoneErr = "Invalid phone number";
      }
      else{
        $phoneErr2 = "true";
      }
    }
    
    if (empty($_POST["course"])) {
      $courseErr = "Course name is required";
    }
    else {
      $course = test_input($_POST["course"]);
      if(!preg_match("/^[a-zA-Z ]*$/",$course)) {
        $nameErr = "Only Letters and white space allowed";
      }
      else{
        $courseErr2 = "true";
      }
    }
    
    // if (empty($_POST["branch"])) {
    //   $branchErr = "Branch is required";
    // }
    // else {
    //   $branch = test_input($_POST["branch"]);
    //   if(!preg_match("/^[a-zA-Z ]*$/",$branch)) {
    //     $branchErr = "Only Letters and white space allowed";
    //   }
    //   else{
    //     $branchErr2 = "true";
    //   }
    // }
    
  
  }
?>
    
  
    <container class="register">
      <div class="heading">
        <h1>Enter student details</h1>
      </div>
      <div class="details">
        <!-- <p><span class="error">* required feild</span></p><br><br> -->
        <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
          <label>Full Name:</label> 
          <input class="inputclass" type="text" name="name" value="<?php echo $name; ?>" ><br>
          <span class="error">* <?php echo $nameErr; ?></span>
          <br><br>
          <label>Email:</label> 
          <input class="inputclass" type="email" name="email" value="<?php echo $email; ?>" ><br>
          <span class="error">* <?php echo $emailErr; ?></span>
          <br><br>
          <label>Phone:</label> 
          <input class="inputclass" type="tel" name="phone" value="<?php echo $phone; ?>" ><br>
          <span class="error">* <?php echo $phoneErr; ?></span>
          <br><br>
          <label>Course:</label> 
          <input class="inputclass" type="text" name="course" value="<?php echo $course; ?>" ><br>
          <span class="error">* <?php echo $nameErr; ?></span>
          <br><br>
          <!-- <label>Branch:</label> 
          <input class="inputclass" type="text" name="branch" value="<?php echo $branch; ?>" ><br>
          <span class="error">* <?php echo $branchErr; ?></span>
          <br> -->
          <input class="button" type="submit" name="submit" value="submit" >
          <br>
        </form>
      </div>
    </container>
  
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

  <?php
    
    if(($nameErr2 == "true")&&($emailErr2 == "true")&&($phoneErr2 == "true")) 
    {
      //echo "successfully subitted";
        include "action_page.php";
    }
    
    
    
  ?>
    
  </body> 
</html>