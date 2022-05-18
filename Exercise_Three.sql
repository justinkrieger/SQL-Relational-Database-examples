-- Problem 1
SELECT VendorId SUM(PaymentTotal) AS PaymentSum
FROM Invoices
GROUP By VendorID;


-- Problem 2
SELECT TOP 10 VendorName, SUM(PaymentTotal) as PaymentSym
FROM Vendors
JOIN Invoices
     ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY PaymentSum DESC;


-- Problem 3
SELECT VenderName, COUNT(8) as InvoiceCount,
    SUM(InvoiceTotal) AS InvoiceSum
FROM Vendors 
JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount DESC;


-- Problem 4
SELECT VendorName, COUNT(*) AS InvoiceCount,
    SUM(InvoiceTotal) AS InvoiceSum
FROM Vendors
JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount DESC;


-- Problem 5
SELECT GLAccounts.AccountDescription, COUNT(*) as LineItemCount,
    SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts
JOIN InvoiceLineItems
    ON GLAccounts.Accountno = InvoiceLineItems.AccountNo
JOIN Invoices
    ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
WHERE InvoiceDate BETWEEN '2019-10-01' AND '2019-12-31'
GROUP BY GLAcocunts.AccountDescription
HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;


-- Problem 6
SELECT AccoubtNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
GROUP BY ROLLUP(AccountNo);


-- Problem 7
SELECT VendorName, AccountDescription, COUNT(8) AS LineItemCount,
    SUM(InvoiceLineItemAmount) AS LineItemSum
FROM Vendors
JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems
    ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
JOIN GLAccounts
    ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
GROUP BY VendorName, AccountDescription
ORDER BY VendorName, AccountDescription;


-- Problem 8
SELECT VendorName,
    COUNT(DISTINCT InvoiceLineItems.AccountNo) AS 'Number of Accounts'
FROM Vendors
JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems
    ON Invoices.InvoicesID = InvoiceLineItems.InvoicesID
GROUP BY VendorName
HAVING COUNT(DISTINCT InvoicesLineItems.AccountNo) > 1
ORDER BY VendorName;


-- Problem 9
SELECT VendorID, InvoiceDate, InvoiceTotal,
    SUM(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorTotal,
    COUNT(InvoiceTotal) OVER(PARTITION BY VendorID) AS VendorCount,
    AVG(InvoiceTotal) OVER(PARTITION BY VendorID) AS VendorAvg
FROM Invoices;


-- Problem 10
SELECT COUNT(OrderID) AS 'Number of Orders',
    SUM(TaxAmount) AS 'Total TaxAmount'
FROM Orders


-- Problem 11
SELECT CategoryName,
    COUNT(ProductName) AS 'Number of Products',
    MAX(ListPrice) AS 'Max Price'
FROM Categories
JOIN Products
    ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName
ORDER BY 'Number of Products' DESC


-- Problem 12
SELECT EmailAddress,
    SUM(ItemPrice * Quantity) AS 'Total Cost',
    SUM(DiscountAmount*Quantity) AS 'Total Discount'
FROM Orders
JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
GROUP BY EmailAddress
ORDER BY 'Total Cost' DESC;


-- Problem 13
SELECT EmailAddress, COUNT(Orders.OrderID) AS OrderCount,
    SUM((ItemPrice - DiscountAmount) * Quantity) AS 'Total Amount'
FROM Orders
JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
GROUP BY EmailAddress
HAVING COUNT(Orders.OrderID) > 1
ORDER BY 'Total Amount' DESC;


-- Problem 14
SELECT EmailAddress, COUNT(Orders.OrderID) AS OrderCount,
    SUM((ItemPrice - DiscountAmount) * Quantity) AS 'Total Amount'
FROM Orders
JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
WHERE ItemPRice > 400
GROUP BY EmailAddress
HAVING COUNT(Orders.OrderID) > 1
ORDER BY 'Total Amount' DESC;


-- Problem 15
SELECT ProductName,
    SUM((ItemPrice-DiscountAmount)*Quantity) AS TotalAmount
FROM Products
JOIN OrderItems
    ON OrderItems.ProductID = Products.ProductID
GROUP BY ROLLUP (ProductName);

-- Problem 16
SELECT EmailAddress, SUM(Quantity) AS TotalItems
FROM Orders
JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
GROUP BY EmailAddress
HAVING SUM(Quantity) > 1;
