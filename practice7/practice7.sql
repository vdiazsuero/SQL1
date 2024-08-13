1.Create a query that returns First Name and Last Name (in the same field, separated by commas), Phone, and Phone Type; also generate a column, to be used for a new promotion, named ‘Contact Type’ for each person. Sort by Contact Type and Name.

Contact types are classified as follows:

Those with Phone Type equal to ‘Work’ and no numbers in the USA (starting with 1 (11)) -> Email
Those with Phone Type equal to ‘Home’ and no numbers in the USA -> International Call
If the phone number starts with 5 -> Local Call Group 1
If the phone number starts with 8 -> Local Call Group 2
References: Person.Person, Person.PersonPhone, Person.PhoneNumberType
  
SELECT CONCAT (PP.LastName, ‘, ’,PP.FirstName ) AS ‘Nombre de Contacto’,
	PH.PhoneNumber,
	PNT.Name,
CASE
WHEN THEN PhoneNumber NOT LIKE ‘1 (11%)’ AND PNT.Name = ‘Work’ THEN ‘email’ 
WHEN THEN PhoneNumber LIKE ‘1 (11%)’ AND PNT.Name = ‘Home’ THEN ‘Internacional’
WHEN THEN PhoneNumber LIKE ‘5%’ AND THEN ‘G1’ 
WHEN THEN PhoneNumber LIKE ‘8%’ AND THEN ‘G2’ 
	END AS ‘Tipo de Contacto’ 
FROM Person.Person AS PP
JOIN Person.PersonPhone AS PH
ON PP.BusinessEntityID = PH.BusinessEntityID
JOIN Person.PhoneNumberType AS PNT
ON PH.PhoneNumberTypeID = PNT.PhoneNumberTypeID
ORDER BY ‘Tipo de Contacto’,  ‘Nombre de Contacto’

2.Create a query that shows the employee's name, their vacation hours, and an increase in vacation hours of 15% for those with less than 50 hours, 10% for those with between 50 and 70 hours, and 5% for the rest.

3.Report the number of male and female employees (in a single row).

4.HR wants to know the employees who are paid monthly (PayFrequency 1) or bi-weekly (PayFrequency 2). Generate a report with Name, Last Name, Job Title, and a new column specifying “Monthly” or “Bi-weekly”.

5.Generate a report listing the prices of products categorized into three bands for applying discounts. The bands and discounts are: For products with Price 0, No Discount; for products up to 200, Low Price with a 10% discount; for products priced between 200 and 500, Medium Price with a 20% discount; and for the rest, High Price with a 40% discount. The report should show the product name, current list price, list price with discount applied, and the band to which it belongs, ordered by list price.

6.The top management is considering moving the stores in France and Germany to Spain and Portugal. Generate a report showing the number of customers affected if this happens. The report should include the number of customers by territory. For the stores being relocated, indicate the new locations.

7.Generate a report showing the name, last name, gender, and marital status of all employees. For the last two fields, the full words should appear, not abbreviated as stored in the database.

8.Generate a report showing the quantity of products sold quarterly in the year 2003.
 
