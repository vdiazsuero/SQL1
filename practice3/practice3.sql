1. The HR department wants to know how many people are in their database (name the column ‘Number of People’).

SELECT COUNT (*) AS ‘Cantidad de Personas’
FROM Person.Person

2. Get the number of people by type (field PersonType).

SELECT PersonType, COUNT (*) AS ‘Cantidad de Personas’
FROM Person.Person
GROUP BY PersonType

3. Get the total sum in the sales order lines grouped by order (group by SalesOrderID).

SELECT SalesOrderID, SUM (LineTotal) AS ‘Subtotal’
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

4. For each COLOR, get the number of products of that color and sort them from highest to lowest quantity.

SELECT Color, Count (Color) AS ‘Cantidad de color’
FROM Production.Product
Group By Color
Order By ‘Cantidad de color’  DESC

5. For each COLOR, get the sum of the prices of the products of that color and sort them by the result of the sum from highest to lowest.

SELECT Color, SUM (ListPrice) AS ‘Total Precio’
FROM Production.Product
Group By Color
Order By ‘Total Precio’  DESC

6. Determine the number of employees by job positions, ordered from highest to lowest quantity.

SELECT JobTitle, Count (JobTitle) AS ‘Total en el puesto’
FROM HumanResources.Employee
Group By JobTitle
Order By ‘Total en el puesto’ DESC

7. Get the total sum in the sales order lines grouped by order (group by SalesOrderID) where the total per order is greater than 100,000 (one hundred thousand).

SELECT SalesOrderID, SUM (LineTotal) AS ‘Subtotal’
FROM Sales.SalesOrderDetail
Group By SalesOrderID
Having SUM (LineTotal) > 100
Order By ‘SalesOrderID’

8. For each COLOR, get the number of products of that color, but only include colors that have more than 40 products.

SELECT Color, COUNT (Color) AS ‘Cantidad de color’
FROM Production.Product
Group By Color
Having COUNT (Color) > 40

9. Determine the number of employees by job positions, ordered from highest to lowest, who joined the company in 1999.

SELECT JobTitle, Count (JobTitle) AS ‘Total en el puesto’, 
FROM HumanResources.Employee
Where YEAR (HireDate) = 1999
Group By JobTitle
Order By Count (JobTitle) DESC

10. Determine the number of employees by job positions, ordered from highest to lowest, who joined the company from the year 2000 onwards, excluding the year 2002. Only include positions with quantities greater than 1.

SELECT JobTitle, Count (JobTitle) AS ‘Total en el puesto’, 
FROM HumanResources.Employee
Where YEAR (HireDate) > 2000 AND YEAR(HireDate) <> 0 
Group By JobTitle
Having COUNT (JobTitle) > 1
Order By Count (JobTitle) DESC

11. Create a query that displays the number and name in a single column, separated by a hyphen for all products of color ‘Black’. Label the first column as Product and use the appropriate function to concatenate text.

SELECT CONCAT (ProductNumer, ‘-’, Name) AS ‘Producto’
FROM Production.Product
Where Color = Black

12. Write a query that shows the historical payments of employees with a 20% increase in 3 different formats, with the following headers “Unformatted”, “Rounded to 1 decimal place”, “Truncated to 1 decimal place”. Use the ROUND function.

SELECT BusinessEntityID, 
Rate, 
Rate*1.20 AS ‘Sin fromato’, 
ROUND (Rate*1.20, 1) AS ‘Redondeado a 1 dígito decimal’, 
ROUND (Rate*1.20,1,1) AS ‘Truncado a 1 dígito’ 
FROM  HumanResources.EmployeePayHistory

13. For each Product ID, calculate the average unit price in all orders with more than 10 units, and display it grouped by Product ID.
  
SELECT ProductID, AVG(UnitPrice) AS ‘PromedioPrecioUnitario’
FROM Sales.SalesOrderDetail
WHERE OrderQty > 10 
Group By ProductID
Order By ProductID

14. Create a report that shows all products with a unit price greater than or equal to 25 and where the average quantity ordered for that product is greater than 3. Sort by Product ID.

SELECT ProductID, AVG(OrderQty) AS ‘PromedioPrecioUnitario’
FROM Sales.SalesOrderDetail
WHERE UnitPrice >= 25 
Group By ProductID
Having AVG(OrderQty) > 3
Order By ProductID

15. Get a list of names and surnames of people named ‘Robert’, changing their name from ‘Robert’ to ‘Roberto’.

SELECT REPLACE(FirstName, 'Robert', 'Roberto') AS ‘PrimerNombre’, LastName
FROM Person.Person
WHERE PrimerNombre = 'Roberto';

16. Create a query that displays in a single column the Surname in uppercase, followed by a comma and then the name as it appears in the database for all people. Add the alias ‘Full Name’ to the column.

SELECT CONCAT (UPPER(LastName), ‘,’, FirstName) AS ‘Nombre Completo’
FROM Person.Person

17. Get the difference in years between the date of the last recorded order in the database and today’s date.

SELECT DATEDIFF(YEAR, MAX(OrderDate), GETDATE()) AS ‘Diferencia en anos’
FROM Sales.SalesOrderHeader
