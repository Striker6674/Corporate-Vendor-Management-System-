
create database Corporate_vendor_managment_system;
use Corporate_vendor_managment_system;
-- Corrected ALTER TABLE statements
ALTER TABLE User
ADD Password VARCHAR(255) NOT NULL AFTER Email;

UPDATE User
SET Password = 'defaultpassword'
WHERE UserID > 0;

ALTER TABLE User
MODIFY Role ENUM('Admin', 'Procurement Manager', 'Department Head', 'Vendor') NOT NULL;

-- Create Triggers after modifying the table
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

-- Insert data into User table with Passwords
INSERT INTO User (Role, Name, Email, Password)
VALUES 
('Admin', 'John Doe', 'admin@example.com', 'adminpassword'),
('Procurement Manager', 'Jane Smith', 'jane.smith@example.com', 'procurepass'),
('Department Head', 'Michael Johnson', 'michael.johnson@example.com', 'deptheadpass');

-- Insert Vendor Users
INSERT INTO User (Role, Name, Email, Password)
VALUES
('Vendor', 'Alice Vendor', 'alice@techsuppliesco.com', 'vendorpass1'),
('Vendor', 'Bob Vendor', 'bob@officeessentials.com', 'vendorpass2'),
('Vendor', 'Charlie Vendor', 'charlie@logisticsolutions.com', 'vendorpass3');

-- Insert data into Notification table
INSERT INTO Notification (UserID, Message, IsRead)
VALUES
(1, 'Contract #1 is due for renewal in 30 days.', FALSE),
(2, 'Purchase Order #2 has exceeded the allocated budget.', FALSE),
(3, 'Vendor #3 has submitted a new compliance certification.', FALSE);

-- Insert data into Task table
INSERT INTO Task (AssignedTo, DepartmentID, Description, Status, DueDate)
VALUES
(2, 2, 'Review and approve Purchase Order #2.', 'Pending', '2024-05-01'),
(3, 3, 'Schedule compliance audit for Vendor #1.', 'In Progress', '2024-04-15'),
(1, 1, 'Update contract terms for Vendor #2.', 'Pending', '2024-06-01');

-- Insert data into ComplianceAudit table
INSERT INTO ComplianceAudit (VendorID, AuditDate, Result, Comments)
VALUES
(1, '2024-03-15', 'Pass', 'Vendor meets all compliance requirements.'),
(2, '2024-03-20', 'Pending', 'Awaiting documentation for ISO certification renewal.'),
(3, '2024-03-10', 'Fail', 'Vendor failed to provide necessary safety certifications.');
