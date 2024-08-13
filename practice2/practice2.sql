1. Retrieve the ID and name of all products using as a reference: Production.Product.
  
SELECT ProductID, Name
FROM Production.Product;

2. Retrieve the ID, name, and list price of all products where the list price is greater than or equal to 100. 

SELECT ProductID, Name, ListPrice,
FROM Production.Product,
WHERE ListPrice >= 100;

3. Retrieve the ID and name of products where the list price is equal to 0 using as a reference: Production.Product.

SELECT ProductID, Name,
FROM Production.Product,
WHERE ListPrice=0;

4. Retrieve the product number, name, and list price of all products where the list price is 4.99, 9.50, or 13.99

SELECT ProductNumber, Name, ListPrice,
FROM Production.Product,
WHERE ListPrice IN (4.99, 9.50, 13.99);

5. Retrieve all data of female employees who are single. 

SELECT *,
FROM HumanResources.Employee,
WHERE MaritalStatus= ‘S’ AND Gender= ‘F’;

6. Write a query that returns the product numbers that start with 'BB'. 

SELECT ProductNumber,
FROM Production.Product,
WHERE ProductNumber LIKE ‘BB%’;

7. Additionally, retrieve the list price of the previous products, but only those with a price greater than 100.

SELECT ProductNumber, ListPrice,
FROM Production.Product,
WHERE ProductNumber LIKE ‘BB%’ AND ListPrice > 100;

8. The goal is to obtain the list of LoginID and job title of employees who are supervisors (those whose JobTitle contains the word 'Supervisor'). 

SELECT LoginID, Job Title,
FROM HumanResources.Employee,
Where JobTitle LIKE ‘% Supervisor %’;

9. Now, retrieve the same data for people who are not supervisors.

SELECT LoginID, Job Title,
FROM HumanResources.Employee,
Where JobTitle NOT LIKE ‘% Supervisor %’;

10. Retrieve the first name and last name of people whose last name starts with a vowel. 

SELECT FristName, LastName,
FROM Person.Person
WHERE LastName LIKE ‘[AEIOU%]’;

11. Now, retrieve the same data for people whose last name does not start with a vowel.
  
SELECT FristName, LastName,
FROM Person.Person
WHERE LastName LIKE ‘[^AEIOU]%’;

12. Create a query that shows the employees (LoginID) and their job title, where the login starts with the letter 'k' (Position 17). Use the table: HumanResources.Employee and column: LoginID. 

SELECT LoginID, JobTitle
FROM HumanResources.Employee
WHERE LoginID LIKE ‘-----------------K%’

13. Retrieve the data of the employees who make up 50% of the total number of employees in the company. 

SELECT TOP 50 * 
FROM HumanResources.Employee

14. The marketing department needs a list of the 15 most expensive products, ordered in descending order. 

SELECT TOP 15 ProductNumber, ListPrice, Name
FROM Production.Product
ORDER BY ListPrice DESC

15. What would the query look like if we wanted to find the 15 cheapest products that do not have a price of 0?

SELECT TOP 15 ProductNumber, ListPrice, Name
FROM Production.Product
WHERE ListPrice >= 0
ORDER BY ListPrice 

16. Retrieve all last names of people in the database.

SELECT LastName
FROM Person.Person
ORDER BY LastName

17. Now, retrieve all distinct last names of people in the database.

SELECT DISTINCT LastName
FROM Person.Person
ORDER BY LastName
  
18. Retrieve all products where the list price is between 100 and 200, and the product number starts with 'SA', ordered by list price in ascending order.

  1.SELECT *
  FROM Production.Product
  WHERE ListPrice BETWEEN 100 AND 200 AND ProductNumber LIKE ‘SA%’
  ORDER BY ListPrice

  2.SELECT *
  FROM Production.Product
  WHERE ListPrice >= 100 AND ListPrice <= 200 AND ProductNumber LIKE ‘SA%’
  ORDER BY ListPrice

19. Retrieve the data of all employees except those with vacation hours of 76, 84, 85, 86, 87, 89, or 90.

SELECT *
FROM HumanResources.Employee
WHERE VacationHours NOT IN (76,84,85,86,87,89,90)

20. Retrieve the data of employees who have 30 or 50 vacation hours.

SELECT *
FROM HumanResources.Employee
WHERE VacationHours IN (30, 50)

21. Retrieve the product name, its list price, and a new column that calculates the VAT (22%) for the product (name the column: VAT), for products whose list price is not equal to 0.

SELECT Name, ListPrice, ListPrice*1.22 AS ‘IVA’,
FROM Production.Product
WHERE ListPrice <> 0

22. Add another column to the previous query that calculates the difference between the list price and the standard cost (name the column: 'Price Difference'), and also order the results by this column in descending order.

SELECT Name, ListPrice, ListPrice*1.22 AS ‘IVA’, 
ListPrice-StandardCost AS ‘Diferencia entre precios’
FROM Production.Product
WHERE ListPrice <> 0
ORDER BY Diferencia entre precios DESC
