
CREATE TABLE Jomato (
    OrderId INT PRIMARY KEY,
    RestaurantName NVARCHAR(500),
    RestaurantType NVARCHAR(200),
    Rating DECIMAL(3,1),
    No_of_Rating INT,
    AverageCost DECIMAL(10,2),
    OnlineOrder NVARCHAR(10),
    TableBooking NVARCHAR(10),
    CuisinesType NVARCHAR(1000),
    Area NVARCHAR(255),
    LocalAddress NVARCHAR(255),
    DeliveryTime INT
);
select * from Jomato

BULK INSERT Jomato
FROM 'C:\Jomato.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  -- UTF-8 support
);

--Tasks to be performed:
--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.
CREATE FUNCTION dbo.fn_InsertChicken (@input NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    IF @input = 'Quick Bites'
        RETURN STUFF(@input, 7, 0, 'Chicken ')
    RETURN @input
END

SELECT RestaurantName,RestaurantType,dbo.fn_InsertChicken(RestaurantType) AS ModifiedType FROM Jomato;

--2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.
SELECT RestaurantName, CuisinesType, dbo.fn_InsertChicken(RestaurantType) AS ModifiedType
FROM Jomato
WHERE [No_of_Rating] = (SELECT MAX([No_of_Rating]) FROM Jomato
);

--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
--start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
--and below 3.5 and ‘Bad’ if it is below 3 star rating.

SELECT *,
    CASE
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 AND Rating <= 4 THEN 'Good'
        WHEN Rating > 3 AND Rating <= 3.5 THEN 'Average'
		ELSE 'Bad'
		END AS RatingStatus
FROM Jomato;



--4. Find the Ceil, floor and absolute values of the rating column and display the current date
--and separately display the year, month_name and day.
SELECT 
    RestaurantName,
    Rating,
    CEILING(Rating) AS CeilRating,
    FLOOR(Rating) AS FloorRating,
    ABS(Rating) AS AbsRating,
    GETDATE() AS CurrentDate,
    YEAR(GETDATE()) AS Year,
    DATENAME(MONTH, GETDATE()) AS MonthName,
    DAY(GETDATE()) AS Day
FROM Jomato;


--5. Display the restaurant type and total average cost using rollup.
SELECT RestaurantType, SUM(AverageCost) AS TotalAverageCost FROM Jomato
GROUP BY ROLLUP(RestaurantType);