-- ---------------------------------------
-- Question 1: Achieving 1NF (First Normal Form)
-- ---------------------------------------

-- Original Table (violates 1NF)
-- OrderID | CustomerName | Products
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone

-- Transform into 1NF: Each product in a separate row

-- Create the normalized ProductDetail_1NF table
DROP TABLE IF EXISTS ProductDetail_1NF;
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert normalized data (1 product per row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- ---------------------------------------
-- Question 2: Achieving 2NF (Second Normal Form)
-- ---------------------------------------

-- Original Table (1NF, but violates 2NF due to partial dependency)
-- OrderID | CustomerName | Product | Quantity

-- Step 1: Create Orders table to store OrderID and CustomerName (removing partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert unique orders with customer names
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 2: Create OrderDetails table with full dependency on (OrderID, Product)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product order details (no partial dependency)
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
