-- Problem 1
SELECT * 
FROM Vendors 
JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID;


-- Problem 2
SELECT VendorName, InvoiceNumber, InvoiceDate,
    InvoiceTotal - (PaymentTotal + CreditTotal) as Balance
FROM Vendors 
JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
WHERE (InvoiceTotal - (PaymentTotal + CreditTotal)) > 0
ORDER BY VendorName;


-- Problem 3
SELECT VendorName, DefaultAccountNo, AccountDescription
FROM Vendors
JOIN GLAccounts
    ON Vendors.DefaultAccountNo = GLAccounts.AccountNo;
    
    
-- Problem 4
SELECT VendorName, InvoiceNumber, InvoiceDate,
    InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Vendors, Invoices
WHERE Vendors.VendorID = Invoices.VendorID AND
    (InvoiceTotal - (PaymentTotal + CreditTotal)) > 0
ORDER BY VendorName;


-- Problem 5
SELECT VendoName AS Vendor, InvoiceDate AS Date, InvoiceNumber AS Number,
    InvoiceSequence AS #, InvoiceLineItemAmount AS LineItem
FROM Vendors v
JOIN Invoices i
    ON v.VendorIT = i.VendorID
JOIN InvoiceLineItems li
    ON li.InvoiceID = i.InvoiceID
ORDER BY Vendor, Date, Number, (#);


-- Problem 6
SELECT DISTINCT v1.VendorID, v1.VendorName,
    v1.VendorContactFName + ' ' + v1.VendorContactLName as Name
FROM Vendors as v1 
JOIN Vendors as v2
    ON (v1.VendorID <> v2.VendorID) AND (v1.VendorContactFName = v2.VendorContactFName)
ORDER BY Name;


-- Problem 7
SELECT GLAccounts.AcountNo, AccountDescription
FROM GLAccounts
LEFT JOIN InvoiceLineItems
    ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
WHERE InvoiceLineItems.AccountNo IS NULL
ORDER BY GLAccounts.AccountNo;


-- Problem 8
    SELECT VendorName, VendorState
    FROM Vendors
    WHERE VendorState = 'CA'
UNION
    SELECT VendorName, 'Outside CA'
    FROM Vendors
    WHERE VendorState <> 'CA'
ORDER BY VendorName;


-- Problem 9
SELECT CategoryName, ProductName, ListPrice
FROM Categories
JOIN Products
    ON Categories.CategoryID = Products.CategoryID
ORDER BY CategoryName, ProductName ASC;


-- Problem 10
SELECT FirstName, LastName, Line1, City, State, ZipCode
FROM Customers
JOIN Addresses
    ON Customers.CustomerID = Addresses.CustomerID
WHERE Customers.EmailAddress = 'allan.sherwood@yahoo.com';


-- Problem 11
SELECT FirstName, LastName, Line1, City, State, Zipcode
FROM Customers
JOIN Addresses
    Customers.CustomerID = Addresses.CustomerID AND Customers.ShippingAddressID = Addresses.AddressID;
       
       
-- Problem 12
SELECT c.LastName, c.FirstName, OrderDate, p.ProductName, ItemPrice, DiscounAount, Quantity
FROM Customers c
JOIN Orders o
     ON c.CustomerID = o.CustomerID
JOIN OrderItems io
     ON o.OrderID = oi.OrderID
JOIN Products p
     ON oi.ProductID = p.ProductID
ORDER BY LastName, OrderDate, ProductName;


-- Problem 13
SELECT p1.ProductID, p1.ProductName, p1.ListPrice
FROM Products as p1
JOIN Products as p2
    ON p1.ProductID <> p2.ProductID AND p1.ListPrice = p2.ListPrice;
    
    
-- Problem 14
SELECT CategoryName, ProductID
FROM Categories LEFT
JOIN PRoducts
    ON Categories.CateogryID = Products.CategoryID
WHERE ProductID IS NULL;
    
    
-- Problem 15
    SELECT 'SHIPPPED' as ShipStatus, OrderID, OrderDate
    FROM Orders
    WHERE ShipNate IS NOT NULL
UNION
    SELECT 'NOT SHIPPED' as ShipStatus, OrderID, OrderDate
    FROM Orders
    WHERE ShipDate IS NULL
ORDER BY OrderDate
