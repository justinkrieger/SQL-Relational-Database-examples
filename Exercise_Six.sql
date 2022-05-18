-- Problem 1
SELECT *
INTO VendorCopy
FROM Vendors

SELECT *
INTO InvoiceCopy
FROM Invoices;


-- Problem 2
INSERT INTO InvoiceCopy
VALUES (, 'AX-014-027', '2020-04-21', 434.58, 0, 0, 2, '2020-05-08', NULL);


-- Problem 3
INSERT INTO VendorCopy
SELECT VendorName, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZipCode,
    VendorPhone, VendorContactLName, VendorContactFName, DefaultTermsID, DefaultAccountNo
FROM Vendors
WHERE VendorState <> 'CA';


-- Problem 4
UPDATE VendorCopy
SET DefaultAccountNo = 403
WHERE DefaultAccountNo = 400;


-- Problem 5
UPDATE InvoiceCopy
SET PaymentDate = GETDATE(),
    PaymentTotal = InvoiceTotal - CreditTotal
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;


-- Problem 6
UPDATE InvoiceCopy
SET TermsID = 2
WHERE VendorID in (
    SELECT VendorID
    FROM VendorCopy
    WHERE DefaultTermsID = 2);
    
    
-- Problem 7
UPDATE InvoiceCopy
SET TermsID = 2
FROM InvoiceCopy
JOIN VendorCopy
    ON InvoiceCopy.VendorID = VendorCopy.VendorID
WHERE DefaultTermsID = 2;


-- Problem 8
DELETE VendorCopy
WHERE VendorCopy.VendorState = 'MN';


-- Problem 9
DELETE VendorCopy
WHERE VendorState NOT IN (
    SELECT DISTINCT VendorState
    FROM VendorCopy
    JOIN InvoiceCopy
        On VendorCopy.VendorID = InvoiceCopy.VendorID);


-- Problem 10
SELECT CAST(InvoiceTotal AS DECIMAL(17,2)) AS CastAsDecimal,
    CAST(InvoiceTotal AS VARCHAR) AS CastAsVarChar,
    CONVERT(DECIMAL(17,2), InvoiceTotal) AS ConvertToDecimal,
    CONVERT(VARCHAR, InvoiceTotal, 1) AS ConvertToVarChar
FROM Invoices;


-- Problem 11
SELECT CAST(InvoiceDate AS VARCHAR) AS CastAsVarChar,
    CONVERT(VARCHAR, InvoiceDate, 1) AS ConvertToVarchar1,
    CONVERT(VARCHAR, InvoiceDate, 10) AS ConvertToVarChar10
FROM Invoices;


-- Problem 12
INSERT INTO Categories
VALUES ('Brass');


-- Problem 13
UPDATE Categories
SET CategoryName = 'Woodwinds'
WHERE CategoryID = 5;


-- Problem 14
DELETE Categories
WHERE CategoryID = 5;


-- Problem 15
INSERT INTO Products
VALUES(4 'dgx_640', 'Yamaha DGX 88-key Digital Piano', 'Long description to come', 799.99, 0, GETDATE());


-- Problem 16
UPDATE Products
SET DiscountPercent = 35
WHERE ProductID = 11;


-- Problem 17
DELETE Products
WHERE CategoryID = 4;

DELETE Categories
WHERE CategoryID = 4;


-- Problem 18
INSERT INTO Customers
VALUES('rick@raven.com', '', 'Rick', 'Raven', NULL, NULL);


-- Problem 19
UPDATE Customers
SET Password = 'secret'
WHERE EmailAddress = 'rick@raven.com';


-- Problem 20
UPDATE Customers
SET Password='reset'


-- Problem 21
SELECt CAST(ListPrice AS DECIMAL(17,1)) AS CastAsDecimal,
    CONVERT(INT, ListPrice, 1) as ConvertToInt,
    CAST(ListPrice AS INT) AS CastAsInt
FROM Products


-- Problem 22
SELECT Cast(DateAdded AS DATE) AS CastAsDateYYYYMMDD,
    CAST(DateAdded AS datetime) AS CastAsDateTime,
    FORMAT(CAst(DateAdded AS DATE), 'MM/dd') AS CastAsDateMMdd
FROM Products


-- Problem 23
SELECT CONVERT(VARCHAR, OrderDate, 101) AS ConvertToMMddYYYY,
    CONVERT(VARCHAR, OrderDate, 0) AS ConvertToNormalTime,
    CONVART(VARCHAR, OrderDate, 14) AS ConvertToFulltime
FROM Orders
