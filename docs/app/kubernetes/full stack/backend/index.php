<?
header("Access-Control-Allow-Origin: *");
include 'connection.php';

$id =  rand(1, 999);
$user_name = $_POST["user_name"];
$user_message = $_POST["user_menssage"];

$query = "INSERT INTO messages(id, user_name, user_menssage) VALUES ('$id', '$user_name', '$user_message')";


if ($link->query($query) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $link->error;
}
?>