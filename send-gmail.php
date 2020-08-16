<?php
$to = $email;
$subject = "HTML email";

$message = "
<html>
<head>
<title>HTML email</title>
</head>
<body>
<p>You are registered for Anudip Foundation</p>

</body>
</html>
";

// Always set content-type when sending HTML email
$headers = "MIME-Version: 1.0" . "\r\n";
$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";

// More headers
$headers .= 'From: <webmaster@example.com>' . "\r\n";
$headers .= 'Cc: myboss@example.com' . "\r\n";


if (mail($email,$subject,$message,$headers)) {
   echo "Email successfully sent to $email!!!";
//    header("Location:mob-first.html");
} 
else {
        echo "Email sending failed...";
}
?>
