<?php
	if($_SERVER["REQUEST_METHOD"] == "POST"){
		include "conexao.php";
		$target_dir = "../../img/users/";if(!file_exists($target_dir))
		{
			mkdir($target_dir, 0777, true);
		}
		$target_dir = $target_dir . "/" . basename($_FILES["file"]["name"]);
	
		if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_dir)){
			$sql = "INSERT INTO userZD(name, birthDate, nickname, email, password, image) VALUES(:name, :bDate, :nick, :email, :password, :image)";
			$prpQuery = Conexao::prepare($sql);
			$prpQuery -> bindValue(":name", $_POST["name"]);
			$prpQuery -> bindValue(":bDate", $_POST["bDate"]);
			$prpQuery -> bindValue(":nick", $_POST["nick"]);
			$prpQuery -> bindValue(":email", $_POST["email"]);
			$prpQuery -> bindValue(":password", $_POST["pass"]);
			$prpQuery -> bindValue(":image", $_FILES["file"]["name"]);
			$prpQuery -> execute();
		}
	}
?>
