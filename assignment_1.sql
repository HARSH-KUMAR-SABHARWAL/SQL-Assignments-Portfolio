create table Salesman( Salesmanid int, Name varchar(255), Commission decimal(10,2), City varchar(255), Age int);
select * from Salesman

insert into Salesman(Salesmanid, Name, Commission, City, Age)
values(101, 'Joe', 50, 'California', 17),
(102, 'Simon', 75, 'Texas', 25),
(103, 'Jessie', 105, 'Florida', 35),
(104, 'Danny', 100, 'Texas', 22),
(105, 'Lia', 65, 'New Jersey', 30);

CREATE TABLE Customer (
SalesmanId INT,
CustomerId INT,
CustomerName VARCHAR(255),
PurchaseAmount INT,
);

select * from Customer

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
(101, 2345, 'Andrew', 550),
(103, 1575, 'Lucky', 4500),
(104, 2345, 'Andrew', 4000),
(107, 3747, 'Remona', 2700),
(110, 4004, 'Julia', 4545);

CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount
money)select * from OrdersINSERT INTO Orders Values
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

select * from Salesmanselect * from Customerselect * from Orders--1. Insert a new record in your Orders table.INSERT INTO Orders VALUES(5005,3211,106,'2021-01-01',2000)--2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
--constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
--column in Customer table. Add not null constraint in Customer_name column for the
--Customer table.
SP_HELP SALESMAN

SP_HELP CUSTOMER

ALTER TABLE Salesman
ALTER COLUMN Salesmanid INT NOT NULL;

 ALTER TABLE SALESMAN ADD CONSTRAINT PK_SALESMAN PRIMARY KEY (SALESMANID);

 ALTER TABLE Salesman
ADD CONSTRAINT DF_Salesman_City DEFAULT 'NEW YORK' FOR City;

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Salesman
FOREIGN KEY (SalesmanId) REFERENCES Salesman(Salesmanid);

-- Add missing salesmen values otherwise foreign key constraint not work
INSERT INTO Salesman (Salesmanid, Name, Commission, City, Age)
VALUES
(107, 'Remona_Sales', 70, 'Chicago', 29),
(110, 'Julia_Sales', 85, 'Boston', 33);

ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

--3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase
--amount value greater than 500.

SELECT * FROM Customer
WHERE CustomerName LIKE '%N' AND PurchaseAmount > 500;

--4. Using SET operators, retrieve the first result with unique SalesmanId values from two
--tables, and the other result containing SalesmanId with duplicates from two tables.

SELECT Salesmanid FROM Salesman
UNION
SELECT SalesmanId FROM Customer;

SELECT Salesmanid FROM Salesman
INTERSECT
SELECT SalesmanId FROM Customer;


--5. Display the below columns which has the matching data.
--Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 500 to 1500.

SELECT O.OrderDate, S.Name AS SalesmanName,C.CustomerName,S.Commission,S.City
FROM Orders O
JOIN Salesman S ON O.SalesmanId = S.Salesmanid
JOIN Customer C ON O.CustomerId = C.CustomerId AND O.SalesmanId = C.SalesmanId
WHERE C.PurchaseAmount BETWEEN 500 AND 1500;

--6. Using right join fetch all the results from Salesman and Orders table.
SELECT S.Salesmanid,S.Name AS SalesmanName,S.Commission,S.City,S.Age,O.OrderId,O.CustomerId,O.OrderDate,O.Amount
FROM Salesman S
RIGHT JOIN Orders O ON S.Salesmanid = O.SalesmanId;
