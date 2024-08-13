1. Write a query that shows products with the same color as the product named ‘Chain’. Exclude the product ‘Chain’ from the list.

SELECT Name, Color 
FROM Production.Product
WHERE Color= 
	(SELECT Color
FROM Production Product
WHERE name= ‘CHAIN’)
AND NAME <> ‘CHAIN’

2. Write a query that shows products with a price above the overall average price, ordered by product price in ascending order.

SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice >
	(SELECT AVG(ListPrice)
FROM Production.Product)
OrderBy ListPrice

3. Using subqueries, write a query that shows products that belong to the same category as the product “Road-150 Red, 62”.

SELECT PP.Name
FROM Production.Product AS PP
WHERE PP.ProductSubcategoryID IN
	(SELECT PSC.ProductSubcategoryID
FROM Production.ProductSubcategory AS PSC
WHERE PSC.ProductCategoryID =
	(SELECT PSC.ProductCategoryID
FROM Production.ProductSubcategory AS PSC
WHERE PSC.ProductSubcategoryID = 
		(SELECT PP.ProductSubcategoryID
FROM Production.Product AS PP
WHERE PP.Name = ‘Road-150 Red, 62’)))

4. Show all products that have had sales in the year 2003. Use the tables: Production.Product, Production.TransactionHistory. Column: TransactionDate

SELECT Name
FROM Production.Product IN
	(SELECT ProductID
FROM Production.TransactionHistory
WHERE YEAR (TransactionDate) = 2003)

5. Show the first name and last name of customers (People) who have purchased at least one unit of the product(s) with the lowest price (other than 0). Use the tables: Production.Product -> ListPrice, Sales.SalesOrderDetail, Sales.SalesOrderHeader, Sales.Customer, Person.Person

SELECT FirstName, LastName
FROM Person.Person AS PP
WHERE PP.BusinessEntityID IN
(SELECT PersonID
FROM Sales.Customer
WHERE CustomerID IN
	(SELECT CustomerID
FROM Sales.SalesOrderHeader
WHERE SalesOrderID IN
		SELECT SalesOrderID
FROM Sales.SalesOrderDetail
WHERE ProductID =
			SELECT ProductID
FROM Production.Product
WHERE ListPrice = 
				SELECT MIN (ListPrice)
FROM Production.Product
WHERE ListPrice <> 0)))))

6. List CustomerID, SalesOrderID, and OrderDate for all orders from customers who have made at least 5 orders. Perform the same query using a subquery.

SELECT SOH.CustomerID, SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader AS SOH
JOIN
	(SELECT CustomerID
FROM Sales.SalesOrderHeader AS SOH
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) >= 5) AS TABLA	
ON SOH.CustomerID = TABLA.CustomerID

SUBQUERY VERSION:

SELECT SOH.CustomerID, SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader AS SOH
WHERE CustomerID IN
	(SELECT CustomerID
FROM Sales.SalesOrderHeader AS SOH
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) >= 5)

7. List FirstName, LastName, HireDate, JobTitle, and the number of employees with the same job title.

SELECT FirstName, LastName, EM.JobTitle, HireDate, CANTIDAD
FROM Person.Person AS PP
JOIN HumanResources.Employee AS EM
ON PP.BusinessEntityID = EM.BusinessEntityID
		JOIN
			(SELECT JobTitle, COUNT (JobTitle) AS CANTIDAD
FROM HumanResources.Employee AS EM
GROUP BY JobTitle) AS TOTALEMPLEADOS 
ON EM.JobTitle = TOTALEMPLEADOS.Jobtitle
