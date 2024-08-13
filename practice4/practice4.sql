1. Get the Person ID and the name of all people who are managers.
  
SELECT EM.BusinessEntityID, PP.FirstName, PP.LastName, EM.JobTitle
FROM HumanResources.Employee AS EP
JOIN Person.Person AS PP
ON EP.BusinessEntityID = PP.BusinessEntityID
WHERE EM.JobTitle LIKE ‘CHIEF&’


2. Get the Person ID, the name of each person, and their email address.

SELECT EA.BusinessEntityID, PP.FirstName, PP.LastName, EA.EmailAddress
FROM Person.EmailAddress AS EA
JOIN Person.Person AS PP
ON EA.BusinessEntityID = PP.BusinessEntityID


3. Get the Person ID, the name of each person, and their phone number for each person whose last name starts with ‘J’.

SELECT PP.BusinessEntityID, PP.FirstName. PP.LastName, PH.PhoneNumber
FROM Person.Person AS PP
JOIN Person.PersonPhone AS PH
ON PP.BusinessEntityID = PH.BusinessEntityID
WHERE PP.LastName LIKE ‘J%’


4. Get the Product ID, the product name, and the subcategory description of each product that is RED, BLUE, or BLACK, only for products that HAVE A SUBCATEGORY.
SELECT PP.ProductID,
PP.Name AS ‘Nombre del Producto’
PS.Name AS ‘’Descripción de la Subcategoria,
FROM Production.Product AS PP
JOIN Production.ProductSubcategory AS PS
ON PP.ProductSubcategory = PS.ProductSubcategory
WHERE PP.Color IN (‘RED’,’BLUE’,’BLACK’)


5. Get the Product ID, the product name, and the subcategory description for ALL PRODUCTS.
  
SELECT PP.ProductID,
PP.Name AS ‘Nombre del Producto’
PS.Name AS ‘’Descripción de la Subcategoria,
FROM Production.Product AS PP
LEFT JOIN Production.ProductSubcategory AS PS
ON PP.ProductSubcategory = PS.ProductSubcategory


6. Get a list showing the Customer ID, Store ID, and the name of the store (concatenated in a single field) for all customers.
  
SELECT CONCAT (C.CustomerID, ‘,’, C.StoreID, ‘,’, S.Name)
FROM Sales.Customer AS C
JOIN Sales.Store AS S
ON C.StoreID= S.BusinessEntityID


7. Get a list of all customers that includes: the Customer ID and the name of each territory where each customer made a purchase.
  
SELECT SOH.CustomerID, ST.Name AS Territory
FROM SALES.SalesOrderHeader AS SOH
JOIN sales.SalesTerritory AS ST
ON SOH.TerritoryID = ST.TerritoryID


8. Group the previous report and show the number of customers in each territory, ordered from highest to lowest.
  
SELECT ST.Name AS Territory, COUNT(SOH.CustomerID) As CantDeClientes
FROM SALES.SalesOrderHeader AS SOH
JOIN sales.SalesTerritory AS ST
ON SOH.TerritoryID = ST.TerritoryID
GROUP BY ST.Name
ORDER BY CantDeClientes DESC


9. Get a list showing the Customer ID, the store name, and the territory name for customers.
  
SELECT SC.CustomerID, SS.Name AS NombreTerritorio, ST.Name NombreTienda
FROM Sales.Customer AS SC
JOIN Sales.Store AS SS
ON SS.BusinessEntityID = SC.StoreID
JOIN Sales.SalesTerritory AS ST
ON ST.TerritoryID = SC.TerritoryID


10. The management of AdventureWorks wants to learn more about their customers and would like to contact each one via email or phone to conduct a short survey. Your task is to create a list that enables this type of action. The main tasks in this exercise are: 

• Identify which table contains this information
  
-Sales.Customer
-Person.Person
-Person.EmailAdress
-Person.PersonPhone

• Choose the fields that contain the desired information
  
-Person.Person [FirstName]
-Person.Person [LastName]
-Person.EmailAdress [EmailAdress]
-Person.PersonPhone [PhoneNumber]

• Generate a query using the SELECT, FROM, and appropriate JOIN commands
  
SELECT SC.CustomerID, PP.FirstName, PP.LastName, EA.EmailAdress, PH.PhoneNumber
FROM SalesCustomer as SC
JOIN Person.Person AS PP
ON PP.BusinessEntityID = SC.PersonID
JOIN PersonEmailAdress AS EA
ON P.BusinessEntityID = EA.BusinessEntity ID
JOIN Person.PersonPhone AS PH
ON P.BusinessentityID = PH.BusinessEntityID

11. Get the name, surname, and credit card number of all people in the database. Note: The report should include all people (whether they have a card or not).
  
• Which tables are involved in the report? 

-Person.Person
-Sales.PersonCreditCard
-Sales.CreditCard

• Generate the report using an SQL query

SELECT PP.FirstName, PP.LastName, CC.CardNumber
FROM Person.Person AS PP
LEFT Join Sales.PersonCreditCard AS PCC
ON SC.PersonID = CC.BusinessEntityID
LEFT Join Sales.CreditCard AS CC
ON PCC.CreditCardID = CC.CreditCardID


• How would it be if you wanted to set a zero (0) as the credit card number for people who DO NOT HAVE a card?
  
SELECT PP.FirstName, PP.LastName, 
ISNULL(CC.CardNumber, 0) AS CardNumber
FROM Person.Person AS PP
LEFT JOIN Sales.PersonCreditCard AS PCC
ON PP.BusinessEntityID = PCC.BusinessEntityID
LEFT JOIN Sales.CreditCard AS CC
ON PCC.CreditCardID = CC.CreditCardID;
