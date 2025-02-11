--Find Percentage of Customer Type.
SELECT TOP (1000)
   Gender
  ,Customer_Type
  ,COUNT(Gender) as Customer_Number
  ,100*COUNT(Gender) / (SELECT COUNT(*) FROM [Walmart].[dbo].[WalmartSalesData]) AS Percentage
    
  FROM [Walmart].[dbo].[WalmartSalesData]
GROUP BY Gender, Customer_Type
  
--Payment type by customer.
  SELECT TOP (1000)
  Payment
  ,COUNT(*) AS Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Payment
  ORDER BY Customer_Number

--Percentage Male and Female.
SELECT TOP (1000)
  Gender
 ,COUNT(Gender) as Total_Gender
 ,100*	COUNT(Gender) / (SELECT COUNT(*) FROM [Walmart].[dbo].[WalmartSalesData]) AS Percentage
  FROM [Walmart].[dbo].[WalmartSalesData]
GROUP BY Gender

--Number customer by gender each of product line.
SELECT TOP (1000)
  Product_Line
 ,Gender
 ,COUNT(*) as Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY  Product_line ,Gender
ORDER BY Product_line

--Number of customer of each city.
  SELECT TOP (1000)
  City
  ,COUNT(*) as Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY  City
  ORDER BY Customer_Number

 ----Number of customer per day.
SELECT Date ,sub.Customer_Number
FROM
(
SELECT Date,  
       COUNT(*) as Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Date
) sub
ORDER BY Date
 
--Number of customer each time of the day.
SELECT Timing,  COUNT(*) as Customer_Number FROM (
  SELECT TOP (1000)
  TIME,
  CASE
   WHEN Time BETWEEN '00:00:00' AND '05:59:59' THEN 'Over Midnight Time'
   WHEN Time BETWEEN '06:00:00' AND '12:59:59' THEN 'Morning Time'
   WHEN Time BETWEEN '13:00:00' AND '16:59:59' THEN 'Afternoon Time'
   WHEN Time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening Time'
  ELSE 'Night Time'
  END Timing
FROM [Walmart].[dbo].[WalmartSalesData])sub
GROUP BY Timing
ORDER BY Customer_Number

  --Number of customer each day of week.
SELECT Day_Name,  COUNT(*) Customer_Number
FROM (
SELECT 
       FORMAT(CAST(Date as date), 'ddd') as Day_Name  
  FROM [Walmart].[dbo].[WalmartSalesData]

) sub
GROUP BY Day_Name
ORDER BY Customer_Number DESC
