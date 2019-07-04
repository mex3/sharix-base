<?php
$s_id = $_SESSION['id'];
$s_first_name = $_SESSION['first_name'];
$s_last_name = $_SESSION['last_name'];
$s_username = $_SESSION['username'];
$s_userphoto = $_SESSION['userphoto'];

$un = filter_var(htmlspecialchars($_GET['u']),FILTER_SANITIZE_STRING);
$uisql = "SELECT * FROM signup WHERE username=:un";
$que = $conn->prepare($uisql);
$que->bindParam(':un', $un, PDO::PARAM_STR);
$que->execute();
while($row = $que->fetch(PDO::FETCH_ASSOC)){
    $row_id = $row['id'];
    $row_first_name = $row['first_name'];
	$row_last_name = $row['last_name'];
    $row_username = $row['username'];
    $row_email = $row['email'];
    $row_password = $row['password'];
    $row_user_photo = $row['userphoto'];
    $row_user_cover_photo = $row['user_cover_photo'];
    $row_school = $row['school'];
    $row_work = $row['work'];
    $row_work0 = $row['work0'];
    $row_country = $row['country'];
    $row_birthday = $row['birthday'];
    $row_verify = $row['verify'];
    $row_website = $row['website'];
    $row_bio = $row['bio'];
    $row_admin = $row['admin'];
    $row_gender = $row['gender'];
    $row_profile_pic_border = $row['profile_pic_border'];
    $row_language = $row['language'];
    $row_online = $row['online'];
}
?>