<html>
  <head></head>
  <body>
    <?php
    
    $conn = mysqli_connect("localhost","root","","register");

    $name = mysqli_real_escape_string($conn, $_POST["name"]);
    $email = mysqli_real_escape_string($conn, $_POST["email"]);
    $phone = mysqli_real_escape_string($conn, $_POST["phone"]);
    $course = mysqli_real_escape_string($conn, $_POST["course"]);
    // $branch = mysqli_real_escape_string($conn, $_POST["branch"]);
    
    $sql = "INSERT INTO registertb2(name, email, phone, course) VALUES (?, ?, ?, ?);";

    $stmt = mysqli_stmt_init($conn);

    if(!mysqli_stmt_prepare($stmt, $sql)) {
      echo "SQL error";
    } 
    else {
      mysqli_stmt_bind_param($stmt, "ssss", $name, $email, $phone, $course);
      mysqli_stmt_execute($stmt);
      include "send-gmail.php";
    }
    $name = $email = $phone = $course = $branch = "";
    $nameErr = $emailErr = $phoneErr = $course = $branchErr = "";
    $nameErr2 = $emailErr2 = $phoneErr2 = $course = $branchErr2 = "";
?>
    <script>
      alert("successfully submitted");
      
    </script>
  
  </body>
</html>



