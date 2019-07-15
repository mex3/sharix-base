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
			if($this->isUserExist($username,$email)){
                return 0; 
            }else{
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
		
		private function isUserExist($username, $email){
        $stmt = $this->con->prepare("SELECT id FROM users WHERE username = ? OR email = ?");
        $stmt->bind_param("ss", $username, $email);
        $stmt->execute(); 
        $stmt->store_result(); 
        return $stmt->num_rows > 0; 
        }
	}