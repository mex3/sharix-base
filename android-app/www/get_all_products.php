<?php

$response = array();

require 'db_connect.php';

$db = new DB_CONNECT();

$result = mysql_query("SELECT *FROM products") or die(mysql_error());

if (mysql_num_rows($result) > 0) {
    $response["products"] = array();

    while ($row = mysql_fetch_array($result)) {
        $product = array();
        $product["pid"] = $row["pid"];
        $product["name"] = $row["name"];
        $product["price"] = $row["price"];
        $product["created_at"] = $row["created_at"];
        $product["updated_at"] = $row["updated_at"];

        array_push($response["products"], $product);
    }
    $response["success"] = 1;

    echo json_encode($response);
} else {
    $response["success"] = 0;
    $response["message"] = "No products found";

    echo json_encode($response);
}
?>