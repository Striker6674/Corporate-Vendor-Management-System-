create database Corporate_vendor_managment_system;
use Corporate_vendor_managment_system;

CREATE TABLE Vendor (
    VendorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactDetails VARCHAR(255) NOT NULL,
    ServiceCategory VARCHAR(100),
    ComplianceCertification VARCHAR(255)
);


CREATE TABLE Contract (
    ContractID INT AUTO_INCREMENT PRIMARY KEY,
    VendorID INT NOT NULL,
    Terms TEXT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    RenewalDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID) ON DELETE CASCADE
);

ALTER TABLE contract
ADD CONSTRAINT chk_EndDate CHECK (EndDate > StartDate);



CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    AllocatedBudget DECIMAL(10, 2) NOT NULL
);


CREATE TABLE PurchaseOrder (
    POID INT AUTO_INCREMENT PRIMARY KEY,
    ContractID INT NOT NULL,
    DepartmentID INT NOT NULL,
    Items TEXT,
    TotalCost DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(50),
    FOREIGN KEY (ContractID) REFERENCES Contract(ContractID) ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE
);



CREATE TABLE Performance (
    PerformanceID INT AUTO_INCREMENT PRIMARY KEY,
    VendorID INT NOT NULL,
    Rating DECIMAL(3, 2) NOT NULL,
    Feedback TEXT,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID) ON DELETE CASCADE
);


CREATE TABLE Budget (
    BudgetID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentID INT NOT NULL,
    TotalBudget DECIMAL(10, 2) NOT NULL,
    Expenditure DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE
);


CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Role ENUM('Admin', 'Procurement Manager', 'Department Head') NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL
);


ALTER TABLE User;
ADD Password VARCHAR(255) NOT NULL AFTER Email;


UPDATE User
SET Password = 'defaultpassword'
WHERE UserID > 0; -- Ensure the condition applies to all rows

ALTER TABLE User;
MODIFY Role ENUM('Admin', 'Procurement Manager', 'Department Head', 'Vendor') NOT NULL;


CREATE TABLE Notification (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Message TEXT NOT NULL,
    IsRead BOOLEAN DEFAULT FALSE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE
);





CREATE TABLE Task (
    TaskID INT AUTO_INCREMENT PRIMARY KEY,
    AssignedTo INT NOT NULL,
    DepartmentID INT NOT NULL,
    Description TEXT NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'In Progress', 'Completed')),
    DueDate DATE,
    FOREIGN KEY (AssignedTo) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE
);





CREATE TABLE ComplianceAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    VendorID INT NOT NULL,
    AuditDate DATE NOT NULL,
    Result VARCHAR(50) NOT NULL CHECK (Result IN ('Pass', 'Fail', 'Pending')),
    Comments TEXT,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID) ON DELETE CASCADE
);





-- Insert data into Vendor table
INSERT INTO Vendor (Name, ContactDetails, ServiceCategory, ComplianceCertification)
VALUES 
('Tech Supplies Co.', '123-456-7890', 'IT Equipment', 'ISO 9001'),
('Office Essentials Ltd.', '234-567-8901', 'Office Supplies', 'ISO 14001'),
('Logistics Solutions Inc.', '345-678-9012', 'Logistics', 'ISO 45001');

-- Insert data into Department table
INSERT INTO Department (DepartmentName, AllocatedBudget)
VALUES 
('IT Department', 50000.00),
('Procurement', 75000.00),
('Logistics', 60000.00);

-- Insert data into Contract table
INSERT INTO Contract (VendorID, Terms, StartDate, EndDate, RenewalDate, Status)
VALUES 
(1, 'Annual maintenance and supply agreement.', '2024-01-01', '2024-12-31', '2024-11-30', 'Active'),
(2, 'Quarterly office supplies.', '2024-01-01', '2024-03-31', '2024-03-15', 'Active'),
(3, 'Logistics partnership agreement.', '2024-01-01', '2024-12-31', '2024-11-30', 'Active');

-- Insert data into PurchaseOrder table
INSERT INTO PurchaseOrder (ContractID, DepartmentID, Items, TotalCost, Status)
VALUES 
(1, 1, 'Desktops, Laptops', 15000.00, 'Fulfilled'),
(2, 2, 'Stationery, Paper', 3000.00, 'Pending'),
(3, 3, 'Transportation services', 20000.00, 'In Progress');

-- Insert data into Performance table
INSERT INTO Performance (VendorID, Rating, Feedback)
VALUES 
(1, 4.5, 'Reliable and prompt service.'),
(2, 4.0, 'Good quality supplies.'),
(3, 4.7, 'Efficient and timely delivery.');

-- Insert data into Budget table
INSERT INTO Budget (DepartmentID, TotalBudget, Expenditure)
VALUES 
(1, 50000.00, 20000.00),
(2, 75000.00, 3000.00),
(3, 60000.00, 20000.00);

-- Insert data into User table
INSERT INTO User (Role, Name, Email)
VALUES 
('Admin', 'John Doe', 'admin@example.com'),
('Procurement Manager', 'Jane Smith', 'jane.smith@example.com'),
('Department Head', 'Michael Johnson', 'michael.johnson@example.com');





DELIMITER //
CREATE PROCEDURE AddVendor(
    IN vendorName VARCHAR(100),
    IN contactDetails VARCHAR(255),
    IN serviceCategory VARCHAR(100),
    IN complianceCert VARCHAR(255)
)
BEGIN
    INSERT INTO Vendor (Name, ContactDetails, ServiceCategory, ComplianceCertification)
    VALUES (vendorName, contactDetails, serviceCategory, complianceCert);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddContract(
    IN vendorID INT,
    IN contractTerms TEXT,
    IN startDate DATE,
    IN endDate DATE,
    IN renewalDate DATE,
    IN status VARCHAR(50)
)
BEGIN
    INSERT INTO Contract (VendorID, Terms, StartDate, EndDate, RenewalDate, Status)
    VALUES (vendorID, contractTerms, startDate, endDate, renewalDate, Status);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddPurchaseOrder(
    IN contractID INT,
    IN departmentID INT,
    IN items TEXT,
    IN totalCost DECIMAL(10, 2),
    IN status VARCHAR(50)
)
BEGIN
    INSERT INTO PurchaseOrder (ContractID, DepartmentID, Items, TotalCost, Status)
    VALUES (contractID, departmentID, items, totalCost, status);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddPerformance(
    IN vendorID INT,
    IN rating DECIMAL(3, 2),
    IN feedback TEXT
)
BEGIN
    INSERT INTO Performance (VendorID, Rating, Feedback)
    VALUES (vendorID, rating, feedback);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddBudget(
    IN departmentID INT,
    IN totalBudget DECIMAL(10, 2),
    IN expenditure DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Budget (DepartmentID, TotalBudget, Expenditure)
    VALUES (departmentID, totalBudget, expenditure);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddUser(
    IN userRole ENUM('Admin', 'Procurement Manager', 'Department Head'),
    IN userName VARCHAR(100),
    IN userEmail VARCHAR(255)
)
BEGIN
    INSERT INTO User (Role, Name, Email)
    VALUES (userRole, userName, userEmail);
END //
DELIMITER ;





DELIMITER //
CREATE TRIGGER HashUserPasswordBeforeInsert
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
    SET NEW.Password = SHA2(NEW.Password, 256); -- Hashing the password using SHA-256
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER HashUserPasswordBeforeUpdate
BEFORE UPDATE ON User
FOR EACH ROW
BEGIN
    IF NEW.Password != OLD.Password THEN
        SET NEW.Password = SHA2(NEW.Password, 256); -- Hashing the password only if it changes
    END IF;
END //
DELIMITER ;


