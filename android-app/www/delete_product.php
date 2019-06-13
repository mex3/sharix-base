<?php

$response = array();

if (isset($_POST['pid'])) {
    $pid = $_POST['pid'];

    require 'db_connect.php';

    $db = new DB_CONNECT();

    $result = mysql_query("DELETE FROM products WHERE pid = $pid");
    if (mysql_affected_rows() > 0) {
        $response["success"] = 1;
        $response["message"] = "Product successfully deleted";

        echo json_encode($response);
    } else {
        $response["success"] = 0;
        $response["message"] = "No product found";

        echo json_encode($response);
    }
} else {
    $response["success"] = 0;
    $response["message"] = "Required field(s) is missing";

    echo json_encode($response);
}
?>