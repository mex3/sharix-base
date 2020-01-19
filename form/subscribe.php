<?php

///////////////// EDITABLE OPTIONS   /////////////////////

//$receiving_email_address = "youremail@domainname.com";  // Set your email address here which you want to receive emails to
$receiving_email_address = "info@sharix-app.org";  // Set your email address here which you want to receive emails to

$custom_subject = "New user subscribed on your Landing Page."; // Change the subject line of email as per your choice.


// =============================  DO NOT EDIT BELOW THIS LINE  ======================================

if ((isset($_POST['emailSubscribe'])) && (strlen(trim($_POST['emailSubscribe'])) > 0)) {
	$email = stripslashes(strip_tags($_POST['emailSubscribe']));
} else {$email = 'No email entered';}
ob_start();


// Email Building
$to 			= $receiving_email_address;
$email 			= $_POST['emailSubscribe'];
$fromname 			= $_POST['emailSubscribe'];
$fromaddress 	= $_POST['emailSubscribe'];
$body = "<br><br> Email: ".$_POST['emailSubscribe']." ";

// Check if the security is filled

if ( $_POST['sub-security'] == '' ) {

	require("phpmailer.php");
	$mail = new PHPMailer();

	$mail->From    					= "$email";
	$mail->FromName    					= "$email";
	$mail->AddAddress("$receiving_email_address","$receiving_email_address_name");

	$mail->IsHTML(true);

	$mail->Subject  				= "$custom_subject";
	$mail->Body     					= $body;
	$mail->AltBody 					= "This is the text-only body";

	if(!$mail->Send()) {
		$recipient 					= '$receiving_email_address';
		$subject 						= 'Contact form failed';
		$content						= $body;

	  // Send Mail
	  mail($recipient, $subject, $content, "From: $receiving_email_address\r\nReply-To: $email\r\nX-Mailer: DT_formmail");
	  exit;
	}
}

?>
