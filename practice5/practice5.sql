1.Write a query that displays the names of customers and the names of the products purchased, ordered by customer.
References: Customer, Person, SalesOrderHeader, SalesOrderDetail, Product

SELECT DISTINCT P.BusinessEntityID, P.FirstName, P.LastName, PP.Name as ProductName
FROM Person.Person AS P 
JOIN Sales.Customer AS C
ON C.PersonID = P.BusinessEntityID
JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID
JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN Production.Product AS PP
ON SOD.ProductID = PP.ProductID
Order by P.BusinessEntityID

2. List the products that have never been ordered.
References: Product, SalesOrderDetail

SELECT P.ProductID, P.Name
FROM Production.Product AS P 
LEFT JOIN Sales.SalesOrderDetail AS SOD
ON P.ProductID = SOD.ProductID 
WHERE SOD.ProductID IS NULL

3. Write a query that displays the quantity sold of each product by sale date, ordered by Product ID and quantity sold from highest to lowest.
References: SalesOrderHeader, SalesOrderDetail, Product

SELECT SUM(OrderQty) AS ’Suma de las ordenes’,  P.ProductID, SOH.OrderDate
FROM Production.Product AS P
JOIN Sales.SalesOrderDetail AS SOD
ON P.ProductID = SOD.ProductID
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
Group by P.ProductID, SOH.OrderDate
ORDER BY P.ProductID,  SUM(OrderQty) DESC

4. Get the ID, name, and quantity of the 10 most sold products in March 2003, ordered by quantity sold in descending order.
References: Product, SalesOrderDetail, SalesOrderHeader

SELECT TOP 10 P.ProductID, P.Name, SUM(OrderQty) AS ’Total’
FROM Production.Product AS P
JOIN Sales.SalesOrderDetail AS SOD
ON P.ProductID = SOD.ProductID
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE YEAR(OrderDate) = 2003 AND  MONTH (OrderDate)  = 3
Group by P.ProductID, P.Name
ORDER BY Total DESC

5. Create a report with the order ID and the quantity of products sold (by sale) where the model name contains the word “mountain”.
References: Product, SalesOrderDetail, SalesOrderHeader, ProductModel

SELECT soh.SalesOrderID, SUM(sod.OrderQty) AS Total
FROM Sales.SalesOrderHeader SOH
JOIN Sales.SalesOrderDetail AS SOD 
ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN Production.Product AS P
ON SOD.ProductID = P.ProductID
JOIN Production.ProductModel AS PM  
ON PM.ProductModelID = P.ProductModelID
WHERE PM.Name LIKE '%mountain%'
GROUP BY SOH.SalesOrderID
ORDER BY Total DESC
