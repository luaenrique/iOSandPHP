<?php
		include "connection.php";
    
		$sql = "SELECT id,title,category,deadline,situation from tasks";
    
		$dataJSON = Connection::prepare($sql);
		$dataJSON -> execute();
		foreach($dados as $jsonencoding){
			$tasks['tasks'][] = array('id' => $jsonencoding -> id, 'title' => $jsonencoding -> title, 'category' => $jsonencoding -> category,'deadline' => $jsonencoding -> deadline, 'situation' => $jsonencoding -> situation);
		}
			echo json_encode($tasks);
?>
