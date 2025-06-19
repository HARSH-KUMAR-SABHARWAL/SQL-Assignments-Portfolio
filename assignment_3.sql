
select * from Jomato

--1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
CREATE PROCEDURE dbo.usp_GetRestaurantsWithTableBooking
AS
BEGIN
    SELECT 
        RestaurantName,
        RestaurantType,
        CuisinesType
    FROM Jomato
    WHERE TableBooking = 'Yes'
END;

EXEC dbo.usp_GetRestaurantsWithTableBooking;

--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.

BEGIN TRANSACTION;

UPDATE Jomato
SET RestaurantType = 'Cafeteria'
WHERE RestaurantType = 'Cafe';

SELECT * FROM Jomato WHERE RestaurantType = 'Cafeteria';     -- Check the change

ROLLBACK;                -- Rollback change


--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.
SELECT TOP 5 *
FROM (
    SELECT Area, AVG(Rating) AS AvgRating, ROW_NUMBER() OVER (ORDER BY AVG(Rating) DESC) AS RowNum
    FROM Jomato
    GROUP BY Area
) AS RankedAreas;

--4. Use the while loop to display the 1 to 50.

DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;

--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
CREATE VIEW TopRatedRestaurants AS
SELECT TOP 5 
    RestaurantName, Rating, Area
FROM Jomato
ORDER BY Rating DESC;

SELECT * FROM TopRatedRestaurants;      --To view the query

--6. Create a trigger that give an message whenever a new record is inserted.
CREATE TRIGGER trg_AfterInsert_Jomato
ON Jomato
AFTER INSERT
AS
BEGIN
    PRINT '✅ A new restaurant record has been inserted into Jomato!';
END;

--for the check
INSERT INTO Jomato (OrderId, RestaurantName, RestaurantType, Rating, No_of_Rating, AverageCost, OnlineOrder, TableBooking, CuisinesType, Area, LocalAddress, DeliveryTime)
VALUES (9999, 'Test Café', 'Quick Bites', 4.5, 150, 300.00, 'Yes', 'Yes', 'Café, Fast Food', 'Delhi', 'Test Street', 30);

