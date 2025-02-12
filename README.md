# SQL Walmart Sales

<h2>About Data</h2>

SQL Project Analyzing Walmart Sales in Myanmar Naypyitaw,Yangon, and Mandalay Cities to find data insight.

<h2>Table Data Type</h3>

| Column        | Description | Data Type    |
|-------------|-----|---------------|
| Invoice_ID       | To identify purchase order.  | varchar(50)  |
| Branch       | Branchs in Myanmar represent city consist of  <br> A = Yangon, B = Mandalay, and C = Naypyitaw  | varchar(50)  |
| City         | City in  Myanmar consist of Naypyitaw,Yangon, and Mandalay | varchar(50)      |
| Customer_type     | Type of customers consist of Member and Normal.  |    varchar(50)    |
| Gender      | Gender of customers  | varchar(50)  |
| Product_Line  | 6 Types of products <br> 1. Fashion accessories <br> 2. Health and beauty <br> 3. Electronic accessories <br> 4. Food and beverages <br> 5. Sports and travel <br> 6. Home and lifestyle |varchar(50)     |
| Unit_price     | Price per 1 unit of product.  | float      |
| Quantity       | Product quantity was purchased by customers.  | int |
| Tax_5        | Price by tax 5% of unit price.  | float      |
| Total     | Total price when customer purchase the products.  | float       |
| Date         | The date of customers ordered products. |   date    |
| Time     | The time of customers ordered products. | time       |
| Payment         | Payment type by customers consist of Cash, Ewallet, and Credit card. | varchar(50)      |
| Cogs     | Cost of goods sold (COGS) is the direct cost of making a company's products.  | float       |
| Gross_Margin_Percentage         | Percentage about margin of gross profit and sales.  | float  |
| Gross_Income    | Total income earned by all sources before tax and others deductions.  | float       |
| Rating     | Rating of products. | float      |


<h2>Analysis the Data</h2>

<h2>Customer Analysis</h2>

Customer analysis aims to understand the target group of customers and identify the types of customers who purchase the product for marketing strategy improvement to gain more revenue.

<h3>Business Questions and SQL solutions</h3>
<b>1. How to find Percentage of customer type? </b> <br>

Use <i><b> Subquery </b></i> to find percentage by counting all rows as a diversor.
```sql
SELECT TOP (1000)
   Gender
  ,Customer_Type
  ,COUNT(Gender) as Total
  ,100*COUNT(Gender) / (SELECT COUNT(*) FROM [Walmart].[dbo].[WalmartSalesData]) AS Percentage
  FROM [Walmart].[dbo].[WalmartSalesData]
GROUP BY Gender, Customer_Type;
```
<b>Output</b>

| Gender        | Customer_Type | Customer_Number    | Percentage | 
|-------------|-----|---------------|------------|
| Male       | Normal  | 259  | 25 |
| Male       | Member  | 240  | 24 |
| Female       | Normal  | 240  | 24 |
| Female       | Member  | 261  | 26 |

<b>2. How to find Percentage of Gender? </b><br>

```sql
SELECT TOP (1000)
  Gender
 ,COUNT(Gender) as Total_Gender
 ,100*	COUNT(Gender) / (SELECT COUNT(*) FROM [Walmart].[dbo].[WalmartSalesData]) AS Percentage
  FROM [Walmart].[dbo].[WalmartSalesData]
GROUP BY Gender
```

<b>Output</b>


| Gender        | Total_Gender  | Percentage | 
|-------------|-----|-----------|
| Male       |  499  | 49 |
| Female       | 501  | 51 |


<b>3. How to find number of customer by payment type? </b><br>

```sql
SELECT TOP (1000)
  Payment
  ,COUNT(*) AS Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Payment
  ORDER BY Customer_Number
```

<b>Output</b>


| Payment        | Customer_Number    | 
|-------------|-----|
| Credit card       | 311  |
| Cash      | 344  |
| Ewallet       | 345  | 


<b>4. How to find number of customer by gender each product line? </b><br>

```sql
SELECT TOP (1000)
  Product_Line
 ,Gender
 ,COUNT(*) as Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_line ,Gender
ORDER BY Product_line
```

<b>Output</b>


| Product_Line        | Gender    | Customer_Number|
|-------------|-----|-----|
| Electronic accessories      | Female | 84 |
| Electronic accessories     | Male | 86|
| Fashion accessories      | Female | 96 |
| Fashion accessories     | Male | 82|
| Food and beverages     | Female | 90 |
| Food and beverages     | Male | 84|
| Health and beauty      | Female | 64 |
|Health and beauty    | Male | 88|
| Home and lifestyle      | Female | 79 |
| Home and lifestyle     | Male | 81|
| Sports and travel     | Female | 88 |
| Sports and travel     | Male | 78|


<b>5. How to find number of customers each city? </b><br>

```sql
 SELECT TOP (1000)
  City
  ,COUNT(*) as Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY City
  ORDER BY Customer_Number
```

<b>Output</b>

| City        |  Customer_Number|
|-------------|----|
| Naypyitaw |  328 |
| Mandalay   |  332|
| Yangon | 340 |

<b>6. How to find number of customer by gender of each city? </b><br>

```sql
    SELECT TOP (1000)
  City,
  Gender
  ,COUNT(Gender) as Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY  City,Gender
  ORDER BY City
```

<b>Output</b>

| City        |  Gender | Customer_Number|
|-------------|----|----------------|
| Mandalay|  Female | 162 |
| Mandalay   |  Male | 170|
| Naypyitaw |  Female | 178 |
| Naypyitaw   |  Male | 150 |
| Yangon |  Female | 161 |
| Yangon   |  Male | 179 |

<b>7. How to find number of customers each day? </b><br>


```sql
SELECT Date ,sub.Customer_Number
FROM
(
SELECT Date,  
       COUNT(*) as Customer_Number
  FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Date
) sub

ORDER BY Date
```

<b>8. How to find number of customers each timing of the day? </b><br>

Use <b><i>CASE WHEN</b></i> for grouping by condition.
```sql
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

```
<b>Output</b>

| Timing       |  Customer_Number|
|-------------|----|
| Night Time |  75 |
| Evening Time   |  280|
| Morning Time | 280 |
| Afternoon Time | 365 |

<b>9. How to find number of customers each day of week? </b><br>
Use <i><b>FORMAT and CAST</i></b> to extract day name from date (data type) in abbreviated format.
```SQL
SELECT Day_Name,  COUNT(*) Customer_Number
FROM (
SELECT 
       FORMAT(CAST(Date as date), 'ddd') as Day_Name  
  FROM [Walmart].[dbo].[WalmartSalesData]

) subq
GROUP BY Day_Name
ORDER BY Customer_Number DESC
```

<b>Output</b>

| Day_Name       |  Customer_Number|
|-------------|----|
| Sat|  164 |
| Tue   |  158|
| Wed| 143 |
| Fri | 139 |
| Thu  |  138|
| Sun| 133 |
| Mon | 125 |

<b>10. How to find number of customers each month? </b><br>
Use <i><b>FORMAT and CAST</i></b> to extract month name from date (data type) in abbreviated format.
```SQL
SELECT Month_Name,  COUNT(*) Customer_Number
FROM (
SELECT 
       FORMAT(CAST(Date as date), 'MMM') as Month_Name  
  FROM [Walmart].[dbo].[WalmartSalesData]

) subq
GROUP BY Month_Name
ORDER BY Customer_Number DESC

```

<b>Output</b>

| Month_Name       |  Customer_Number|
|-------------|----|
| Jan|  352 |
| Mar   |  345 |
| Feb | 303 |




<br>
<hr>
<br>
<h2>Product Analysis</h2>

Product analysis is analyzed about rating and cogs to identify what product line gains the most profit for enhancing product quality and planning budget.
<h3>Product Questions and SQL solutions</h3>

<b>1. How to find total cogs of each product? </b> <br>


```sql
SELECT TOP (1000) 
	Product_Line,
    ROUND(SUM(Cogs),2) AS Total_Cogs,
    ROUND(SUM(Total),2) AS Total_Sales

  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Total_Cogs DESC
```
<b>Output</b>

| Product_Line       | Total_Cogs | Total_Sales    |
|-------------|-----|---------------|
| Food and beverages       | 53471.28  | 56144.84  |
| Sports and travel       | 52497.93  | 55122.83  | 
| Electronic accessories       | 51750.03  | 54337.53  | 
| Fashion accessories       | 51719.9  | 54305.9  | 
| Home and lifestyle      | 51297.06  | 53861.91  |
| Health and beauty     | 46851.18  | 49193.74  | 


<b>2. How to find max Cogs of each product line? </b> <br>
```sql
SELECT TOP (1000) 
     Product_Line,
     ROUND(MAX(Cogs),2) AS Max_Cogs
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Max_Cogs DESC
```
<b>Output</b>

| Product_Line       | Max_Cogs | 
|-------------|---------------------|
| Fashion accessories   | 993 |
| Food and beverages     | 985.2  | 
| Home and lifestyle      | 975  | 
| Sports and travel       | 954.4  | 
| Health and beauty     | 905 | 
| Electronic accessories     | 897.57 | 


<b>3. How to find min Cogs of each product line? </b> <br>
```sql
SELECT TOP (1000) 
     Product_Line,
     ROUND(MIN(Cogs),2) AS Min_Cogs
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Min_Cogs DESC
```
<b>Output</b>

| Product_Line       | Min_Cogs | 
|-------------|---------------------|
| Fashion accessories   | 25.45 |
| Food and beverages     | 21.58  | 
| Health and beauty     | 17.75  | 
| Home and lifestyle      | 13.98  | 
| Fashion accessories    | 12.09 | 
| Sports and travel     | 10.17 | 

<b>4. What product line has the most cogs? </b> <br> 
```sql
SELECT TOP (1000)
     Product_Line,
     ROUND((Cogs),2) as  Max_Cogs
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  WHERE Cogs = (SELECT MAX(Cogs) FROM [Walmart].[dbo].[WalmartSalesData])
```
<b>Output</b>

| Product_Line       | Max_Cogs | 
|-------------|---------------------|
| Fashion accessories   | 993 |

<b>5. What product line has min cogs? </b> <br> 
```sql
SELECT TOP (1000)
     Product_Line,
     ROUND((Cogs),2) as Min_Cogs

  FROM [Walmart].[dbo].[WalmartSalesData]
  WHERE Cogs = (SELECT MIN(Cogs) from [Walmart].[dbo].[WalmartSalesData])
```
<b>Output</b>

| Product_Line       | Min_Cogs | 
|-------------|---------------------|
| Sports and travel   | 10.17 |


<b>6. How to find total gross income of each product line? </b> <br> 
```sql
SELECT TOP (1000) 
     Product_Line,
     ROUND(SUM([gross_income]),2) as Total_Gross_Income

FROM [Walmart].[dbo].[WalmartSalesData]
GROUP BY Product_line
ORDER BY Total_Gross_Income DESC

```
<b>Output</b>

| Product_Line       | Total_Gross_Income | 
|-------------|---------------------|
| Food and beverages   | 2673.56  |
| Sports and travel  | 2624.9 |
| Electronic accessories   | 2587.5  |
| Fashion accessories| 2586 |
| Home and lifestyle  | 2564.85 |
| Health and beauty   | 2342.56 |



<b>7. How to find max rating each product line? </b> <br> 
```sql
SELECT TOP (100) 
     Product_Line,
     ROUND(MAX(Rating),2) as Max_Rating
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Max_Rating
```
<b>Output</b>

| Product_Line       | Max_Rating | 
|-------------|---------------------|
| Fashion accessories| 9.9 |
| Food and beverages | 9.9 |
| Home and lifestyle  | 9.9 |
| Sports and travel | 10 |
| Electronic accessories | 10 |
| Health and beauty   | 10 |



<b>8. How to find min rating each product line? </b> <br> 
```sql
SELECT TOP (100) 
     Product_Line,
     ROUND(MIN(Rating),2) as Min_Rating
	
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Min_Rating
```
<b>Output</b>

| Product_Line       | Min_Rating | 
|-------------|---------------------|
| Sports and travel| 4 |
| Food and beverages | 4 |
| Electronic accessories  | 4 |
| Health and beauty | 4 |
| Fashion accessories | 4 |
| Home and lifestyle  | 4.1 |


<b>9. How to find average rating each product line? </b> <br> 
```sql
 SELECT TOP (100) 
     Product_Line,
     ROUND(AVG(Rating),2) as Avg_Rating
	 
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Avg_Rating
```
<b>Output</b>

| Product_Line       | Avg_Rating | 
|-------------|---------------------|
| Home and lifestyle| 6.84 |
| Sports and travel| 6.92 |
| Electronic accessories  | 6.92 |
| Health and beauty | 7 |
| Fashion accessories | 7.03 |
| Food and beverages | 7.11 |


<b>10. Identify criteria of rating. </b> <br> 
```sql
SELECT Criteria, COUNT(*) as Number_Rating_Criteria FROM (
  SELECT TOP (1000)
  TIME,
  CASE
   WHEN Rating >= 9 THEN 'Excellent'
   WHEN Rating >= 7 THEN 'Good'
   WHEN Rating > 5  THEN 'Pretty Good'
   WHEN Rating > 4 THEN 'Fair'
   WHEN Rating > 3 THEN 'Bad'
  ELSE 'Very Bad'
  END Criteria
FROM [Walmart].[dbo].[WalmartSalesData])sub
GROUP BY Criteria
ORDER BY Number_Rating_Criteria
```
<b>Output</b>

| Criteria       | Number_Rating_Criteria | 
|-------------|---------------------|
| Bad| 11 |
| Fair| 163 |
| Excellent  | 166|
| Pretty Good | 325 |
| Good | 335 |


<b>11. How to find number of order each product line. </b> <br> 
```sql
SELECT TOP (1000) 
	Product_Line,
    COUNT(*) Number_Product
    
  FROM [Walmart].[dbo].[WalmartSalesData]
  GROUP BY Product_Line
  ORDER BY Number_Product 

```
<b>Output</b>

|Product_Line     | Number_Product  | 
|-------------|---------------------|
| Health and beauty| 152 |
| Home and lifestyle| 160 |
| Sports and travel  | 166|
| Electronic accessories | 170 |
| Food and beverages | 174 |
|Fashion accessories | 178 |

<br>
<hr>
<br>

<h2>Sales Analysis</h2>

The objective of sales analysis is to optimize sales strategies for products.
<h3>Sales Questions and SQL solutions</h3>

<b>1. How to fine sales by each day.</b>

```sql
SELECT Date ,sub.Total_Sales
FROM
(
SELECT Date,  
       ROUND(SUM(Total),2) AS Total_Sales
  FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Date
) sub

ORDER BY Date
```
<b>2. How to fine sales by each day.</b>

```sql
SELECT Date ,sub.Total_Sales
FROM
(
SELECT Date,  
       ROUND(SUM(Total),2) AS Total_Sales
  FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Date
) sub

ORDER BY Date
```

<b>3. How to fine total sales by city.</b>

```sql
SELECT 
 City, ROUND(SUM (Total),2) AS Total_Sales
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY City

```

|City     | Total_Sales  | 
|-------------|---------------------|
| Naypyitaw | 110568.71 |
| Yangon | 106200.37 |
| Mandalay | 106197.67 |


<b>4. How to fine total sales by payment type.</b>

```sql
SELECT 
 Payment, ROUND(SUM (Total),2) AS Total_Sales
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Payment
 ORDER BY Total_Sales
```

|Payment     | Total_Sales  | 
|-------------|---------------------|
| Credit card | 100767.07 |
| Ewallet | 109993.11 |
| Cash | 112206.57|


<b>5. How to fine max sales by product line </b>
```sql
SELECT
 Product_Line
,ROUND(MAX(total),2) AS Max_Sale

 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Product_Line
 ORDER BY Max_Sale DESC
```

|Product_Line     | Max_Sale  | 
|-------------|---------------------|
| Fashion accessories | 1042.65 |
| Food and beverages | 1034.46 |
| Home and lifestyle | 1023.75|
| Sports and travel | 1002.12 |
| Health and beauty| 950.25|
| Electronic accessories| 942.45|


<b>6. How to fine min sales by product line </b>
```sql
 SELECT 
 Product_Line
,ROUND(MIN(Total),2) AS Min_Sale

 FROM [Walmart].[dbo].[WalmartSalesData]

 GROUP BY Product_line
 ORDER BY Min_Sale
```

|Product_Line     | Min_Sale  | 
|-------------|---------------------|
| Sports and travel | 10.68 |
| Fashion accessories | 12.69 |
| Home and lifestyle | 14.68 |
| Health and beauty | 18.64 |
| Food and beverages | 22.66 |
| Electronic accessories|26.72|

<b>7. How to fine average sales by product line </b>
```sql
 SELECT 
 Product_line
,ROUND(AVG(Total),2) AS Avg_Sale
 FROM [Walmart].[dbo].[WalmartSalesData]
 GROUP BY Product_line
 ORDER BY Avg_Sale DESC

```

|Product_Line     | Avg_Sale  | 
|-------------|---------------------|
| Home and lifestyle |  336.64 |
| Sports and travel | 332.07 |
| Health and beauty | 323.64 |
| Food and beverages| 322.67 |
| FElectronic accessories | 319.63 |
| Fashion accessories |305.09 |









