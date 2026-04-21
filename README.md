# Ride-Hailing-Operations-Revenue-Analytics-OLA-

📌 Project Overview

This project focuses on analyzing a ride-booking dataset to uncover key business insights related to ride completion, cancellations, revenue loss, and customer behavior. The analysis was performed entirely using SQL, simulating a real-world data analyst workflow.

The objective of this project is to identify operational inefficiencies and provide data-driven insights that can help improve ride success rates and reduce revenue leakage



🎯 Business Objectives
1. Analyze ride completion vs cancellation trends
2. Identify major causes of ride cancellations
3. Calculate revenue loss due to unsuccessful bookings
4. Discover high-demand locations and peak time slots
5. Evaluate performance across different vehicle types


🗂️ Dataset Description

The dataset contains ride-booking records with the following key fields:

1.Booking ID
2.Customer ID
3.Booking Status (Completed / Cancelled)
4.Booking Value (Revenue)
5.Pickup Location
6.Vehicle Type
7.Payment Method
8.Booking Time
9.Ratings (Customer & Driver)
10.Time
11.Drop Location 
12.V_TAT
13.C_TAT
14.Canceled_Rides_by_Customer
15.Canceled_Rides_by_Driver
16.Incomplete_Rides
17.Incomplete_Rides_Reason
18.Ride_Distance

🧹 Data Cleaning & Preparation

Before analysis, the dataset was cleaned and transformed using SQL:

1.Handled missing/null values in critical columns
2.Standardized inconsistent data formats (e.g., time formatting)
3.Removed duplicate records
4.Segregated data into:
     .Rides_done → Successfully completed rides
     .Rides_not_done → Cancelled or incomplete rides

This ensured accurate and reliable analysis.

📊 Key Analysis Performed

1.Calculated ride completion rate
2.Analyzed Driver vs Customer cancellations
3.Estimated revenue loss due to cancellations (~38%)
4.Identified most frequently used payment methods  

💡 Key Insights

📉 Approximately 38% of potential revenue is lost due to ride cancellations, indicating significant business leakage
🚗 Certain vehicle types show higher completion rates and better revenue contribution
⏰ Ride demand peaks during specific hours, highlighting opportunities for resource optimization
🔄 Driver and customer cancellation patterns differ, indicating distinct behavioral trends

📊 KPIs Tracked
1.Ride Completion Rate
2.Cancellation Rate (%)
3.Revenue Loss (%)
4.Top Cancellation Locations
5.Vehicle-wise Performance
6.Demand Trends (Time-based)

🛠️ Tools & Technologies Used

1.SQL Server
2.T-SQL (Joins, Aggregations, CASE Statements, CTEs)
3.Data Cleaning & Transformation Techniques

📬 Conclusion

This project highlights how SQL can be effectively used to analyze operational data, identify inefficiencies, and support strategic decision-making in a ride-booking business.
