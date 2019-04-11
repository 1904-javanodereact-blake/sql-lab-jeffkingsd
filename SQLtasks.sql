1.0 Setting up Oracle Chinook
In this section you will begin the process of working with the Oracle Chinook database
Task – Open the Chinook_Oracle.sql file and execute the scripts within.
[DONE]

2.0 SQL Queries
In this section you will be performing various queries against the Oracle Chinook database.

2.1 SELECT
Task – Select all records from the Employee table.
SELECT * FROM employee;

Task – Select all records from the Employee table where last name is King.
SELECT * FROM employee 
	WHERE lastname = 'King';

Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
SELECT * FROM employee 
	WHERE firstname = 'Andrew' AND reportsto IS NULL;

2.2 ORDER BY
Task – Select all albums in Album table and sort result set in descending order by title.
SELECT album FROM Album 
	ORDER BY title DESC;

Task – Select first name from Customer and sort result set in ascending order by city
SELECT firstname FROM customer 
	ORDER BY city;

2.3 INSERT INTO
Task – Insert two new records into Genre table
INSERT INTO genre (genreid, name)
	VALUES (26, 'Softcore'),
		(27, 'Mystic');
		
Task – Insert two new records into Employee table
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode, phone, fax, email)
	VALUES (9,'King', 'Jeffrey', 'Thief', NULL, TIMESTAMP '1342-12-05 00:00:00', TIMESTAMP '1990-10-08 00:00:00', '9001 Goku road', 'Pittsburgh', 'PA', 'USA', '17105', '830-544-8703', NULL, 'fishswimdive@aquamail.com'),
	(10, 'King', 'Jacob', 'Monk', NULL, TIMESTAMP '1345-06-02 00:00:00', TIMESTAMP '1990-10-08 00:00:00', '6045 Run ave', 'Pittsburgh', 'PA', 'USA', '17105', '830-319-5114', NULL, 'taco4everyone@aquamail.com');

Task – Insert two new records into Customer table
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode, phone, fax, email, supportrepid)
	VALUES (60, 'Kevin', 'Supra', NULL, '4544 Cherry st', 'Littsburgh', 'PA', 'United States', '8308', '756-660-1120','+55(12)3253-5339', 'burger@pancakemail.com', 2),
	(61, 'Bret', 'Goodboys', NULL, '4544 Good boys', 'WeRateDogs', NULL, 'United States', '8308', '756-660-1120', NULL, 'burger@pancakemail.com', 2);
	
	
2.4 UPDATE
Task – Update Aaron Mitchell in Customer table to Robert Walter
UPDATE customer SET firstname = 'Robert', lastname = 'Walter' 
	WHERE firstname = 'Aaron' AND lastname = 'Mitchell';

Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
UPDATE artist SET name = 'CCR' 
	WHERE name = 'Creedence Clearwater Revival';

2.5 LIKE
Task – Select all invoices with a billing address like “T%”
SELECT * FROM invoice 
	WHERE BillingAddress 
	LIKE 'T%';

2.6 BETWEEN
Task – Select all invoices that have a total between 15 and 50
SELECT SUM(total) FROM invoice 
	WHERE total 
	BETWEEN 15 AND 50;

Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
SELECT hiredate FROM employee 
	WHERE hiredate 
	BETWEEN TIMESTAMP '2003-06-01 00:00:00' AND TIMESTAMP '2004-03-01 00:00:00';

2.7 DELETE
Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
--Manually Deleted the child after a child to finally the parent
DELETE FROM invoiceline WHERE invoiceid IN (
	SELECT invoiceid FROM invoice WHERE customerid IN (
		SELECT customerid FROM customer 
			WHERE firstname = 'Robert' AND lastname = 'Walter'));
			
DELETE FROM invoice WHERE customerid IN (
	SELECT customerid FROM customer 
		WHERE firstname = 'Robert' AND lastname = 'Walter');
		
DELETE FROM customer 
	WHERE firstname = 'Mark' AND lastname = 'Taylor';

--DELETE CASCADE by ALTER TABLE to DROP and READD FOREIGN KEY NEW CONSTRAINT!
ALTER TABLE InvoiceLine DROP CONSTRAINT FK-InvoiceLineInvoiceId;

ALTER TABLE InvoiceLine ADD CONSTRAINT FK_InvoiceLineInvoiceId
	FOREIGN KEY (InvoiceId) 
	REFERENCES Invoice (InvoiceId) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE Invoice DROP CONSTRAINT FK_InvoiceCustomerid

ALTER TABLE Invoice ADD CONSTRAINT FK_InvoiceCustomerId
	FOREIGN KEY (CustomerId)
	REFERENCES Customer (CustomerId) ON DELETE CASCADE ON UPDATE NO ACTION;

    3.0 SQL Functions
In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
3.1 System Defined Functions
Task – Use a function that returns the current time.
SELECT CURRENT_TIMESTAMP;

Task – Use a function that returns the length of a mediatype from the mediatype table
SELECT LENGTH(name) FROM mediatype;

3.2 System Defined Aggregate Functions
Task – Use a function that returns the average total of all invoices
SELECT AVG(total) FROM invoice;

Task – Use a function that returns the most expensive track
SELECT MAX(unitprice) FROM track;
--Working on these two to find a better way to get more information out of them.
7.0 JOINS
In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.

7.1 INNER
Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
SELECT firstname, lastname, invoiceid FROM customer 
	INNER JOIN invoice
	ON customer.customerid = invoice.customerid;

7.2 OUTER
Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
SELECT firstname, lastname, invoiceid, total, customer.customeridFROM customer 
	FULL JOIN invoice
	ON customer.customerid = invoice.customerid;


7.3 RIGHT
Task – Create a right join that joins album and artist specifying artist name and title.
SELECT artist.name, titleFROM album 
	RIGHT JOIN artist
	ON album.artistID = artist.artistid;


7.4 CROSS
Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
SELECT * FROM album 
	CROSS JOIN artist
	ORDER BY artist.name;

7.5 SELF
Task – Perform a self-join on the employee table, joining on the reportsto column.
SELECT emp.employeeid, emp.firstname, emp.lastname, emp.reportsto, emps.firstname AS superfirstname,emps.lastname AS superlastname
	FROM Employee AS emp
	LEFT OUTER JOIN Employee AS emps ON emp.reportsto = emps.Employeeid
	ORDER BY reportsto;

