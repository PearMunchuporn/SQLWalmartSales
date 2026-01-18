
---Sales each day.

SELECT Date ,sub.Total_Sales
FROM
(
SELECT Date,  
       ROUND(SUM(Total),2) AS Total_Sales
  FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Date
) sub

ORDER BY Date


--Total sales by city.
SELECT 
 City, ROUND(SUM (Total),2) as Total_Sales
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY City


---Sales by payment type.
SELECT 
 Payment, ROUND(SUM (Total),2) AS Total_Sales
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Payment
 ORDER BY Total_Sales


--Max sales product line.
 SELECT
 Product_Line
,ROUND(MAX(Total),2) AS Max_Sale

 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Product_Line
 ORDER BY Max_Sale DESC

--Min sales product line.
 SELECT 
 Product_Line
,ROUND(MIN(Total),2) AS Min_Sale

 FROM [Walmart].[dbo].[WalmartSalesData]

 GROUP BY Product_Line
 ORDER BY Min_Sale

--Avg sales by product line.
 SELECT 
 Product_line
,ROUND(AVG(Total),2) AS Avg_Sale
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Product_line
 ORDER BY Avg_Sale DESC

--Avg sales city
 SELECT
 City
,ROUND(AVG(Total),2) AS Avg_sale
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY City
 ORDER BY Avg_sale DESC

----Avg sales cutomer type.
 SELECT 
Customer_Type
,ROUND(AVG(Total),2) AS Avg_Sale
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Customer_type
 ORDER BY Avg_Sale DESC

--The date got max sales.
 SELECT 
 Date,
 FORMAT(CAST(Date AS DATE), 'ddd') as Day_Name,
 ROUND(Total,2) as Max_Sale

 FROM [Walmart].[dbo].[WalmartSalesData]
 WHERE Total = (SELECT MAX(Total)  FROM [Walmart].[dbo].[WalmartSalesData])


 --The date min sales.
 SELECT 
 Date,
 FORMAT(CAST(Date AS DATE), 'ddd') as Day_Name,
 ROUND(Total,2) as Min_Sale
  
 FROM [Walmart].[dbo].[WalmartSalesData]
 WHERE Total = (SELECT MIN(Total)  FROM [Walmart].[dbo].[WalmartSalesData])
