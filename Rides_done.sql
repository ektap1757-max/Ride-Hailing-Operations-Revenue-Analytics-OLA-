  use ola
  go


select * from ola_bookings


-- we will check if is there any duplicate data exist in our database.

select booking_id, count(*) as total_count
from ola_bookings
group by booking_id
having count(*) >1

--The dataset will be cleaned by checking for the presence of missing (NULL) values 
--and determining appropriate methods to handle them.

select * from ola_bookings
where Time is null or
Booking_ID is null or
Booking_Status is null or
Customer_ID is null or
Vehicle_Type is null or
Pickup_Location is null or
Drop_Location is null or
V_TAT is null or
C_TAT is null or
Canceled_Rides_by_Customer  is  null  or
Canceled_Rides_by_Driver is null or
Incomplete_Rides is null or
Incomplete_Rides_Reason is null or
Booking_Value is null or
Payment_Method is null or
Ride_Distance is null or
Driver_Ratings is null or
Customer_Rating is null 


select * from ola_bookings
where booking_status <>'success'

update ola_bookings set V_TAT= 0
where V_TAT is null

update ola_bookings set C_TAT= 0
where C_TAT is null

update ola_bookings set Canceled_Rides_by_customer = '-'
where Canceled_Rides_by_customer = 'null'


update ola_bookings set Incomplete_Rides = 'null'
where Incomplete_Rides = 1

update ola_bookings set Incomplete_Rides_Reason = 'Booking_cancelled'
where Incomplete_Rides_Reason  = 'null'


update ola_bookings set Payment_Method = '-'
where Payment_Method  = 'null'

update ola_bookings set customer_Rating = 0
where Customer_Rating  is null

update ola_bookings set driver_Ratings = 0
where driver_Ratings  is null

update ola_bookings set customer_rating =
format(customer_rating,'N0')

update ola_bookings set Driver_ratings =
format(Driver_ratings,'N0')

---------------------------------------------------------------------------------------------------


--We will extract successful ride data from the bookings
--table and store it in a separate table,
--and get some meaningful insights from it.


select * into Bookings_done
from ola_bookings
where booking_status = 'Success'

select * from Bookings_done

---------------------------------------------------------------------------------------------------

--1. What is the total number of completed rides?


select * from Bookings_done

select count(*) as total_Rides_done
from Bookings_done

---------------------------------------------------------------------------------------------------

--2. What is the total revenue from completed rides?

select * from Bookings_done

select sum(booking_value) as total_revenue
from Bookings_done

---------------------------------------------------------------------------------------------------


--3. What is the ride completion rate?


select * from Ola_Bookings

select format(count(
case when booking_status ='success' then 1
end)* 100.0/ count(*),'N2') + ' %' as completion_rate_percentage 
from Ola_Bookings

--------------------------------------------------------------------------------------------------

--4. At what time are most rides successfully completed?

select * from Bookings_done

select case
when datepart(hour,time) between 0 and 4 then 'Night'
when datepart(hour,time) between 5 and 11 then 'Morning'
when datepart(hour,time) between 12 and 17 then 'Afternoon'
when datepart(hour,time) between 18 and 23 then 'Evening'
end as Timming,
count(*) as total_bookings
from Bookings_done
group by case
when datepart(hour,time) between 0 and 4 then 'Night'
when datepart(hour,time) between 5 and 11 then 'Morning'
when datepart(hour,time) between 12 and 17 then 'Afternoon'
when datepart(hour,time) between 18 and 23 then 'Evening'
end
order by total_bookings desc


---------------------------------------------------------------------------------------------------

--5. Which day has the highest number of completed rides?

select * from Bookings_done

select top 1 datename(weekday,date) as Day_name,
count(*) as Completed_rides
from Bookings_done
group by datename(weekday,date)
order by Completed_rides desc

---------------------------------------------------------------------------------------------------

--6. Which vehicle type generates the most revenue from completed rides?

select * from Bookings_done

select vehicle_type,
sum(booking_value)  as revenue
from Bookings_done
group by vehicle_type
order by revenue desc

---------------------------------------------------------------------------------------------------

--7. Which vehicle type has the highest completion rate?

select * from ola_Bookings

select vehicle_type,
format(count
(case when booking_status ='success' then 1
end)*100.0/count(*),'N2')+ ' %' as completion_rate
from ola_Bookings
group by vehicle_type
order by completion_rate desc

---------------------------------------------------------------------------------------------------

--8. What is the average distance of completed rides?

select * from Bookings_done

select avg(ride_distance) as avg_distance
from Bookings_done

---------------------------------------------------------------------------------------------------

--9. Which payment method is most used in completed rides?

select * from Bookings_done

select top 1 payment_method,
count(*) as total_rides
from Bookings_done
group by payment_method
order by total_rides desc

---------------------------------------------------------------------------------------------------

--10. How do completed rides compare with cancelled rides by vehicle type?

select * from Ola_Bookings

select vehicle_type,
count(
case when 
booking_status <> 'success' then 1
end ) as cancelled_rides,
count(
case when
booking_status ='success' then 1 
end ) as completed_rides
from Ola_Bookings
group by vehicle_type
order by vehicle_type

---------------------------------------------------------------------------------------------------

--11. top 5 locations have the highest ride demand?	

select * from Ola_Bookings

select top 5 pickup_location,
count(*) as total_num
from Ola_Bookings
group by pickup_location
order by total_num desc


---------------------------------------------------------------------------------------------------

--12. Which are the top 5 locations with the highest number of cancellations?

select * from Ola_Bookings

select top 5 pickup_location,
count(*) as total_cancellations
from Ola_Bookings
where booking_status <> 'Success'
group by pickup_location
order by total_cancellations desc

---------------------------------------------------------------------------------------------------

--13. Find the Maxium and Minimum driver ratings for prime bookings?

select * from Bookings_done

select vehicle_type,max(driver_ratings) as max_rating,min(driver_ratings) as min_rating
from Bookings_done
where vehicle_type like '%prime%'
group by vehicle_type







