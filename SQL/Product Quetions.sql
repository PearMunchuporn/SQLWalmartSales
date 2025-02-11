
--Find the total cogs.

SELECT TOP (1000) 
	Product_line,
    ROUND(SUM(Cogs),2) AS Total_Cogs,
    ROUND(SUM(Total),2) AS Total_Sales

  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Total_Cogs DESC


--Max Cogs of each product line.
SELECT TOP (1000) 
     Product_Line,
     ROUND(MAX(Cogs),2) AS Max_Cogs
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Max_Cogs DESC

--Min Cogs of each product line.
SELECT TOP (1000) 
     Product_Line,
     ROUND(MIN(Cogs),2) AS Min_Cogs
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Min_Cogs DESC


-----Max cogs of product line.
SELECT TOP (1000) 
     Product_Line,
     ROUND((Cogs),2) as Max_Cogs

  FROM [Walmart].[dbo].[WalmartSalesData]
  WHERE Cogs = (SELECT MAX(Cogs) FROM [Walmart].[dbo].[WalmartSalesData])


--Min cogs of product line.
SELECT TOP (1000) 
     Product_Line,
     ROUND((Cogs),2) as Min_Cogs

  FROM [Walmart].[dbo].[WalmartSalesData]
  WHERE Cogs = (SELECT MIN(Cogs) from [Walmart].[dbo].[WalmartSalesData])

  --Total gross income of each product.

SELECT TOP (1000) 
     Product_Line,
     ROUND(SUM([gross_income]),2) as Total_Gross_Income

FROM [Walmart].[dbo].[WalmartSalesData]
GROUP BY Product_line
ORDER BY Total_Gross_Income DESC

--Max rating of each product line

SELECT TOP (100) 
     Product_Line,
     ROUND(MAX(Rating),2) as Max_Rating
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Max_Rating

--  ---Min rating of each product line
SELECT TOP (100) 
     Product_Line,
     ROUND(MIN(Rating),2) as Min_Rating
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Min_Rating

---Avg rating of product line
  SELECT TOP (100) 
     Product_Line,
     ROUND(AVG(Rating),2) as Avg_Rating
	 
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Avg_Rating

--Rating criteria of product
SELECT Criteria, COUNT(*) as Number_Rating_Criteria FROM (
  SELECT TOP (1000)
  TIME,
  CASE
   WHEN Rating >=9 THEN 'Excellent'
   WHEN Rating >= 7 THEN 'Good'
   WHEN Rating > 5  THEN 'Pretty Good'
   WHEN Rating > 4 THEN 'Fair'
   WHEN Rating >3 THEN 'Bad'
  ELSE 'Very Bad'
  END Criteria
FROM [Walmart].[dbo].[WalmartSalesData])sub
GROUP BY Criteria
ORDER BY Number_Rating_Criteria

--Number of order each product line.

SELECT TOP (1000) 
	Product_Line,
    COUNT(*) Number_Product
    
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Number_Product 



