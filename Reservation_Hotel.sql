CREATE DATABASE Hotel_Reservation;


CREATE TABLE Reservation_Details(
	Booking_ID varchar(50) NOT NULL Primary Key,
	No_of_Adults int NULL,
	No_of_Children int NULL,
	No_of_Weekend_Nights int NULL,
	No_of_Week_Nights int NULL,
	Type_of_Meal_Plan varchar(50) NULL,
	Room_Type_Reserved varchar(50) NULL,
	Lead_Time int NULL,
	Arrival_Date date NULL,
	Market_Segment_Type varchar(50) NULL,
	Avg_Price_Per_Room decimal(18, 2) NULL,
	Booking_Status varchar(50) NULL,
)


----1. What is the total number of reservations in the dataset?
Select COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details

----2. Which meal plan is the most popular among guests?
Select Top(1) Type_of_Meal_Plan ,COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details
Group by Type_of_Meal_Plan
Order By COUNT(Booking_ID) desc

----3. What is the average price per room for reservations involving children?
Select Booking_ID, Avg_Price_Per_Room,No_of_Children
from Reservation_Details
Where No_of_Children > 0

----4. How many reservations were made for the year 20XX (replace XX with the desired year)?
Select COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details
Where YEAR(Arrival_Date)=2017

----5. What is the most commonly booked room type?
Select Top(1) Room_Type_Reserved ,COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details
Group by Room_Type_Reserved
Order By COUNT(Booking_ID) desc

----6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
Select COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details
Where No_of_Weekend_Nights>0 

----7. What is the highest and lowest lead time for reservations?
Select MAX(Lead_Time) AS 'Highest Lead Time',MIN(Lead_Time) AS 'Lowest Lead Time'
from Reservation_Details

----8. What is the most common market segment type for reservations?
Select Top(1) Market_Segment_Type,COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details
Group by Market_Segment_Type
Order By COUNT(Booking_ID) Desc

----9. How many reservations have a booking status of "Confirmed"?
Select Booking_Status,COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details
Where Booking_Status='Confirmed'
Group by Booking_Status

----10. What is the total number of adults and children across all reservations?
Select SUM(No_of_Adults) as 'Number of Adult' ,SUM(No_of_Children) as 'Number of Children'
from Reservation_Details

----11. What is the average number of weekend nights for reservations involving children?
Select AVG(No_of_Weekend_Nights) as 'AVG of Weekend Nights Have Children'
from Reservation_Details
Where No_of_Children>0

----12. How many reservations were made in each month of the year?
Select MONTH(Arrival_Date) 'Month of Reservations',Year(Arrival_Date) 'Year of Reservations',
	COUNT(Booking_ID) as 'Number of Reservations'
from Reservation_Details
Group by MONTH(Arrival_Date),Year(Arrival_Date)
Order By Year(Arrival_Date),MONTH(Arrival_Date) ASC

----13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?
Select Room_Type_Reserved,AVG(No_of_Weekend_Nights) as 'AVG of Weekend Nights',
	AVG(No_of_Week_Nights) as 'AVG of Week Nights'
from Reservation_Details
group by Room_Type_Reserved

----14. For reservations involving children, what is the most common room type, and what is the average price for that room type?
SELECT 
    Room_Type_Reserved AS Room_Type,
    AVG(Avg_Price_Per_Room) AS 'Avg Price Per Room'
FROM 
    Reservation_Details
WHERE  
    Room_Type_Reserved = (
        SELECT TOP 1 Room_Type_Reserved
        FROM Reservation_Details
        WHERE No_of_Children > 0
        GROUP BY Room_Type_Reserved
        ORDER BY COUNT(Room_Type_Reserved) DESC
    )
GROUP BY 
    Room_Type_Reserved

---15. Find the market segment type that generates the highest average price per room.
Select Top(1) Market_Segment_Type,AVG(Avg_Price_Per_Room) AS 'Avg Price Per Room'
from Reservation_Details
Group by Market_Segment_Type
Order BY AVG(Avg_Price_Per_Room) Desc



