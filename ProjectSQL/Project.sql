Exercise 1: 

Comment on at least 4 aspects to improve the structure of the following table:

1. Incorrect Primary Key. The primary key is defined as a field or set of fields in a table used to uniquely identify each row of that table. Its purpose is to ensure data integrity and provide a means to uniquely identify records. Considering this, the primary key should be a unique field, not a description. Using a field like "Product_Code" as a primary key would be the correct option if it is a unique value for each product. Additionally, the data type being INT means that this variable is of integer type, without decimals and can be positive, negative, or zero.
2. Incorrect Data Type. "Creation_Date" is defined as VARCHAR(20), which is incorrect for storing dates. It should be of type DATE to properly store dates.
3. Incorrect Data Type. "Customer_Code" is defined as DATE; it should be categorized as an INT data type since it represents a unique code.
4. VARCHAR(20) Length: The data type being VARCHAR(20) implies that a column will store variable-length text strings with a maximum length of 20 characters. For this reason, we consider that the data type for "Product_Description" could be increased to allow for a more accurate description of the product.
5. Inefficiency in Table Design. It does not seem efficient for attributes like "Invoice_Date" and "Creation_Date" to be in the product table since they are not characteristics that define or identify the "Product" entity. It is important that there is no unnecessary data redundancy in the database, which led us to investigate normalization rules. According to 2NF: all non-key attributes must be fully dependent on the primary key. This is not the case for the three attributes mentioned above, so we believe they should be separated into different tables.

Exercise 2: 

1.1 Given the following query: 

SELECT p.LastName, 
SUM(soh.TotalDue) AS Total 
FROM Sales.Customer AS c 
LEFT JOIN Person.Person AS p 
ON c.PersonID = p.BusinessEntityID 
LEFT JOIN Sales.SalesOrderHeader AS soh 
ON c.CustomerID = soh.CustomerID 
GROUP BY p.LastName

a) Explain conceptually what it returns (information)

The information returned is a list of last names obtained from the Person.Person table, and the sum of the total order amount for each last name obtained from the Sales.SalesOrderHeader table.

One observation is that this query groups by last name, meaning it does not distinguish between individual customers. If we also select the customers' first names and group by this variable as well, it would return a much larger number of rows (19,019).

SELECT p.LastName, p.FirstName,
SUM(soh.TotalDue) AS Total 
FROM Sales.Customer AS c 
LEFT JOIN Person.Person AS p 
ON c.PersonID = p.BusinessEntityID 
LEFT JOIN Sales.SalesOrderHeader AS soh 
ON c.CustomerID = soh.CustomerID 
GROUP BY p.LastName, p.FirstName
ORDER BY p.LastName


b) Explain the purpose of using the LEFT JOIN clause

The purpose of the LEFT JOIN or LEFT OUTER JOIN clause is to retrieve all records from the left or first table and the related records from the second table. In other words, it is used to combine information and obtain customer surnames from the Person.Person table and, on the other hand, to get order data from the Sales.SalesOrderHeader table. To accomplish this, there must be a common variable between both tables, which is typically a unique identifier.
For this reason, the primary key of both tables is used. Thus, the LEFT JOIN brings all the data from the Sales.Customer table and the related records from the other two tables through the matching fields. Additionally, the LEFT JOIN includes null values from the specified tables. This is useful for displaying customer information regardless of whether they have made purchases or have associated contact information in the database.

c) Explain why the GROUP BY clause was used.

The GROUP BY clause is used to group rows of a table based on the characteristics of one or more specific columns. Typically, this clause is used with aggregate functions.

In this case, we use GROUP BY to group by last name due to the use of the SUM aggregation function in the SELECT statement, and to ensure that there are no duplicate last names.
1.2 Dada la siguiente consulta:

SELECT soh.OrderDate AS Fecha, 
p.Name AS Producto, 
COUNT(soh.SalesOrderID) AS CantOrders 
FROM Production.Product AS p 
INNER JOIN Sales.SalesOrderDetail AS sod 
ON P.ProductID = sod.ProductID 
INNER JOIN Sales.SalesOrderHeader AS soh 
ON sod.SalesOrderID = soh.SalesOrderID 
GROUP BY soh.OrderDate, p.Name 
HAVING COUNT(soh.SalesOrderID) > 1 
ORDER BY COUNT(soh.SalesOrderID) DESC 

a) Explain conceptually what the query returns (information):
This query returns the number of orders for each product from the Sales.SalesOrderHeader table, grouped by date (from the Sales.SalesOrderHeader table) and by product name (from the Production.Product table). It includes only those orders where the ID is greater than 1, and it orders the results by order ID in descending order.

b) Explain the purpose of using the INNER JOIN clauses: 

The INNER JOIN or JOIN clause is used to retrieve data from two related tables where each record in the first table corresponds to a record in the second table, and vice versa. In other words, it is used to obtain the products that meet the conditions established by the intersections of both tables. In this case, the products present in all three tables are retrieved. For example, in this case, the Production.Product table was joined with the Sales.SalesOrderDetail table through the shared ProductID field. Essentially, to achieve these table intersections, the primary keys (PK) or primary keys with foreign keys (FK) of each table are matched.

c) Explain the purpose of using the HAVING clause and why this was not done in the WHERE clause.

The HAVING clause is used to apply a condition to an aggregate function, which is why only groups that meet the HAVING conditions appear in the query result. In other words, it is used to filter groups of rows. In this case, HAVING is used to ensure that the count of SalesOrderID is greater than 1, as those with a count of zero are not relevant. On the other hand, the WHERE clause is used to filter individual rows, which does not apply here since we are dealing with aggregated data.

Escercise 3: 

Given the following queries, determine:
-Whether they are correct or not, provide justification if they are not correct and proceed to correct them.
-Conceptually explain what they return (what information).

a)Purpose:
SELECT DISTINCT c.CustomerID, CONCAT(p.FirstName, ', ', p.LastName) Full_Name, soh.RevisionNumber
FROM Sales.Customer c
JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
WHERE soh.TotalDue > 10000
ORDER BY c.CustomerID

Firstly, the table “SalesLT.Customer” does not exist in the database. If you want to extract information from the “Sales.Customer” table, it would not be possible for all the fields indicated in the SELECT statement, as “FirstName” and “LastName” belong to the Person.Person table, and “RevisionNumber” and “CustomerID” belong to the “Sales.SalesOrderHeader” table. To obtain information about people who are customers, you need to use the Sales.Customer table and join it with the Person.Person table through the CustomerID. To get all these fields, a JOIN between the mentioned tables should be performed.

b) 
If you want to extract information from the “Sales.Customer” table, it would not be possible for all the fields indicated in the SELECT statement, as “FirstName” and “LastName” belong to the Person.Person table. To obtain all these fields, a JOIN between “Sales.Customer” and “Person.Person” should be performed. Additionally, the tables CustomerAddress and Address do not exist. In the INNER JOIN, fields from the same table are being matched, which is incorrect. Table (a) was never defined at any point.
 
Purpose:
SELECT C.CustomerID, CONCAT(P.FirstName, ', ', P.LastName) NombreCompleto, ST.Name
FROM Sales.Customer AS C
JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
JOIN Sales.SalesTerritory AS ST
ON C.TerritoryID = ST.TerritoryID
WHERE ST.Name = 'CANADA'
ORDER BY C.CustomerID

The query retrieves customers who, based on their purchases, belong to the CANADA territory (the Quebec territory does not exist in the database). The results are sorted in ascending order by CustomerID. We use JOIN to access the individuals who are only customers. The WHERE clause is used to filter the St.Name field.

Excercise 4:

Develop the SQL query that generates the following result:

Retrieve all data for products with a list price between 25 and 250, that are exclusively Red, Blue, or Black, and have a size of M or XL. Sort them by list price in descending order.
Display the result returned by MSSQL Server Management Studio.

SELECT *
FROM Production.Product
WHERE Color IN ('RED', 'BLUE', 'BLACK')
	AND ListPrice BETWEEN 25 AND 250
	AND Size IN ('M', 'XL')
ORDER BY ListPrice DESC;

Comment:
It retrieves all data from the Production.Product table and filters the data based on Color, ListPrice, and Size as specified in the query.

Excercise 5:

The goal is to generate a report with the total billing and the number of invoices issued for each product model (show the name), sorted in descending order by the number of invoices (display information for all models, whether or not they have invoices issued).

SELECT PM.Name AS 'Nombre del Modelo',
	COUNT(SOH.SalesOrderID) AS 'Cantidad de facturas',
	ISNULL(SUM (SOH.TotalDue),0) AS 'Total de facturación'
FROM Production.ProductModel AS PM
	LEFT JOIN Production.Product P
		ON PM.ProductModelID = P.ProductModelID
			LEFT JOIN Sales.SalesOrderDetail AS SOD
				ON P.ProductID = SOD.ProductID
					LEFT JOIN Sales.SalesOrderHeader AS SOH
						ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY PM.Name
ORDER BY 'Cantidad de facturas' DESC;

Comment:
The query selects the Name of each product model from the Production.ProductModel table and joins it with the Production.Product table. This allows access to the Sales.SalesOrderDetail and Sales.SalesOrderHeader tables to retrieve data for each field in the SELECT statement.
Using LEFT JOIN ensures that all data from the Production.ProductModel table is preserved, while data from the Production.Product table is brought in. It then joins again with the Sales.SalesOrderDetail table to obtain the SalesOrderID and count them with the function COUNT(SOH.SalesOrderID) to determine the number of invoices associated with each model. If the model does not have any invoices, it returns NULL.
The ISNULL function is used to replace NULL values with 0, and the aggregation function SUM(SOH.TotalDue) is used to calculate the total amount billed for each product model. COUNT(SOH.SalesOrderID) is used to determine the number of invoices for each product model. The results are grouped by model using GROUP BY PM.Name, as aggregation functions are present in the SELECT statement.

Excercise 6: 

You want to generate a report with the category name and product name for products that do not have an associated sales order:

SELECT PC.Name AS Categoria, PP.Name As NombreProducto, SOD.SalesOrderID
FROM Production.Product AS PP 
LEFT JOIN Production.ProductSubcategory PS
ON PS.ProductSubcategoryID = PP.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS PC
ON PS.ProductCategoryID = PC.ProductCategoryID
LEFT JOIN Sales.SalesOrderDetail AS SOD
ON PP.ProductID = SOD.ProductID
WHERE SOD.SalesOrderID IS NULL;

Comment:

In the SELECT statement, we want to retrieve the category name, product name, and the sales order associated with each product.
To get this data, we use 3 JOINS. We need to reach the SalesOrderDetail table to obtain the SalesOrderID and traverse through the other tables to get the information requested in the SELECT. The first two JOINS are used to cross-reference information related to the product, where we obtain the intersecting data between the tables. The LEFT JOIN is used to get the sales orders for each product, whether or not there is a sales order (it brings NULL values).
We use the WHERE clause to filter and get all products that did NOT have a sales order.
 
Excercise 7:

Develop the SQL query to generate the following results:

-The quantity of products (total) purchased by customers whose total quantities are between 5 and 10.
-The quantity of products should be segmented by ProductID, Name (product), and CustomerID.
-The report should be sorted by ProductID and CustomerID in ascending order.
-Show the result returned by MSSQL Server Management Studio.
-The use of HAVING is suggested.

SELECT sod.ProductID, 
p.Name AS NombreProducto, 
soh.CustomerID,
	SUM (sod.OrderQty) AS CantidadProductosComprados
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p 
	ON sod.ProductID = p.ProductID
		JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY sod.ProductID, p.Name, soh.CustomerID
HAVING SUM(sod.OrderQty) BETWEEN 5 AND 10
ORDER BY sod.ProductID, soh.CustomerID;

Comment:
We want to obtain the ProductID, the product name, CustomerID, and the quantity purchased of each product.
To get this data, we use the SUM function to aggregate the quantity purchased for each product based on OrderQty.
We use JOIN with the Production.Product table to get the product name.
We use JOIN with the Sales.SalesOrderHeader table to get the CustomerID.
We group the results because we are using an aggregation function in the SELECT statement.
We apply a condition to the aggregation function using HAVING.

Excercise 8: 

Develop the SQL query to generate the following result based on the attached table:
• The number of orders and their total value (total sales) based on the sales range (for each sales range, indicate the number of orders and the total amount of those sales).

Show the result returned by MSSQL Server Management Studio.

SELECT Rango, COUNT(SalesOrderID) AS CantidadDeOrdenes, SUM(TotalDue) AS ValorTotal
FROM (
    SELECT SalesOrderID, TotalDue,
        CASE 
            WHEN TotalDue BETWEEN 0 AND 99.9999 THEN '1 - 0-99.9999'
            WHEN TotalDue BETWEEN 100 AND 499.9999 THEN '2 - 100-499.9999'
            WHEN TotalDue BETWEEN 500 AND 999.9999  THEN '3 - 500-999.9999'
            WHEN TotalDue BETWEEN 1000 AND 9999.9999  THEN '4 - 1000-9999.9999'
            ELSE '5 - 10000 EN ADELANTE'
        END AS Rango
    FROM Sales.SalesOrderHeader
) AS SalesData
GROUP BY Rango
ORDER BY Rango;

Comment:
We created a derived table to establish the Range, which we named SalesData. In this derived table, we used 2 columns (fields) and a third created with a CASE statement. For each Total Due and Sales Order, the range in which it falls is determined.
A larger query is performed to group by range, obtaining the total number of orders and sales for each range.

Excercise 9: 

You want to generate a report with the names of customers who purchased any product where the product model name contains the word "Mountain." This should be done using only subqueries (do not use JOINs).
Tip: ProductModel table.

SELECT P.FirstName, P.LastName
FROM Person.Person P
WHERE P.BusinessEntityID IN
	(SELECT C.PersonID
	FROM Sales.Customer C
	WHERE C.CustomerID IN
		(SELECT SOH.CustomerID
		FROM Sales.SalesOrderHeader SOH
		WHERE SOH.SalesOrderID IN
			(SELECT SOD.SalesOrderID
			FROM Sales.SalesOrderDetail SOD
			WHERE SOD.ProductID IN
				(SELECT P.ProductID
				FROM Production.Product P
				WHERE P.ProductModelID IN
					(SELECT PM.ProductModelID
					FROM Production.ProductModel PM
					WHERE PM.Name LIKE '%MOUNTAIN%')))));

Comment:
We approached the exercise from bottom to top, starting with the last subquery.
Subquery in the Production.ProductModel table (PM) to find all products with the word "Mountain" in their model.
Subquery in the Production.Product table (P) to get the ProductID of the products from the previous query.
Subquery in the Sales.SalesOrderDetail table (SOD) to obtain the SalesOrderID for the products from the previous query.
Subquery in the Sales.SalesOrderHeader table (SOH) to get the CustomerID for each sale associated with the products from the previous queries.
In the SELECT statement, we retrieve the names of these customers by joining with the SOH table using the CustomerID.


Excercise 10:

A person has been detected with a fraudulent card and is registered as a person in our company's database. We need to inform management if we can find out the name and card number of this person. The data we have is as follows:
The card in question starts with the number 7 and ends with 105.
We know that the card does not expire in the second half of the year.
Lastly, we know that the person's last name is fewer than 4 characters.
We need to formulate the query that returns all the concatenated data, in the following example format:

SELECT CONCAT(P.FirstName, ' ', P.LastName, ' - ', 'Tarjeta: ', CC.CardNumber,' - ' ,'Venc.' ,CC.ExpMonth, '/' ,CC.ExpYear) DatosTotales
FROM Sales.PersonCreditCard PCC
JOIN Sales.CreditCard CC
ON PCC.CreditCardID = CC.CreditCardID
JOIN Person.Person P
ON P.BusinessEntityID = PCC.BusinessEntityID
WHERE CC.CardNumber LIKE '7%' AND CC.CardNumber LIKE '%105'
		AND CC.ExpMonth BETWEEN 1 AND 6 
		AND P.LastName LIKE '___'

Comment:

We performed 2 joins to combine 3 tables and obtain the information we need. We use JOIN because we want to avoid nulls and also to find the intersecting data.
We concatenate all fields into a single one.
In the WHERE clause, we set the conditions that each field must meet, thereby filtering the data.
