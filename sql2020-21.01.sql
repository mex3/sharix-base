

CREATE TABLE `sharix.Users`   
(
    `UsersID` INT NOT NULL PRIMARY KEY, /* ID пользователя*/
    `UserType`  VARCHAR(30) NOT NULL, /* тип пользователя (клиент, исполнитель)*/
    `UserName`  VARCHAR(50) NOT NULL, /* имя человека */
    `Login` VARCHAR(50) NOT NULL, /* логин человека*/
    `Email` VARCHAR (320) NOT NULL, /* почта человека*/
    `TelephoneNumber` INT(10) NOT NULL, /* номер телефона человека*/
    `Password` VARCHAR(500) NOT NULL, /* пароль человека*/
    `Payment` VARCHAR(50) NOT NULL /* счет оплаты*/
);


CREATE TABLE `Sharix.Organization`
(
    `OrganizationID` INT NOT NULL PRIMARY KEY, /*ID организации*/
    `OrganizationName` VARCHAR(30) NOT NULL, /*Название организации*/
    `OrganizatoinTypeID` INT(5) NOT NULL, /* ID типа организации */
    `ProviderID` INT(5) NOT NULL /*ID ответственного за услугу лица от организации*/
);

CREATE TABLE `Sharix.OrganizatoinType`
(
    `OrganizatoinTypeID` INT NOT NULL PRIMARY KEY, /*ID типа организации*/
    `OrganizatoinTypeName` VARCHAR(30) NOT NULL /*Название типа организации*/
);

CREATE TABLE `Sharix.Providers`
(
    `ProvederID` INT NOT NULL PRIMARY KEY, /*ID исполнителя услуги*/
    `ProviderName` VARCHAR(30) NOT NULL, /*ФИО исполнителя(из таблицы пользователей)*/
    `OrderTypeID` INT(5) NOT NULL, /* ID типа услуги */
    `OrganizationTypeID` INT(5) NOT NULL, /*ID типа организации*/
    `OrganizationID` INT(5) NOT NULL /*ID организации*/
);




CREATE TABLE `Sharix.NegType`
(
    `NegTypeID` INT NOT NULL PRIMARY KEY, /*ID типа взаимоотношений*/
    `NegTypeName` VARCHAR(30) NOT NULL /*название типа взаимоотношений */
);

CREATE TABLE `Sharix.Negotiations`
(
    `NegotiationsID` INT NOT NULL PRIMARY KEY, /*ID взаимоотношения*/
    `UserIDWho` VARCHAR(30) NOT NULL, /*инициатор услуги*/
    `UserIDWhom` VARCHAR(30) NOT NULL, /*исполнитель услуги*/
    `NegTypeID` INT(5) NOT NULL /*ID типа взаимоотношений*/
);


CREATE TABLE `Sharix.Orders`
(
    `OrdersID` INT NOT NULL PRIMARY KEY, /* ID услуги*/
    `OrderType` VARCHAR(5) NOT NULL, /*тип услуги*/
    `StartTime` DATETIME(5) NOT NULL, /*время начала предоставления услуги*/
    `FinishTimePredicted` DATETIME(5) NOT NULL, /* расчетное время завершение предоставления услуги*/
    `FinishTimeReal` DATETIME(5) NOT NULL, /* реальное время завершение предоставления услуги*/
    `Place` FLOAT(10, 6) NOT NULL, /* Место нахождение*/
    `Price` INT (5) NOT NULL, /* цена за услугу */
    `Rating` INT(5) NOT NULL, /*рейтинг */
    `ProviderID` INT(5) NOT NULL, /*тот кто предоставляет услугу "берем id"*/ 
    `ReceiverID` INT(5) NOT NULL, /*тот кто заказал услугу "берем id" */ 
    `ClientID` INT(5) NOT NULL /*тот кто получил услугу "берем id" */ 
);

CREATE TABLE `Sharix.OrdersType`
(
    `OrdersTypeID` INT NOT NULL PRIMARY KEY, /* ID типа услуги*/
    `OrderType` VARCHAR(5) NOT NULL, /*тип услуги*/
    `ProviderTypeID` INT(5) NOT NULL, /* какого типа поставщики услуг могут оказывать данный тип услуг*/ 
    `ResourcesTypeID` INT(5) NOT NULL /* ID типа ресурса */ 
);

CREATE TABLE `Sharix.ResourceType` 
(
    `ResourceTypeID` INT NOT NULL PRIMARY KEY, /*ID типа ресурса*/
    `ResourceTypeName` VARCHAR(30) NOT NULL /*название типа ресурса*/
);

CREATE TABLE `Sharix.Resources` 
(
    `ResourceID` INT NOT NULL PRIMARY KEY, /*ID ресурса*/
    `ResourceTypeID` INT(5) NOT NULL, /* ID типа ресурса */
    `ResourceName` VARCHAR(30) NOT NULL, /*название ресурса*/
    `ProviderID` INT(5) NOT NULL, /* ID пользователя у которого находится ресурс*/
    `ClientID` INT(5) NOT NULL /* ID пользователя которому необходим ресурс "*/
);

