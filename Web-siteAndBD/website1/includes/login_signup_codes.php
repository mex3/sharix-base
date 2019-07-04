<?php
session_start();
include("../config/connect.php");
$req = filter_var(htmlentities($_POST['req']),FILTER_SANITIZE_STRING);
switch ($req) {
// ============================= [ Login code ] =============================
case 'login_code':
$username = htmlentities($_POST['un'], ENT_QUOTES);
$password = htmlentities($_POST['pd'], ENT_QUOTES);
if($username == null && $password == null){
echo "<p class='alertRed'>".lang('enter_username_to_login')."</p>";
}elseif ($username == null){
    echo "<p class='alertRed'>".lang('enter_username_to_login')."</p>";
}elseif($password == null){
    echo "<p class='alertRed'>".lang('enter_password_to_login')."</p>";
}else{
    $chekPwd = $conn->prepare("SELECT * FROM signup WHERE username = :username OR email= :email");
    $chekPwd->bindParam(':email', $username, PDO::PARAM_STR);
    $chekPwd->bindParam(':username',$username,PDO::PARAM_STR);
    $chekPwd->execute();
    while ($row = $chekPwd->fetch(PDO::FETCH_ASSOC)) {
        $rusername = $row['username'];
        $remail = $row['email'];
        $rpassword = $row['password'];
    }

    if (isset($_COOKIE['linAtt']) AND $_COOKIE['linAtt'] == $username) {
        echo "<p class='alertRed'>".lang('cannot_login_attempts').".</p>";
    }else{
    // check if user try to login in his username or email
    $email_pattern = "/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$/i";
    if (preg_match($email_pattern, $username)) {
        $un_or_em = $remail;
    }else{
        $un_or_em = $rusername;
    }
    // ========================
    if ($un_or_em != $username) {
        echo "<p class='alertRed'>".lang('un_email_not_exist')."!</p>";
        
    }elseif (!password_verify($password,$rpassword)) {
        $checkAttempts = $conn->prepare("SELECT login_attempts FROM signup WHERE username = :username");
        $checkAttempts->bindParam(':username',$username,PDO::PARAM_STR);
        $checkAttempts->execute();
        while ($attR = $checkAttempts->fetch(PDO::FETCH_ASSOC)) {
            $login_attempts = $attR['login_attempts'];
        }
        if ($login_attempts < 3) {
            $attempts = $login_attempts + 1;
            $addAttempts = $conn->prepare("UPDATE signup SET login_attempts =:attempts WHERE username=:username");
            $addAttempts->bindParam(':username',$username,PDO::PARAM_STR);
            $addAttempts->bindParam(':attempts',$attempts,PDO::PARAM_INT);
            $addAttempts->execute();
        }elseif ($login_attempts >= 3) {
            $attempts = 0;
            $addAttempts = $conn->prepare("UPDATE signup SET login_attempts =:attempts WHERE username=:username");
            $addAttempts->bindParam(':username',$username,PDO::PARAM_STR);
            $addAttempts->bindParam(':attempts',$attempts,PDO::PARAM_INT);
            $addAttempts->execute();
            setcookie("linAtt", "$username", time() + (60 * 15), '/');
        }
        $LoginTry = 3 - $login_attempts;
        echo "<p class='alertRed'>".lang('password_incorrect_you_have')." $LoginTry ".lang('attempts_to_login')."</p>";
        
    }else{
    $loginsql = "SELECT * FROM signup WHERE (username= :username OR email= :email) AND password= :rpassword";
    $query = $conn->prepare($loginsql);
    $query->bindParam(':username', $username, PDO::PARAM_STR);
    $query->bindParam(':email', $username, PDO::PARAM_STR);
    $query->bindParam(':rpassword', $rpassword, PDO::PARAM_STR);
    $query->execute();
    $num = $query->rowCount();
    if($num == 0){
        echo "<p class='alertRed'>".lang('un_and_pwd_incorrect')."!</p>";
    }else{
        $_SESSION['attempts'] = 0;
        include ("GeT_login_WhileFetch.php");
        echo "Welcome...";
    }       
    }
    }
}
$conn = null;
break;
// ============================= [ signup code ] =============================
case 'signup_code':
$signup_id = (rand(0,99999).time()) + time();
$signup_first_name = filter_var(htmlentities($_POST['fn']),FILTER_SANITIZE_STRING);
$signup_last_name = filter_var(htmlentities($_POST['ln']),FILTER_SANITIZE_STRING);
$signup_username = filter_var(htmlentities($_POST['un']),FILTER_SANITIZE_STRING);
$signup_email = filter_var(htmlentities($_POST['em']),FILTER_SANITIZE_STRING);
// =========================== password hashinng ==================================
$signup_password_var = filter_var(htmlentities($_POST['pd']),FILTER_SANITIZE_STRING);
$options = array(
    'cost' => 12,
);
$signup_password = password_hash($signup_password_var, $password_BCRYPT, $options);
// ================================================================================
$signup_cpassword = filter_var(htmlentities($_POST['cpd']),FILTER_SANITIZE_STRING);
$signup_genderVar = filter_var(htmlentities($_POST['gr']),FILTER_SANITIZE_STRING);

if ($signup_genderVar == lang('male')) {
    $signup_gender = "Male";
    $userphoto = "user-male.png";
}elseif ($signup_genderVar == lang('female')) {
    $signup_gender = "Female";
    $userphoto = "user-female.png";
}else{
    $signup_gender = "Male";
    $userphoto = "user-male.png";
}

if (isset($_SESSION['language'])) {
    $signup_language = $_SESSION['language'];
}else{
    $signup_language = "English";
}

$eunsql = "SELECT * FROM signup WHERE username=:signup_username";
$exist_username = $conn->prepare($eunsql);
$exist_username->bindParam(':signup_username', $signup_username, PDO::PARAM_STR);
$exist_username->execute();
$eemsql = "SELECT * FROM signup WHERE email=:signup_email";
$exist_email = $conn->prepare($eemsql);
$exist_email->bindParam(':signup_email', $signup_email, PDO::PARAM_STR);
$exist_email->execute();
$num_un_ex = $exist_username->rowCount();
$num_em_ex = $exist_email->rowCount();
if($signup_first_name == null || $signup_last_name == null || $signup_username == null || $signup_email == null || $signup_password == null || $signup_cpassword == null){
       echo "<p class='alertRed'>".lang('please_fill_required_fields')."</p>";
}elseif($num_un_ex == 1){
       echo "<p class='alertRed'>".lang('user_already_exist')."</p>";
}elseif($num_em_ex == 1){
        echo "<p class='alertRed'>".lang('email_already_exist')."</p>";
}elseif(strlen($signup_password) < 6){
    echo "<p class='alertRed'>".lang('password_short').".</p>";
}elseif($signup_password_var != $signup_cpassword){
    echo "<p class='alertRed'>".lang('password_not_match_with_cpassword')."</p>";
}elseif(strpos($signup_username, ' ') !== false || preg_match('/[\'^£$%&*()}{@#~?><>,.|=+¬-]/', $signup_username) || !preg_match('/[A-Za-z0-9]+/', $signup_username)) {
    echo "
    <ul class='alertRed' style='list-style:none;'>
        <li><b>".lang('username_not_allowed')." :</b></li>
        <li><span class='fa fa-times'></span> ".lang('signup_username_should_be_1').".</li>
        <li><span class='fa fa-times'></span> ".lang('signup_username_should_be_2').".</li>
        <li><span class='fa fa-times'></span> ".lang('signup_username_should_be_3').".</li>
        <li><span class='fa fa-times'></span> ".lang('signup_username_should_be_4').".</li>
        <li><span class='fa fa-times'></span> ".lang('signup_username_should_be_5').".</li>
    </ul>";
}elseif (!filter_var($signup_email, FILTER_VALIDATE_email)) {
    echo "<p class='alertRed'>".lang('invalid_email_address')."</p>";
}else{
    // If who signup is the first user, make it [main admin]
    $cusers_q_sql = "SELECT id FROM signup";
    $cusers_q = $conn->prepare($cusers_q_sql);
    $cusers_q->execute();
    $cusers_q_num_rows = $cusers_q->rowCount();
    if ($cusers_q_num_rows < 1) {
    $signup_admin = "1";   
    $signupsql = "INSERT INTO signup (id,first_name,last_name,username,email,password,userphoto,gender,language,admin)
    VALUES( :signup_id, :signup_first_name, :signup_last_name, :signup_username, :signup_email, :signup_password, :userphoto, :signup_gender,:signup_language,:signup_admin)";
    $query = $conn->prepare($signupsql);
    $query->bindParam(':signup_id', $signup_id, PDO::PARAM_INT);
    $query->bindParam(':signup_first_name', $signup_first_name, PDO::PARAM_STR);
	$query->bindParam(':signup_last_name', $signup_last_name, PDO::PARAM_STR);
    $query->bindParam(':signup_username', $signup_username, PDO::PARAM_STR);
    $query->bindParam(':signup_email', $signup_email, PDO::PARAM_STR);
    $query->bindParam(':signup_password', $signup_password, PDO::PARAM_STR);
    $query->bindParam(':userphoto', $userphoto, PDO::PARAM_STR);
    $query->bindParam(':signup_gender', $signup_gender, PDO::PARAM_STR);
    $query->bindParam(':signup_language', $signup_language, PDO::PARAM_STR);
    $query->bindParam(':signup_admin', $signup_admin, PDO::PARAM_INT);
    $query->execute(); 
    }else{
    $signupsql = "INSERT INTO signup (id,first_name,last_name,username,email,password,userphoto,gender,language)
    VALUES( :signup_id, :signup_first_name, :signup_last_name, :signup_username, :signup_email, :signup_password, :userphoto, :signup_gender,:signup_language)";
    $query = $conn->prepare($signupsql);
    $query->bindParam(':signup_id', $signup_id, PDO::PARAM_INT);
    $query->bindParam(':signup_first_name', $signup_first_name, PDO::PARAM_STR);
	$query->bindParam(':signup_last_name', $signup_last_name, PDO::PARAM_STR);
    $query->bindParam(':signup_username', $signup_username, PDO::PARAM_STR);
    $query->bindParam(':signup_email', $signup_email, PDO::PARAM_STR);
    $query->bindParam(':signup_password', $signup_password, PDO::PARAM_STR);
    $query->bindParam(':userphoto', $userphoto, PDO::PARAM_STR);
    $query->bindParam(':signup_gender', $signup_gender, PDO::PARAM_STR);
    $query->bindParam(':signup_language', $signup_language, PDO::PARAM_STR);
    $query->execute(); 
    }
    // ========================== login code after signup ============================
    $loginsql = "SELECT * FROM signup WHERE (username= :signup_username OR email= :signup_email) AND password= :signup_password";
    $query = $conn->prepare($loginsql);
    $query->bindParam(':signup_username', $signup_username, PDO::PARAM_STR);
    $query->bindParam(':signup_email', $signup_email, PDO::PARAM_STR);
    $query->bindParam(':signup_password', $signup_password, PDO::PARAM_STR);
    $query->execute();
    $num = $query->rowCount();
    include ("GeT_login_WhileFetch.php");
    echo "Done..";
}
$conn = null;
break;
}
?>
