-- Create the bronze schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze');
END
GO

-- Create the Contact table in the bronze schema
CREATE TABLE bronze.Contact (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,  -- Unique identifier
    FirstName NVARCHAR(50) NOT NULL,          -- First name
    LastName NVARCHAR(50) NOT NULL,           -- Last name
    Email NVARCHAR(100) UNIQUE,               -- Email (unique)
    PhoneNumber NVARCHAR(20),                 -- Phone number
    CreatedAt DATETIME DEFAULT GETDATE(),     -- Creation timestamp
    UpdatedAt DATETIME DEFAULT GETDATE()      -- Last update timestamp
);
GO