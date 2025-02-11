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

<h2>Customers Analysis</h2>

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


<b>6. How to find number of customers each day? </b><br>


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

<b>7. How to find number of customers each timing of the day? </b><br>

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

<b>8. How to find number of customers each day of week? </b><br>
Use <i><b>FORMAT and CAST</i></b> to extrach day name from date (data type) in abbreviated format.
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

