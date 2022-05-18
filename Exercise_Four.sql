-- Problem 1
SELECT VendorName
FROM Vendors
WHERE VendorID IN (
    SELECT VendorID FROM Invoices)
ORDER BY VendorName;


-- Problem 2
SELECT InvoiceNumber, InvoiceTotal
FROM Invoices
WHERE PaymentTotal > (
    SELECT AVG(PaymentTotal)
    FROM Invoices
    WHERE PaymentTotal <> 0);
    
    
-- Problem 3
SELECT InvoiceNumber, InvoiceTotal
FROM Invoices
WHERE PaymentTotal > ALL (
    SELECT TOP 50 PERCENT PaymentTotal
    FROM Invoices
    WHERE PaymentTotal <> 0
    ORDER BY PaymentTotal);
    
    
-- Problem 4
SELECT AccountNo, AccountDescription
FROM GLAccounts
WHERE NOT EXISTS (
    SELECT *
    FROM InvoiceLineItems
    WHERE InvoiceLineItems.AccountNo = GLAccounts.AccountNo)
ORDER BY AccountNo;


-- Problem 5
SELECT VendorName, Invoice.InvoiceID, InvoiceSequence, InvoiceLineItemAmount
FROM Invoices
    JOIN Vendors
        ON Invoices.VendorID = Vendors.VendorID
    JOIN InvoiceLineItems
        ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
WHERE Invoices.InvoiceID IN (
    SELECT InvoiceID
    FROM InvoiceLineItems
    WHERE InvoiceSequence > 1)
ORDER BY VendorName, Invoices.InvoiceID, InvoiceSequence;


-- Problem 6
SELECT SUM(InvoiceMax) AS SumOfMaximum
FROM (
    SELECT VendorID, MAX(Invoicetotal) AS InvoiceMax
    FROM Invoices
    WHERE (InvoiceTotal + CreditTotal - Payment) > 0
    GROUP BY VendorID) AS MaxInvoice;
    

-- Problem 7
SELECT VendorName, VendorCity, VendorState
FROM Vendors as VendorsMain
WHERE VendorCity + VendorState NOT IN (
    SELECT VendorCity + VendorState
    FROM Vendors as VendorsSub
    WHERE VendorSub.VendorID <> VendorsMain.VendorID)
ORDER BY VendorState, VendorCity;


-- Problem 8
SELECT VendorName, InvoiceNumber AS FirstInv,
    InvoiceDate, InvoiceTotal
FROM Invoice as InvoiceMain
    JOIN Vendors
        ON InvoiceMain.VendorID = Vendors.VendorID
WHERE InvoiceDate = (
    SELECT MIN(InvoiceDate)
    FROM Invoice as InvoiceSub
    WHERE InvoiceSub.VendorID = InvoiceMain.VendorID)
ORDER BY VendorName;


-- Problem 9
WITH MaxInvoice AS (
    SELECT VendorID, MAX(InvoiceTotal) AS InvoiceMax
    FROM Invoices
    WHERE InvoiceTotal - CreditTotal - Payment > 0
    GROUP BY VendorID)
SELECT SUM(InvoiceMax) AS SumOfMaximums
FROM MaxInvoice;


-- Problem 10
SELECT DISTINCT CategoryName
FROM Categories
WHERE CategoryID IN (
    SELECT CategoryID FROM Products)
ORDER BY CategoryName;


-- Problem 11
SELECT ProductName, ListPrice
FROM Products
WHERE ListPrice > (
    SELECT AVG(ListPrice)
    FROM Products)
ORDER BY 2 DESC;


-- Problem 12
SELECT CategoryName
FROM Categories AS Cat
WHERE NOt EXISTS (
    SELECT *
    FROM Products AS Pro
    WHERE Pro.CategoryID = Cat.CategoryID);
    
    
-- Problem 13
SELECT Cust.EmailAddress, OrdIt.OrderID,
    SUM(OrdIT.ItemPrice - OrdIt.DiscountAmount + Ord.ShipAmount + Ord.TaxAmount) * OrdIt.Quantity) AS OrderTotal
FROM OrderItems OrdIt
    JOIN Orders Ord
        ON OrdIt.OrderID = Ord.OrderID
    JOIN Customers Cust
        ON Ord.CustomerID = Cust.CustomerID
GROUP BY Cust.EmailAddress, OrdIt.OrderID
ORDER BY Cust.EmailAddress;


-- Problem 14
SELECT OrderTotals.EmailAddress, MAX(OrderTotals.OrderTotal) AS LargestOrder
FROM (
    SELECT Cust.EmailAddress, OrdIt.OrderID,
        SUM((OrdIt.ItemPrice - OrdIt.DiscountAmount + Ord.ShipAmount + Ord.TaxAmount) * OrdIt.Quantity) AS OrderTotal
        FROM OrderItems OrdIt
            JOIN Orders Ord
                ON OrdIt.OrderID = Ord.OrderID
            JOIN Customers Cust
                ON Ord.CustomerID = Cust.CustomerID
        GROUP BY Cust.EmailAddress, OrdIt.OrderID) AS OrderTotals
GROUP BY OrderTotals.EmailAddress


-- Problem 15
SELECT ProdMain.ProductName, ProdMain.DiscountPercent
FROM Products ProdMain
WHERE NOT EXISTS (
    SELECT *
    FROM Products ProdSub
    WHERE ProdSub.DiscountPercent = ProdMain.DiscountPercent
        AND ProdSub.ProductName <> ProdMain.ProductName)
ORDER BY ProdMain.ProductName;


-- Problem 16
SELECT Cust.EmailAddress, OrdMain.OrderID, OrdOld.OldestDate
FROM Customers Cust
    JOIN (
        SELECT OrdSub.CustomerID, MIN(OrdSub.OrderDate) AS OldestDate
        FROM Orders OrdSub
        GROUP BY OrdSub.CustomerID) AS OrdOld
    JOIN Orders OrdMain
        ON OrdOld.OldestDate = OrdMain.OrderDate
