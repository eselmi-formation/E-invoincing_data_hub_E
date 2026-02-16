-- Create the normalized schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'normalized')
BEGIN
    EXEC('CREATE SCHEMA normalized');
END
GO

-- Create the Contact table in the normalized schema
CREATE TABLE normalized.Contact (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,  -- Unique identifier
    FirstName NVARCHAR(50) NOT NULL,          -- First name
    LastName NVARCHAR(50) NOT NULL,           -- Last name
    Email NVARCHAR(100) UNIQUE NOT NULL,      -- Email (unique)
    PhoneNumber NVARCHAR(20),                 -- Phone number
    CreatedAt DATETIME DEFAULT GETDATE(),     -- Creation timestamp
    UpdatedAt DATETIME DEFAULT GETDATE()      -- Last update timestamp
);
GO