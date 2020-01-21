--- Create a new database called 'sharix'
-- Connect to the 'master' database to run this snippet
USE master
GO
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'sharix' 
)
CREATE DATABASE sharix
GO

----------------------------------------------------------------------------------------------------
IF OBJECT_ID('sharix.Users', 'U') IS NOT NULL -- СОЗДАЕМ УЧЕТКУ 
DROP TABLE sharix.Users
GO
CREATE TABLE sharix.Users   
(
    UsersId INT NOT NULL PRIMARY KEY, -- primary key column
    utype  VARCHAR(3), --custemer(rx), bisness(wx), superuser(rwx)
    uname  VARCHAR(50) NOT NULL, -- имя человека 
    ulogin VARCHAR(50) NOT NULL, -- логин человека
    email VARCHAR (320) NOT NULL, -- почта человека 
    TelephoneNumber INT(5) NOT NULL, -- номер телефона человека
    upassword VARCHAR(500) NOT NULL -- пароль человека
);
GO

----------------------------------------------------------------------------------------------------
IF OBJECT_ID('sharix.orders', 'U') IS NOT NULL -- СОЗДАЕМ ЗАКАЗЫ
DROP TABLE sharix.orders
GO
CREATE TABLE sharix.orders
(
    ordersId INT NOT NULL PRIMARY KEY, -- primary key column
    otype INT(5) NOT NULL, -- otype(type утилита)(o ордер)
    starttime DATETIME(10) NOT NULL, -- время начала предоставления услуги
    finishtime DATETIME(10) NOT NULL, -- завершение предоставления услуги
    place FLOAT(10, 6) NOT NULL, -- Место нахождение check(https://medium.com/maatwebsite/the-best-way-to-locate-in-mysql-8-e47a59892443)
    price Int (50) NOT NULL, -- цена за услугу 
    rating INT(5) NOT NULL, --рейтинг 
    idProvider INT(5) NOT NULL, --тот кто предоставляет услугу "берем id"
    idResiver INT(5) NOT NULL --тот кто заказл услугу "берем id" 
);
GO

----------------------------------------------------------------------------------------------------
IF OBJECT_ID('sharix.type', 'U') IS NOT NULL -- СОЗДАЕМ ТИП УСЛУГИ 
DROP TABLE sharix.type
GO
CREATE TABLE sharix.type
(
    typeId INT NOT NULL PRIMARY KEY, -- primary key column
    ttype VARCHAR(50) NOT NULL, -- название 
    uidtype VARCHAR(10) NOT NULL -- кто он (provider, resours)
);
GO

----------------------------------------------------------------------------------------------------
IF OBJECT_ID('sharix.provider', 'U') IS NOT NULL -- ДАННЫЕ ПРЕДОСТАВИТЕЛЯ УСЛУГИ 
DROP TABLE sharix.provider
GO
CREATE TABLE sharix.provider
(
    providerId INT NOT NULL PRIMARY KEY, -- primary key column
    ptype INT(5) NOT NULL, -- класс услугии
    pform INT(5) NOT NULL,
    pname INT(5) NOT NULL, -- сам человек
    lagalname INT(5) NOT NULL -- его ИП
);
GO

----------------------------------------------------------------------------------------------------
IF OBJECT_ID('folows') IS NOT NULL
DROP TABLE folows
GO

CREATE TABLE folows
(
    folowsId INT NOT NULL PRIMARY KEY, -- primary key column
    reader INT(11) NOT NULL, 
    fRead INT(11) NOT NULL
);
GO