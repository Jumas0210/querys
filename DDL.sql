create database OlSoftware

go

use OlSoftware

CREATE TABLE Merchants (
    MerchantID INT IDENTITY(1,1) PRIMARY KEY,
    BusinessName NVARCHAR(255) NOT NULL,
    City NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NULL,
    Email NVARCHAR(255) NULL,
    RegistrationDate DATETIME DEFAULT GETDATE() NOT NULL,
    Status NVARCHAR(10) CHECK (Status IN ('Active', 'Inactive')) NOT NULL,
    LastUpdated DATETIME DEFAULT GETDATE() NOT NULL,
    UpdatedByUser INT NOT NULL
);

CREATE TABLE Establishments (
    EstablishmentID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Revenue DECIMAL(10,2) NOT NULL,
    EmployeeCount INT NOT NULL,
    LastUpdated DATETIME DEFAULT GETDATE() NOT NULL,
    UpdatedByUser INT NOT NULL
);

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    RoleID INT NOT NULL
);

CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Merchant_Establishment (
    MerchantID INT NOT NULL,
    EstablishmentID INT NOT NULL,
    PRIMARY KEY (MerchantID, EstablishmentID),
    FOREIGN KEY (MerchantID) REFERENCES Merchants(MerchantID),
    FOREIGN KEY (EstablishmentID) REFERENCES Establishments(EstablishmentID)
);

go

CREATE TRIGGER trg_Merchant_Audit
ON Merchants
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE m
    SET 
        LastUpdated = GETDATE(),
        UpdatedByUser = ISNULL(i.UpdatedByUser, m.UpdatedByUser)
    FROM Merchants m
    INNER JOIN inserted i ON m.MerchantID = i.MerchantID;
END;

go

CREATE TRIGGER trg_Establishment_Audit
ON Establishments
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE e
    SET 
        LastUpdated = GETDATE(),
        UpdatedByUser = ISNULL(i.UpdatedByUser, e.UpdatedByUser)
    FROM Establishments e
    INNER JOIN inserted i ON e.EstablishmentID = i.EstablishmentID;
END;

go

CREATE PROCEDURE GetActiveMerchantsReport
AS
BEGIN
    SELECT 
        m.BusinessName, m.City, m.Phone, m.Email, 
        m.RegistrationDate, m.Status, 
        COUNT(me.EstablishmentID) AS EstablishmentCount,
        COALESCE(SUM(e.Revenue), 0) AS TotalRevenue,
        COALESCE(SUM(e.EmployeeCount), 0) AS TotalEmployees
    FROM Merchants m
    LEFT JOIN Merchant_Establishment me ON m.MerchantID = me.MerchantID
    LEFT JOIN Establishments e ON me.EstablishmentID = e.EstablishmentID
    WHERE m.Status = 'Active'
    GROUP BY m.MerchantID, m.BusinessName, m.City, m.Phone, 
             m.Email, m.RegistrationDate, m.Status
    ORDER BY EstablishmentCount DESC;
END;

ALTER TABLE Merchants ADD CONSTRAINT FK_Merchant_User
FOREIGN KEY (UpdatedByUser) REFERENCES Users(UserID);

ALTER TABLE Establishments ADD CONSTRAINT FK_Establishment_User
FOREIGN KEY (UpdatedByUser) REFERENCES Users(UserID);

ALTER TABLE Users ADD CONSTRAINT FK_User_Role
FOREIGN KEY (RoleID) REFERENCES Roles(RoleID);
