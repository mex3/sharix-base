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
		
		public function userLogin($username, $pass){
			$password = md5($pass);
            $stmt = $this->con->prepare("SELECT id FROM signup WHERE Username = ? AND Password = ?");
            $stmt->bind_param("ss",$username,$password);
            $stmt->execute();
            $stmt->store_result(); 
            return $stmt->num_rows > 0; 
        }
 
        public function getUserByUsername($username){
            $stmt = $this->con->prepare("SELECT * FROM signup WHERE Username = ?");
            $stmt->bind_param("s",$username);
            $stmt->execute();
            return $stmt->get_result()->fetch_assoc();
        }
		
		private function isUserExist($username, $email){
			$stmt = $this->con->prepare("SELECT id FROM signup WHERE Username = ? OR Email = ?");
			$stmt->bind_param("ss", $username, $email);
			$stmt->execute(); 
			$stmt->store_result(); 
			return $stmt->num_rows > 0; 
        }
	}
