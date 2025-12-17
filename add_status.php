<?php
$conn = new mysqli("localhost", "root", "", "tracking_system");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$item_id = $_POST['item_id'];
$location = $_POST['location'];
$status = $_POST['status'];
$updated_by = $_POST['updated_by'];

$sql = "INSERT INTO tracking_status (item_id, location, status, updated_by)
        VALUES ('$item_id', '$location', '$status', '$updated_by')";

if ($conn->query($sql) === TRUE) {
    echo "Status Added Successfully";
} else {
    echo "Error: " . $conn->error;
}

$conn->close();
?>
