<?php  

	class DbOperations{

		private $con;

		function __construct(){

			require_once dirname(__FILE__).'/DbConnect.php';

			$db = new DbConnect();

			$this->con = $db->connect();
			

		}

		/*CRUD -> C -> CREATE */

		public function createUser($id, $username, $pass, $email){
				$password = md5($pass);
				$id = time();
				$stmt = $this->con->prepare("INSERT INTO `signup` (`id`, `Username`, `Password`, `Email`) VALUES (?, ?, ?, ?);");
				$stmt->bind_param("ssss",$id,$username,$password,$email);

				if($stmt->execute()){
					return 1;
				}else{
					return 2;
				}
			}
	}

