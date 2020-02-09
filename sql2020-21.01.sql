

CREATE TABLE `sharix.Users`   
(
    `UsersId` INT NOT NULL PRIMARY KEY, /* primary key column*/
    `utype`  VARCHAR(3) NOT NULL, /*custemer(rx), bisness(wx), superuser(rwx)*/
    `uname`  VARCHAR(50) NOT NULL, /* имя человека */
    `ulogin` VARCHAR(50) NOT NULL, /* логин человека*/
    `email` VARCHAR (320) NOT NULL, /* почта человека*/
    `TelephoneNumber` INT(5) NOT NULL, /* номер телефона человека*/
    `upassword` VARCHAR(500) NOT NULL, /* пароль человека*/
    `payment` VARCHAR(50) NOT NULL /* счет оплаты*/

);

----------------------------------------------------------------------------------------------------


CREATE TABLE `sharix.orders`
(
    `ordersId` INT NOT NULL PRIMARY KEY, /* primary key column
    `otype` INT(5) NOT NULL, /*otype(type утилита)*/
    `starttime` DATETIME(10) NOT NULL, /*время начала предоставления услуги*/
    `finishtime` DATETIME(10) NOT NULL, /* завершение предоставления услуги*/
    `place` FLOAT(10, 6) NOT NULL, /* Место нахождение check(https://medium.com/maatwebsite/the-best-way-to-locate-in-mysql-8-e47a59892443)*/
    `price` Int (50) NOT NULL, /* цена за услугу */
    `rating` INT(5) NOT NULL, /*рейтинг */
    `idProvider` INT(5) NOT NULL, /*тот кто предоставляет услугу "берем id"*/
    `idResiver` INT(5) NOT NULL /*тот кто заказл услугу "берем id" */
);


----------------------------------------------------------------------------------------------------


CREATE TABLE `sharix.ttype`
(
    `typeId` INT NOT NULL PRIMARY KEY, /*primary key column*/
    `ttype` VARCHAR(50) NOT NULL, /*название*/ 
    `uidtype` VARCHAR(10) NOT NULL /* кто он (provider, resours)*/
);


----------------------------------------------------------------------------------------------------


CREATE TABLE `sharix.provider`
(
    `providerId` INT NOT NULL PRIMARY KEY, /*primary key column*/
    `ptype` INT(5) NOT NULL, /*класс услугии*/
    `pform` INT(5) NOT NULL,
    `pname` INT(5) NOT NULL, /*сам человек*/
    `lagalname` INT(5) NOT NULL /*его ИП*/
);

----------------------------------------------------------------------------------------------------



CREATE TABLE `follows`
(
    `followsId` INT NOT NULL PRIMARY KEY, /*primary key column*/
    `reader` INT(11) NOT NULL, 
    `fRead` INT(11) NOT NULL
);

