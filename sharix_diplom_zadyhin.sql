CREATE TABLE `sharix.Users`   /* Таблица пользователей */
(
    `UserID` INT NOT NULL PRIMARY KEY, 	/* ID пользователя 					 */
	`Email` VARCHAR(320) NOT NULL, 		/* почта пользователя               */
	`Login` VARCHAR(50) NOT NULL, 		/* логин пользователя 			   */
	`Password` VARCHAR(500) NOT NULL,	/* пароль пользователя 		      */
    `NameUser` VARCHAR(50) NOT NULL, 	/* имя пользователя 			 */
    `TelephoneNumber` INT(5) NOT NULL	/* номер телефона пользователя  */
);

CREATE TABLE `sharix.Libraries` /* Перечень библиотек */
(
	`LibraryID` INT NOT NULL PRIMARY KEY, 		/* ID библиотеки 						*/
	`LibraryName` VARCHAR(30) NOT NULL,			/* название библиотеки 			   	   */
	`LibraryAddress` VARCHAR(50) NOT NULL,		/* адрес библиотеки 	              */
	`LibraryStartTime` DATETIME(4) NOT NULL,	/* время начала работы библиотеки 	 */
	`LibraryEndTime` DATETIME(4) NOT NULL,		/* время закрытия библиотеки        */
	`Rating` INT(5) NOT NULL					/* рейтинг библиотек               */
);

CREATE TABLE `sharix.Libraries.Halls` /* Таблица читательских залов */
(
	`HallTypeID` INT NOT NULL PRIMARY KEY,						/* ID читательского зала 										  		  */
	`HallTypeName` VARCHAR(30) NOT NULL,						/* название типа читательского зала 							 	     */
	`NumberOfReadingSeats` INT(3) NOT NULL, 					/* количество мест в обычном читательском зале 				    		*/
	`NumberOfComputerSeats` INT(3) NOT NULL,					/* количество мест в компьютерном зале 						   		   */
	`PriceForOneHourForOneReadingSeat` INT(4) NOT NULL,			/* цена аренды одного места в обычном читательском зале за один час   */
	`PriceForOneHourForOneComputerSeat` INT(4) NOT NULL			/* цена аренды одного места в компьютерном зале за один час          */
);

CREATE TABLE `sharix.Orders` /* Список услуг */
(
    `OrderID` INT NOT NULL PRIMARY KEY, 		/* ID услуги 										       */
    `StartTime` DATETIME(6) NOT NULL, 			/* время начала арендования мест 						  */
    `EndTime` DATETIME(6) NOT NULL, 			/* время завершения аренды 								 */
	`NumberOfTime` INT(2) NOT NULL, 			/* количество часов аренды 							    */
	`HallTypeName` VARCHAR(30) NOT NULL,		/* название типа читательского зала 				   */
	`NumberOfSeats` INT(3) NOT NULL,			/* количество арендованных мест 				      */
    `FinalPrice` Int (50) NOT NULL, 			/* окончательная цена за услугу 					 */
    `idProvider` INT(5) NOT NULL, 				/* тот, кто предоставляет услугу, берем "LibraryID" */
    `idResiver` INT(5) NOT NULL 				/* тот, кто заказал услугу, берем "UserID" 	       */
);
