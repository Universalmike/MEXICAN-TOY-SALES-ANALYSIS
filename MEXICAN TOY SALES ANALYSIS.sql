--------------------------------------------------------OVERVIEW----------------------------------------------------------------

SELECT *
FROM [MT sales]

SELECT *
FROM [MT products]

SELECT AVG(product_price), MAX(Product_price), MIN(product_price)
FROM [MT products]

SELECT *
FROM [stores]

SELECT *
FROM [MT inventory]

  --How many sales?
SELECT COUNT(*)
  FROM [MT sales]
--There are 829,262 sales

---NUMBER OF SALES MADE YEARLY, MONTHLY AND DAILY
SELECT DISTINCT(Years)
FROM (SELECT *, DATEPART(YEAR, Date) AS Years, DATENAME(MONTH, Date) as Months, DATENAME(weekday, Date) as weekdays
FROM [MT sales]
) as sub
---These dataset are sales from 2017 and 2018

SELECT Years, COUNT(Years) as no_of_sales_each_year
FROM (SELECT *, DATEPART(YEAR, Date) AS Years, DATENAME(MONTH, Date) as Months, DATENAME(weekday, Date) as weekdays
FROM [MT sales]
) as sub
GROUP BY Years
--Over 400,000 sales in both years

SELECT Product_Category, COUNT(Product_Name)
FROM [MT products]
GROUP BY Product_Category
--There are 5 different categories of product--
--There are 9 different Toy products which is the most--
--Art & Crafts, Games have 8 different products and Sports & Outdoors have 7 while there are just 3 different Electronics product---

SELECT COUNT(DISTINCT(Store_City))
FROM stores
---There are 29 different store cities----

SELECT DISTINCT(Store_Location)
FROM stores

SELECT COUNT(DISTINCT(Store_Location))
FROM stores
--There are 4 different store loactions---
--Downtown, Airport, Commercial, Residential---


SELECT Store_Location, COUNT(Store_Location)
FROM stores
GROUP BY Store_Location
---There are only 3 Airport stores while Downtown stores are 29--
--6 Residential stores, 12 Commercial stores---

--WHICH MONTH DO THEY RECORD AVERAGE SALES?
SELECT Months, COUNT(Months) as no_of_sales_eacH_MONTH
FROM (SELECT *, DATEPART(YEAR, Date) AS Years, DATENAME(MONTH, Date) as Months, DATENAME(weekday, Date) as weekdays
FROM [MT sales]
) as sub
GROUP BY Months
ORDER BY no_of_sales_eacH_MONTH DESC
--The made more sales in the middle of the year--

SELECT weekdays, COUNT(weekdays) as no_of_sales_eacH_MONTH
FROM (SELECT *, DATEPART(YEAR, Date) AS Years, DATENAME(MONTH, Date) as Months, DATENAME(weekday, Date) as weekdays
FROM [MT sales]
) as sub
GROUP BY weekdays
ORDER BY no_of_sales_eacH_MONTH DESC
--They get more sales at the weekend--

SELECT *, DATEPART(YEAR, Date) AS Years, DATENAME(MONTH, Date) as Months, DATENAME(weekday, Date) as weekdays
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
ORDER BY Product_Price DESC

-------------------------------------------------------PRODUCT ANALYSIS----------------------------------------------------------

--What kind of product has the highst number of sales
SELECT Product_Category, COUNT(Product_Category) as PC
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
GROUP BY Product_Category
ORDER BY PC DESC
--Toy's and Art & Crafts product are the most sold products while electronics sell less--
--Could this be due to price or how essential it is?

SELECT Product_Category, AVG(Product_Price) as Avg_Product_category_price
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
GROUP BY Product_Category
ORDER BY Avg_Product_category_price DESC
--Toy products has the highest average price and still the product that is most sold--
--Electronics is the least most sold product but the second highest average price product--
--Arts and Crafdts which is the most sold kind of product is the product with the least avverage price--

--Lets look at the profit gotten from each product category
SELECT Product_Category, SUM(Profit_per_sales) as Profit_per_Category
FROM  (SELECT s.Sale_ID, s.Store_ID, s.Units, p.Product_Category, p.Product_Name, p.Product_Cost, p.Product_Price, Product_Price - Product_Cost as Profit_per_sales, s.Product_ID as Sales_Product_ID
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
) as sub
GROUP BY Product_Category
ORDER BY Profit_per_Category DESC
--Toys sales brought more profit--
--Electronics sales is the second highes making sales despite being the least sold among the categories but its products has the second highest average price---

--Product Categories profits in different store locations
SELECT Product_Category, Store_Location, SUM(Profit_per_sales) as Profit_per_Category_in_Locations
FROM(
 SELECT Product_Category, Store_Location, Product_Price - Product_Cost as Profit_per_sales
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
INNER JOIN stores st
ON s.Store_ID=st.Store_ID
) as sub
GROUP BY Product_Category, Store_Location
ORDER BY  Profit_per_Category_in_Locations DESC
--Profit from the sales are high in all store location but not the highest in commercial areas as Electronics sales drives more profit---

---WHICH time of the year each product category is being bought the most---
SELECT Product_Category, Months, COUNT(Months) as Profit_per_Category_in_Locations
FROM(
 SELECT Product_Category, DATENAME(MONTH, Date) as Months --Product_Price - Product_Cost as Profit_per_sales
 FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
INNER JOIN stores st
ON s.Store_ID=st.Store_ID
) as sub
GROUP BY Product_Category, Months
ORDER BY  Profit_per_Category_in_Locations DESC

--Most products sold----
SELECT Product_Name, COUNT(Product_Name) as PC
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
GROUP BY Product_Name
ORDER BY PC DESC

--The sales level of each Toy products---
SELECT Product_Name, Product_price, COUNT(Product_Name) as Toy_Product_Sales
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
WHERE Product_Category = 'Toys'
GROUP BY Product_Name,  Product_Price 
ORDER BY Toy_Product_Sales DESC

--The sales level of each Electronics products---
SELECT Product_Name, Product_price, COUNT(Product_Name) as Toy_Product_Sales
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
WHERE Product_Category = 'Electronics'
GROUP BY Product_Name,  Product_Price 
ORDER BY Toy_Product_Sales DESC

-------The sales level of each Art & Crafts products----
SELECT Product_Name, Product_price, COUNT(Product_Name) as Toy_Product_Sales
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
WHERE Product_Category = 'Art & Crafts'
GROUP BY Product_Name,  Product_Price 
ORDER BY Toy_Product_Sales DESC


---The sales level of each Games products---
SELECT Product_Name, Product_price, COUNT(Product_Name) as Toy_Product_Sales
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
WHERE Product_Category = 'Games'
GROUP BY Product_Name,  Product_Price 
ORDER BY Toy_Product_Sales DESC

---The sales level of each Sports & Outdoors products----
SELECT Product_Name, Product_price, COUNT(Product_Name) as Toy_Product_Sales
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
WHERE Product_Category = 'Sports & Outdoors'
GROUP BY Product_Name,  Product_Price 
ORDER BY Toy_Product_Sales DESC

--------------------------------------------------------STORE ANALYSIS---------------------------------------------------------------

---	Sales from different kind of store locations--
SELECT Store_Location, COUNT(Store_Location) as sl
FROM( SELECT Store_Location
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
INNER JOIN stores st
ON s.Store_ID=st.Store_ID
) as sub
GROUP BY  Store_Location
ORDER BY sl desc
---There are way more sales coming from the stores in Downtown areas than the Commercial areas which is behind----
---Stores in Airport areas makes the lowest sales(not surprising)---

--LETS CHECK AVERAGE SALS FROM EACH STORE LOCATIONS--
SELECT *,
		CASE WHEN Store_Location = 'Downtown' THEN sl/29
			WHEN Store_Location = 'Commercial' THEN sl/12
			WHEN Store_Location = 'Residential' THEN sl/6
			WHEN Store_Location = 'Airport' THEN sl/3
			END as Avg_Store_Location_sales
FROM ( SELECT Store_Location, COUNT(Store_Location) as sl
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
INNER JOIN stores st
ON s.Store_ID=st.Store_ID
GROUP BY  Store_Location
--ORDER BY sl desc
) as sub
ORDER BY Avg_Store_Location_sales DESC
--Airport store areas is average more sales than the rest---
--The rest of the store areas average sales are not far off--
--Downtown sales are more because of more sales stores, there are downtown stores in all cities---


SELECT Date, Store_Location, COUNT(Store_Location) as sl
FROM( SELECT Date, Store_Location
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
INNER JOIN stores st
ON s.Store_ID=st.Store_ID
) as sub
GROUP BY  Date, Store_Location
ORDER BY Date

SELECT Store_Location, SUM(Stock_On_Hand) as stock
FROM [stores] s
INNER JOIN [MT inventory] I
ON s.Store_ID=I.Store_ID
GROUP BY Store_Location
ORDER BY stock DESC
--Downtown stores has more stocks in hand than other areas while Airports has less---

--Which City stores is getting more sales--
SELECT Store_City, COUNT(Store_City) as City_Sales
FROM [stores] st
INNER JOIN [MT sales] s
ON st.Store_ID=s.Store_ID
GROUP BY Store_City
ORDER BY City_Sales DESC

--Which City stores is getting the most stocks--
SELECT Store_City, SUM(Stock_On_Hand) as stock
FROM [stores] s
INNER JOIN [MT inventory] I
ON s.Store_ID=I.Store_ID
GROUP BY Store_City
ORDER BY stock DESC

--Checking how old each store is and the number of sales they arec making---
SELECT Store_City, Store_Location, Store_Age, COUNT(Store_Location) as Store_Sales
FROM (
SELECT Store_City, Store_Location, Store_Open_Date, 2018 - DATEPART(Year, Store_Open_Date) as Store_Age
FROM [stores] st
INNER JOIN [MT sales] s
ON st.Store_ID=s.Store_ID
) as sub
GROUP BY Store_City, Store_Location, Store_Age
ORDER BY store_Sales DESC

SELECT Product_Name, COUNT(Product_Name) as PC
FROM [MT sales] s
INNER JOIN [MT products] p
ON s.Product_ID=p.Product_ID
GROUP BY Product_Name
ORDER BY PC DESC