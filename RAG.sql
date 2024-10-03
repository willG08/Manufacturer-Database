DROP DATABASE IF EXISTS RAG;
CREATE DATABASE IF NOT EXISTS RAG;
USE RAG;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE IF NOT EXISTS Manufacturer(
ManufacturerID INT NOT NULL AUTO_INCREMENT,
ManufacturerName VARCHAR(50) NOT NULL,
PRIMARY KEY(ManufacturerID)
);

CREATE TABLE IF NOT EXISTS Model(
ModelID INT NOT NULL AUTO_INCREMENT,
ModelName Varchar(50) NOT NULL,
ManufacturerID INT NOT NULL,
PRIMARY KEY(ModelID),
FOREIGN KEY(ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);

CREATE TABLE IF NOT EXISTS VehicleTrim(
TrimID INT NOT NULL AUTO_INCREMENT,
TrimName VARCHAR(50) NOT NULL,
ModelID INT NOT NULL,
PRIMARY KEY(TrimID),
FOREIGN KEY(ModelID) REFERENCES Model(ModelID)
);

CREATE TABLE IF NOT EXISTS Vehicle(
VehID INT NOT NULL AUTO_INCREMENT,
VehVIN VARCHAR(25) NOT NULL,
VehYear CHAR(2) NOT NULL,
VehColor VARCHAR(25) NOT NULL,
VehMileage DECIMAL(8,2),
TrimID INT NOT NULL,
PRIMARY KEY(VehID),
FOREIGN KEY(TrimID) REFERENCES VehicleTrim(TrimID)
);

CREATE TABLE IF NOT EXISTS Inventory(
InventoryID INT NOT NULL AUTO_INCREMENT,
InvWholesale DECIMAL(8,2) NOT NULL,
InvRetail DECIMAL(8,2) NOT NULL,
VehID INT NOT NULL,
PRIMARY KEY(InventoryID),
FOREIGN KEY(VehID) REFERENCES Vehicle(VehID)
);

CREATE TABLE IF NOT EXISTS Customer(
CustomerID INT NOT NULL AUTO_INCREMENT,
CustFirst VARCHAR(25) NOT NULL,
CustLast VARCHAR(25) NOT NULL,
PRIMARY KEY(CustomerID)
);

CREATE TABLE IF NOT EXISTS Employee(
EmployeeID INT NOT NULL AUTO_INCREMENT,
EmpFirst VARCHAR(25) NOT NULL,
EmpLast VARCHAR(25) NOT NULL,
EmpAddress VARCHAR(40) NOT NULL,
EmpCity VARCHAR(25) NOT NULL,
EmpState CHAR(2) NOT NULL,
EmpZip CHAR(9) NOT NULL,
EmpPhone CHAR(10) NOT NULL,
EmpDOB DATE NOT NULL,
PRIMARY KEY(EmployeeID)
);

CREATE TABLE IF NOT EXISTS Invoice(
InvoiceID INT  NOT NULL AUTO_INCREMENT,
InvoiceDate DATE NOT NULL,
InvoiceAmount DECIMAL(8,2) NOT NULL,
InventoryID INT NOT NULL,
CustomerID INT NOT NULL,
EmployeeID INT NOT NULL,
PRIMARY KEY(InvoiceID),
FOREIGN KEY(InventoryID) REFERENCES Inventory(InventoryID),
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
) AUTO_INCREMENT = 2001;

CREATE TABLE IF NOT EXISTS ServiceTicket(
STID INT NOT NULL AUTO_INCREMENT,
VehID INT NOT NULL,
CustID INT NOT NULL,
STTimeIn DATETIME NOT NULL,
STTimeOut DATETIME NOT NULL,
STComments VARCHAR(255),
PRIMARY KEY(STID),
FOREIGN KEY (VehID) REFERENCES Vehicle(VehID)
) AUTO_INCREMENT = 10001;

CREATE TABLE IF NOT EXISTS Service(
ServiceID INT NOT NULL AUTO_INCREMENT,
ServiceName VARCHAR(25) NOT NULL,
ServiceRate DECIMAL(4,2) NOT NULL,
PRIMARY KEY(ServiceID)
);

CREATE TABLE IF NOT EXISTS Dealership(
DealershipID INT NOT NULL,
DealershipName VARCHAR(25) NOT NULL,
DealershipStreet VARCHAR(25) NOT NULL,
DealershipCity VARCHAR(25) NOT NULL,
DealershipState CHAR(2) NOT NULL,
DealershipZip CHAR(9) NOT NULL,
PRIMARY KEY(DealershipID)
);


CREATE TABLE IF NOT EXISTS ServiceTicketDetails(
STDID INT NOT NULL AUTO_INCREMENT,
STDQty TINYINT NOT NULL,
STDComments VARCHAR(255),
STDWarrantyItem CHAR(1) NOT NULL,
STID INT NOT NULL,
EmployeeID INT NOT NULL,
ServiceID INT NOT NULL,
PRIMARY KEY(STDID),
FOREIGN KEY(STID) REFERENCES ServiceTicket(STID),
FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID),
FOREIGN KEY(ServiceID) REFERENCES Service(ServiceID)
);

CREATE TABLE IF NOT EXISTS PositionTitle(
PositionID INT NOT NULL AUTO_INCREMENT,
PositionName VARCHAR(25),
PRIMARY KEY(PositionID)
);

CREATE TABLE IF NOT EXISTS PayHistory(
PHID INT NOT NULL AUTO_INCREMENT,
PHBeginDate DATE NOT NULL,
PHEndDate DATE,
PHRate DECIMAL(8,2) NOT NULL,
PHPayType CHAR(1) NOT NULL,
PHCommission DECIMAL(8,2),
EmployeeID INT NOT NULL,
PositionID INT NOT NULL,
DealershipID INT NOT NULL,
PRIMARY KEY(PHID),
FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID),
FOREIGN KEY(PositionID) REFERENCES PositionTitle(PositionID),
FOREIGN KEY(DealershipID) REFERENCES Dealership(DealershipID)
);

CREATE TABLE IF NOT EXISTS Part(
PartID INT NOT NULL AUTO_INCREMENT,
PartName VARCHAR(25) NOT NULL,
PartRetail DECIMAL(8,2) NOT NULL,
PRIMARY KEY(PartID)
) AUTO_INCREMENT=5001;

CREATE TABLE IF NOT EXISTS PartsUsed(
PUID INT NOT NULL AUTO_INCREMENT,
PUQTY TINYINT NOT NULL,
PartID INT NOT NULL,
STDID INT NOT NULL,
PRIMARY KEY(PUID),
FOREIGN KEY(PartID) REFERENCES Part(PartID),
FOREIGN KEY(STDID) REFERENCES ServiceTicketDetails(STDID)
);



Insert INTO dealership
Values (7111,'RAG Clearfield','123 Main Street','Clearfield','UT',84104),
(5626,'Relational Group Ogden','123 Jackson Ave','Ogden','UT',84108),
(7845,'RAG Layton','123 Pioneer Dr','Layton','UT',84101),
(1236,'Holliday','123 Christmas Cir','Holladay','UT',84117),
(8988,'RAG SugarHouse','123 Easy Way','Salt Lake City','UT',84106);
INSERT INTO positiontitle (positionName)
VALUES ('Sales'),
('Mechanic'),
('Office');
INSERT INTO Service (ServiceName, ServiceRate)
VALUES ('Oil Change',29.95),
('Tire Rotation',15.95),
('Safety Inspection',12),
('Emissions Testing',28),
('Labor - General',89),
('Disposal Fees',4.95),
('Cash Wash',7.5),
('Vacuum',2.5);

INSERT INTO Employee (EmpFirst, EmpLast, EmpAddress, EmpCity, EmpState, EmpZip,
EmpPhone, EmpDOB)
VALUES ('Rodriguez','Herminio','135 Pacocha Square','Rock
Springs','WY','82901','3079796360','1969-07-07'),
('Schimmel','Melba','2781 Casper Villages','Ogden','UT','84408','8016356458','1964-10-10'),
('Oberbrunner','Tyrell','3553 Elise Meadow','Salt Lake City','UT','84117','8015452187','1994-07-31'),
('Dickinson','Alvah','4247 FramiSprings','Evanston','WY','82930','3074587412','1977-02-21'),
('Hane','Olaf','6991 Laurence Wall','Salt Lake City','UT','84106','8012578964','1990-10-18'),
('Muller','Sharon','3721 Halie Gateway','Park City','UT','84101','3853339978','1982-01-15'),
('Murray',' Jadyn','6569 Khalil Expressway','Layton','UT','84404','3857891234','2000-05-02'),
('Ebert','Aiyana','400 Cecelia Mountains','Clearfield','UT','84405','8015456318','1966-06-06'),
('Schaden','Kattie','203 Schneider Plains','Ogden','UT','84408','8016356874','1998-08-07'),
('Langosh','Kenneth','245 Ebert Prairie','Park City','UT','84101','3857554422','1998-11-08');
INSERT INTO customer (CustFirst, CustLast)
VALUES ('Schuster','Ryann'),
('Mayer','Jane'),
('Marvin','Richard'),
('Crist','Lafayette'),
('Johns','Maggie'),
('Flatley','Austen'),
('Yost','Maurice'),
('Graham','Fiona'),
('Wisozk','Mariano'),
('Russel','Sherwood'),
('Fisher','Madyson'),
('Grady','Cecilia'),
('Kautzer','Sister'),
('Kilback','Brennan'),
('Bednar','Brenda'),
('Kovacek','Amari'),
('Marquardt','Juwan'),
('Rogahn','Travon'),
('Hudson','Yadira'),
('Gislason','Jeramie'),
('Grimes','Kattie'),
('Pollich','Lela'),
('Howell','Brianne'),
('Nader','Patricia'),
('Wisoky','Anderson'),
('Marks','Ryley'),
('Hane','Lola'),
('Jast','Monique'),
('Heller','Elisabeth'),
('Aufderhar','Archibald'),
('Murray','Antonio'),
('Abshire','Kade'),
('Ebert','Clark'),
('Hirthe','Lora'),
('Tromp','Gianni'),
('Mayer','Makenzie'),
('Dach','Natalie'),
('Kiehn','Kadin'),
('Wolf','Chaz'),
('Bogan','Sadye'),
('Olson','Ciara'),
('Leffler','Florencio'),
('Cassin','Demond'),
('Rohan','Hallie'),
('Gottlieb','Leilani'),
('Bruen','Lydia'),
('Corwin','Veda'),
('Tromp','Shana'),
('Carroll','Ernestina'),
('Koepp','Yadira'),
('Powlowski','Doris'),
('Cummerata','Grace'),
('Halvorson','Meda'),
('Heller','Jarret'),
('Sauer','Telly'),
('Batz','Felipe'),
('Towne','Harvey'),
('Batz','Ansley'),
('Brekke','Emmitt'),
('Koch','Dorthy'),
('Daniel','Piper'),
('Schiller','Carol'),
('Parisian','Milo'),
('Halvorson','Lambert'),
('Reichel','Delmer'),
('Ziemann','Omari'),
('Powlowski','Mario'),
('OKeefe','Kamille'),
('OKeefe','Felicity'),
('Mohr','Hadley'),
('Fadel','Doyle'),
('DuBuque','Cesar'),
('Hagenes','Dillan'),
('OConner','Walker'),
('Hayes','Armani'),
('Hilpert','Elsa'),
('Gleichner','Novella'),
('Stiedemann','Allene'),
('Bernhard','Eldon'),
('Harris','Willie'),
('Larson','Tom'),
('Trantow','Seth'),
('Torphy','Leland'),
('Bashirian','Kris'),
('Beier','Joe'),
('Mertz','Daphney'),
('Wintheiser','Erika'),
('Luettgen','Carmine'),
('Friesen','Kenyatta'),
('Lueilwitz','Laverne'),
('Durgan','Eldon'),
('Kilback','Preston'),
('Bernhard','Sophia'),
('Kuhic','Verna'),
('Bauch','Carmel'),
('Hintz','Presley'),
('Lindgren','Rosie'),
('Hegmann','Johathan'),
('Kreiger','Sammy'),
('Hermiston','Sigmund'),
('Murazik','Weston'),
('Predovic','Juston'),
('Hermann','Malika'),
('Jaskolski','Kendra'),
('Kunde','Rosamond'),
('Becker','Anibal'),
('Hane','Reta'),
('Crona','Kyla'),
('McClure','Chaya'),
('Goldner','Myriam'),
('Bergstrom','Abdul'),
('Veum','Cleve'),
('Collins','Christopher'),
('Murray','Milford'),
('Hudson','Jevon'),
('Wyman','Emory'),
('Bauch','Dorothea'),
('Dibbert','Judson'),
('Conroy','Sean'),
('Gerlach','Coby'),
('Stark','Dustin'),
('Guann','Pearl'),
('Shanahan','Davon'),
('Fritsch','Shayna'),
('Sauer','Gail'),
('Nitzsche','Mariam'),
('Harvey','Krystel'),
('Casper','Annabell'),
('VonRueden','Katherine'),
('Spencer','Sienna'),
('Erdman','Dolores'),
('Veum','Jan'),
('Braun','Matteo'),
('Jewess','Raven'),
('Tremblay','Helga'),
('Lemke','Tess'),
('Corwin','Haylie'),
('Towne','Santino'),
('Williamson','Orpha'),
('Lindgren','Rebekah'),
('Kozey','Clarissa'),
('Hilll','Domingo'),
('Rolfson','Juston'),
('Schmitt','Amya'),
('Lehner','Stanley'),
('Bergstrom','Justina'),
('Schiller','Cathrine'),
('Kuhlman','Green'),
('Wolff','Kade'),
('Roberts','Pablo'),
('Buckridge','Arianna'),
('Aufderhar','Cynthia'),
('Monahan','Deontae'),
('Rice','Javonte'),
('Cormier','Colton'),
('Kuhn','Alyce'),
('DAmore','Lisa'),
('Rempel','Celestino'),
('Russel','Addie'),
('Gleichner','Kevon'),
('Ryan','Jean'),
('OConnell','Trever'),
('Gleichner','Karen'),
('Marquardt','Irving'),
('Schulist','Bridgette'),
('Bernier','Vivianne'),
('Kertzmann','Buford'),
('Abshire','Alessandro'),
('Fahey','Walker'),
('Ziemann','Whitney'),
('Abbott','Joy'),
('Sauer','Hilton'),
('Shields','Aron'),
('Schaefer','Cyrus');
INSERT INTO Manufacturer (ManufacturerName)
VALUES ('BMW'),
('Ford'),
('Toyota'),
('Nissan'),
('Dodge'),
('Honda');
INSERT INTO Part (PartName, PartRetail)
VALUES ('Oil Filter','11.95'),
('Fuse','1.99'),
('Coolant - Quart','3.95'),
('Spark Plug','4'),
('Air Filter','24.95'),
('Carburetor','99.99'),
('AntiFreeze - Gallon','7.77'),
('Tire Valve','0.58'),
('Rain X - Application','4.95'),
('Oil - 10W40','4.95'),
('Oil - Synthetic','7.6');
INSERT INTO Model (ModelName, ManufacturerID)
VALUES ('3-Series','1'),
('5-Series','1'),
('F-150','2'),
('F-250','2'),
('F-350','2'),
('Camry','3'),
('Camry Hybrid','3'),
('Corolla','3'),
('Highlander','3'),
('Accord','6'),
('RAM','5'),
('Pathfinder','4'),
('Rogue','4');
INSERT INTO VehicleTrim (TrimName, ModelID)
VALUES ('318i 4dr Sedan','1'),
('328i 4dr Sedan','1'),
('318ti 2dr Hatchback','1'),
('323i 2dr Convertible','1'),
('328i 2dr Convertible','1'),
('323is 2dr Coupe','1'),
('328is 2dr Coupe','1'),
('M5 4dr Sedan','2'),
('M5 2dr Coupe','2'),
('M5 2dr Convertible','2'),
('2dr Extended Cab SB','3'),
('2dr Extended Cab LB','3'),
('2dr Extended Cab 4WD LB','3'),
('2dr Extended Cab 4WD SB','3'),
('XLT Lariat 2dr Extended Cab LB','3'),
('XLT Lariat 2dr Extended Cab SB','3'),
('XLT Lariat 2dr Extended Cab 4WD LB','3'),
('XLT Lariat 2dr Extended Cab 4WD SB','3'),
('XL 2dr Extended Cab LB','4'),
('XL 2dr Extended Cab SB','4'),
('XL 2dr Extended Cab 4WD LB','4'),
('XL 2dr Extended Cab 4WD SB','4'),
('2dr Regular Cab SB','5'),
('2dr Regular Cab LB','5'),
('2dr Regular Cab 4WD LB','5'),
('2dr Regular Cab 4WD SB','5'),
('LE V6 2dr Coupe','6'),
('DX 2dr Coupe','6'),
('LE 2dr Coupe','6'),
('4dr Sedan ','7'),
('LE Hybrid','7'),
('LE 4dr Sedan ','7'),
('DX 4dr Wagon','8'),
('LE V6 4dr Sedan','8'),
('LX 4dr','10'),
('Laramie Edition','11'),
('2dr Short Bed','11'),
('Eddie Bauer Edition','9'),
('Eddie Bauer Edition','12'),
('LX V6 4dr','13');
INSERT INTO Vehicle (VehVIN, VehYear, VehColor, VehMileage, TrimID)
VALUES ('1D4RD4GG9BC660306','18','Red','1234','2'),
('3GCCA05V89S596155','18','White','5678','4'),
('2CNBE1869T6300748','18','Blue','15456','8'),
('2FZACFDK36AW46451','18','Celestial Silver','25212','11'),
('2HGFF384744W44RF3','18','White',NULL,'14'),
('87JHF5RE3NBV678AA','19','Gray Metallic',NULL,'17'),
('4LKJ44829NB442DF3','19','Silver Metallic',NULL,'20'),
('5HHHF332AS3000FGB','19','Tan',NULL,'23'),
('6JDHGJ88KIGHJFDJC','19','Forrest Green',NULL,'26'),
('3JGFKDJDLS855NFCK','20','Blue',NULL,'27'),
('6YYDFJS739002NFH2','20','Red',NULL,'28'),
('6FHFK3748MJVND029','20','Black',NULL,'29'),
('11FJJFJSMHHFHF383','20','Brown',NULL,'30'),
('7FNFNW6223KFJHGHG','20','Blue Aqua',NULL,'31'),
('6NFJFJFWWNCFNEFH2','21','Pearl White',NULL,'32'),
('3638NNFNFLSS33041','21','Sandy Beach',NULL,'33'),
('13749NFHDL3733YYR','21','Sandy Beach',NULL,'34'),
('144FJFHFMZXZCCVMJ','22','Pearl White',NULL,'33'),
('5GHGJFKFQWWEEW32R','22','Barcelona Red',NULL,'34'),
('2WSSDFSOSJFGK393U','22','Blue Streak',NULL,'35'),
('3ERTY4839FNNBBVEF','22','Blue Streak',NULL,'36'),
('8DFSDFSDFSDFVML33','22','Aloe Green',NULL,'37'),
('6HM1111EFVL335332','22','Classic Silver',NULL,'38'),
('4DFHDFKDFDKFJASS3','22','Barcelona Red',NULL,'39'),
('74MNMF90ERTUFF91R','22','Silver Metallic',NULL,'40'),
('1123FGDSJH7654GFV','21','White','47547','30'),
('7FNFN14223KFJHGHG','21','Blue','42333','31'),
('5NFJFJFWWNXXNEFH2','22','White','58595','32'),
('234HGDCBV76400987','20','Tan','48475','33'),
('55749NFHDL3733YYR','18','Sandy Beach','25564','34'),
('444FJFHFMZXZCCVMJ','18','Red','100222','33'),
('5DDDFKFQWWEEW32P','18','Blue','89383','34'),
('2WWWSSDFSJFGK393U','18','Blue Streak','96956','2');
INSERT INTO Inventory (INVWholesale, INVRetail, VehID)
VALUES ('23500','26995.00','1'),
('34555','39995.00','2'),
('28000','32000.00','3'),
('28000','32000.00','4'),
('45250','51995.00','5'),
('44100','50555.00','6'),
('30000','35000.00','7'),
('49000','55555.00','8'),
('35000','39995.00','9'),
('32123','36250.00','10'),
('33000','37750.00','11'),
('29999','34555.00','12'),
('35000','38964.00','13'),
('50000','55250.00','14'),
('48000','53654.00','15'),
('48000','53654.00','16'),
('29650','33000.00','17'),
('47000','51000.00','18'),
('36985','40050.00','19'),
('30000','34000.00','20'),
('41000','41450.00','21'),
('51000','56000.00','22'),
('46520','51250.00','23'),
('55000','59995.00','24'),
('54000','58888.00','25');
INSERT INTO Invoice (InvoiceDate, InvoiceAmount, InventoryID, CustomerID,
EmployeeID)
VALUES ('2022-3-1','34887','2','91','7'),
('2022-3-2','27600','4','112','7'),
('2022-3-3','35000','9','133','7'),
('2022-3-4','32750','10','149','6'),
('2022-3-5','31014','17','169','5'),
('2022-4-1','31887','12','111','7'),
('2022-4-2','49600','14','119','5'),
('2022-4-3','49000','8','33','6'),
('2022-4-4','24750','1','10','5'),
('2022-4-5','30014','7','55','6');
INSERT INTO PayHistory (PHBeginDate, PHEndDate, PHRate, PHPayType, PHCommission,
EmployeeID, PositionID, DealershipID)
VALUES ('2022-03-01',NULL,'44','H',NULL,'1','2','7111'),
('2022-03-01',NULL,'45','H',NULL,'2','2','7111'),
('2022-03-01',NULL,'39','H',NULL,'3','2','5626'),
('2022-03-01',NULL,'39','H',NULL,'4','2','7111'),
('2022-03-01',NULL,'25','C','5','5','1','7111'),
('2022-03-01',NULL,'26.5','C','5','6','1','5626'),
('2022-02-01','2022-01-31','26','C','4.25','7','1','5626'),
('2022-03-01',NULL,'26.5','C','5','7','1','5626'),
('2022-03-01',NULL,'55000','S',NULL,'8','3','7111'),
('2022-03-01',NULL,'55000','S',NULL,'9','3','5626'),
('2022-02-01','2022-12-31','60000','S',NULL,'10','3','7111');
INSERT INTO ServiceTicket (VehID, CustID, STTimeIn, STTimeOut, STComments)
VALUES ('26','156','2022-03-01 07:30:00','2022-03-01 09:30:00',NULL),
('27','62','2022-03-01 08:30:00','2022-03-01 14:30:00',NULL),
('28','11','2022-03-03 09:30:00','2022-03-03 12:00:00',NULL),
('29','77','2022-03-03 13:30:00','2022-03-03 15:30:00',NULL),
('30','104','2022-03-02 09:30:00','2022-03-02 15:00:00',NULL),
('31','100','2022-03-04 08:30:00','2022-03-04 11:30:00',NULL),
('32','36','2022-03-03 11:30:00','2022-03-03 14:30:00',NULL),
('33','4','2022-03-08 13:30:00','2022-03-08 16:00:00',NULL),
('24','88','2022-03-19 08:30:00','2022-03-19 10:30:00',NULL),
('25','99','2022-03-10 09:30:00','2022-03-10 10:00:00',NULL);
INSERT INTO ServiceTicketDetails (STDQty, STDComments, STDWarrantyItem, STID,
EmployeeID, ServiceID)
VALUES ('1','10W40 Synthetic','0','10001','1','1'),
('1',NULL,'0','10001','1','6'),
('.25','Battery Cap Replace','1','10001','2','5'),
('1.25','Wheel Alignment','0','10002','6','5'),
('1','Passed','0','10002','1','3'),
('1','Passed','0','10002','2','4'),
('2','Recall Fixes','1','10003','2','5'),
('3','Recall Fixes','1','10004','2','5'),
('0.5','Changed Spark Plugs','0','10004','2','5'),
('1',NULL,'0','10004','1','7'),
('2.75','Carburetor Fix','0','10005','3','5'),
('1','10W40','0','10006','1','1'),
('1',NULL,'0','10006','2','7'),
('1',NULL,'0','10006','2','6'),
('1','Radiator Flush','0','10007','1','5'),
('0.25','Battery Check','1','10007','2','5'),
('1.75','Tire Balance','0','10008','3','5'),
('2','Recall Fixes','1','10009','3','5'),
('1','Passed','0','10010','1','3'),
('1','Failed','0','10010','1','4');
INSERT INTO PartsUsed (PUQty, PartID, STDID)
VALUES (1,5001,1),
(11,5001,5),
(8,5007,4),
(7,5004,2),
(4,5008,4),
(2,5008,3),
(3,5008,1);

SELECT * FROM Manufacturer, Model, VehicleTrim, Inventory, Vehicle, Customer, Employee, Invoice, 
ServiceTicket, Service, Dealership, PayHistory, ServiceTicketDetails, Part, PositionTitle, PartsUsed;

#1A I'm inserting myself as a new employee
INSERT INTO Employee(EmpFirst, EmpLast, EmpAddress, EmpCity, EmpState, EmpZip,
EmpPhone, EmpDOB)
VALUES 
('Will', 'Gunther', '101n 101e', 'North Ogden', 'UT', 84404, 4351111111, '2002-10-10');
INSERT INTO PayHistory (PHBeginDate, PHEndDate, PHRate, PHPayType, PHCommission,
EmployeeID, PositionID, DealershipID)
VALUES
('2022-03-01',NULL,'44','H',NULL, LAST_INSERT_ID(),'3','1236');

#1B  SELECT from Employee Pay History
SELECT * 
FROM PayHistory
WHERE 
	EmployeeID = 11;

#2A Remove Customers without Invoice or ServiceTicket

  
DELETE FROM Customer
WHERE CustomerID IN (
    SELECT CustomerID FROM (
        SELECT Customer.CustomerID
        FROM Customer
        LEFT JOIN Invoice ON Customer.CustomerID = Invoice.CustomerID
        LEFT JOIN ServiceTicket ON Customer.CustomerID = ServiceTicket.CustID
        WHERE Invoice.CustomerID IS NULL
          AND ServiceTicket.CustID IS NULL
    ) AS temp
);




#2B Results of the remaining customers
SELECT * FROM Customer;

#3A Decrease Service rate of unused services
UPDATE ServiceTicketDetails
RIGHT JOIN Service 
ON  ServiceTicketDetails.ServiceID = Service.ServiceID
SET
	ServiceRate = FLOOR(ServiceRate*.9)
WHERE
	ServiceTicketDetails.ServiceID IS NULL;

#3B Retrieve Data from Service Table
SELECT * FROM Service;

#4A Clear out '22 Vehicles
UPDATE Inventory
	LEFT JOIN Vehicle
	ON Inventory.VehID = Vehicle.VehID
SET
	InvRetail = ROUND(InvRetail * 0.9605, 2)
WHERE 
	VehYear = 22
    AND VehMileage IS NULL;

#4B Display all new 2022 Vehicles for sale
SELECT VehYear, VehColor, ManufacturerName, ModelName, TrimName, InvRetail FROM Inventory
	LEFT JOIN Vehicle
	ON Inventory.VehID = Vehicle.VehID
	LEFT JOIN VehicleTrim
	ON Vehicle.TrimID = VehicleTrim.TrimID
    LEFT JOIN Model
    ON VehicleTrim.ModelID = Model.ModelID
    LEFT JOIN Manufacturer
    ON Model.ManufacturerID = Manufacturer.ManufacturerID
WHERE 
	VehYear = 22
    AND VehMileage IS NULL;
    
SET SQL_SAFE_UPDATES = 1;