<?php
$response = array();

if (isset($_POST['name']) && isset($_POST['price']) && isset($_POST['description'])) {

    $name = $_POST['name'];
    $price = $_POST['price'];
    $description = $_POST['description'];

    require 'db_connect.php';

    $db = new DB_CONNECT();

    $result = mysql_query("INSERT INTO products(name, price, description) VALUES('$name', '$price', '$description')");

    if ($result) {
        $response["success"] = 1;
        $response["message"] = "Product successfully created.";

        echo json_encode($response);
    } else {
        $response["success"] = 0;
        $response["message"] = "Oops! An error occurred.";

        echo json_encode($response);
    }
} else {
    $response["success"] = 0;
    $response["message"] = "Required field(s) is missing";

    echo json_encode($response);
}
?>