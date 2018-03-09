<?php
	if($_SERVER["REQUEST_METHOD"] == "POST"){
		include "connection.php";
		$sql = "INSERT INTO userZD(name, birthDate, nickname, email, password, image) VALUES(:name, :bDate, :nick, :email, :password, :image)";
		$prpQuery = Connection::prepare($sql);
		$prpQuery -> bindValue(":name", $_POST["name"]);
		$prpQuery -> bindValue(":bDate", $_POST["dateb"]);
		$prpQuery -> bindValue(":nick", $_POST["nick"]);
		$prpQuery -> bindValue(":email", $_POST["email"]);
		$prpQuery -> bindValue(":password", $_POST["pass"]);
		$prpQuery -> bindValue(":image", "default.png");
		$prpQuery -> execute();
	}
?>
