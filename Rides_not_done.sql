use ola
go

select * from ola_bookings


-- we will check if is there any duplicate data exist in our database.


select booking_id, count(*) as total_count
from ola_bookings
group by booking_id
having count(*) >1


---------------------------------------------------------------------------------------------------


--creating a copy of the original data
select * into bookings
from  ola_bookings

---------------------------------------------------------------------------------------------------


--We will work on creating a copy of the existing data and modifying it within a new table named bookings, 
--while ensuring that the original table remains unchanged and intact.

Select * from bookings

---------------------------------------------------------------------------------------------------

--1. How many rides were not completed?


select * from bookings 
where booking_status <> 'success'


---------------------------------------------------------------------------------------------------

--*: We are creating a new table from the existing bookings table 
--   that contains only cancelled ride records,
--   that were not completed along with their respective reasons.

select * into bookings_not_done
from bookings
where booking_status <> 'success'


---------------------------------------------------------------------------------------------------

--*: Now we’ll analyze the bookings_not_done data table 
--   and get some meaningful insights from it.

--1. What is the total number of rides?

select * from bookings_not_done

select count(*) as total_count from bookings_not_done


---------------------------------------------------------------------------------------------------


--2. What % of rides are not completed?

select * from bookings

select 
format
(count(case when
booking_status <> 'success' then 1 
end ) * 100.0 / count(*),'N2')+ '%' as  not_completed_percentage
from bookings


---------------------------------------------------------------------------------------------------


--3. How many bookings fall under each booking status category?

select * from bookings

select booking_status,
count(*) as total_number
from bookings
group by booking_status


---------------------------------------------------------------------------------------------------

--4.What are the top reasons for ride cancellation?

select * from bookings_not_done

select Canceled_Rides_by_Customer,
Canceled_Rides_by_Driver,booking_status,
count(*) as total_cancelled
from bookings_not_done
group by Canceled_Rides_by_Customer,
Canceled_Rides_by_Driver,booking_status
order by total_cancelled desc


---------------------------------------------------------------------------------------------------

--5. At what hour do most cancellations happen?

select * from bookings_not_done

select 
case when 
	datepart(hour,time) between 0 and 4 then 'Night' 
	when datepart(hour,time) between 5 and 11 then 'Morning'
	when datepart(hour, time) between 12 and 17 then 'Afternoon'
	when datepart(hour,time) between 18 and 23 then 'Evening'
	end as time,
	count(*) as total_cancelled_bookings
	from bookings_not_done
	group by case when 
	datepart(hour,time) between 0 and 4 then 'Night' 
	when datepart(hour,time) between 5 and 11 then 'Morning'
	when datepart(hour, time) between 12 and 17 then 'Afternoon'
	when datepart(hour,time) between 18 and 23 then 'Evening'
	end 
	order by total_cancelled_bookings desc

--note: we are not mentioning booking_status like '%cancelled%' due to we have another option in table 
--(Driver Not Found).


---------------------------------------------------------------------------------------------------

--6. Evaluation of cancellation patterns between drivers and customers

select * from bookings_not_done

select 
'customer' as cancelled_by,
count(*) as Total_cancellations
from bookings_not_done
where Canceled_Rides_by_Customer <> '-'

union all

select 
'driver' as cancelled_by,
count(*) as Total_cancellations
from bookings_not_done
where Canceled_Rides_by_driver <> '-'
order by Total_cancellations desc


---------------------------------------------------------------------------------------------------

--7. Identify the top 5 vehicle types with the highest number of incomplete bookings.

select * from bookings_not_done

select  top 5 Vehicle_Type,
count(*) as total
from bookings_not_done
group by Vehicle_Type
order by total desc


---------------------------------------------------------------------------------------------------

--8. How much revenue is lost due to cancellations?

select * from bookings_not_done


select sum(booking_value) as revenue_lost
from bookings_not_done
where booking_status<>'success'


--9. HWhat percentage of total revenue is lost due to ride cancellations?

select format(sum(
case when booking_status <>'success' then booking_value
else 0
end )* 100.0/ sum(booking_value), 'N2') + ' %' as revenue_loss_percentage
from bookings










