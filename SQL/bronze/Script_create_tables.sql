/*==============================================================*/
/* Schema : ref                                                 */
/*==============================================================*/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'ref')
BEGIN
    EXEC('CREATE SCHEMA [ref]')
END
GO
/*==============================================================*/
/* Table : rf_seller                                            */
/*==============================================================*/

-- Table Creation

CREATE TABLE [ref].[rf_seller] (
    [seller_id]                             [int] IDENTITY(1,1) NOT NULL,
    [seller_internal_id]                    [bigint]            NOT NULL, 
    [seller_name]                           [nvarchar](240)     NOT NULL,
    [seller_short_name]                     [nvarchar](150)     NULL,
    [seller_email]                          [nvarchar](255)     NULL,
    [legal_entity_id]                       [bigint]            NOT NULL,
    [legal_entity_name]                     [nvarchar](240)     NOT NULL, 
    [legal_entity_commercial_name]          [nvarchar](240)     NULL,     
    [legal_entity_alternate_registered_name][nvarchar](240)     NULL,     
    [legal_entity_ledger_id]                [bigint]            NULL,
    [legal_entity_ledger_name]              [nvarchar](100)     NULL,
    [legal_entity_business_registration_number] [nvarchar](50)  NULL,    
    [establishment_registration_number]     [nvarchar](50)      NULL,     
    [tax_registration_number]               [nvarchar](50)      NULL,     
    [legal_entity_accounting_segment1]       [nvarchar](20)      NULL,     
    [seller_address]                        [nvarchar](500)     NULL,
	[seller_address1]                       [nvarchar](500)     NULL,
    [seller_address2]                       [nvarchar](500)     NULL,
    [seller_address3]                       [nvarchar](500)     NULL,
    [seller_address4]                       [nvarchar](500)     NULL,
    [seller_city]                           [nvarchar](100)     NULL,
    [seller_postal_code]                    [nvarchar](60)      NULL,
    [seller_state]                          [nvarchar](60)      NULL,
    [seller_province]                       [nvarchar](60)      NULL,
    [seller_county]                         [nvarchar](100)     NULL,
    [seller_country_code]                   [nvarchar](60)      NULL,
    [effective_start_date]                  [datetime2]         NULL,
    [effective_end_date]                    [datetime2]         NULL,
    [is_active]                             [char](1)           NOT NULL, 
    [source_last_update_date]               [datetime2]         NULL,    
    [insert_date]                           [datetime2]         NOT NULL CONSTRAINT DF_rf_seller_created DEFAULT GETDATE(),
    [update_date]                           [datetime2]         NULL      
) ON [PRIMARY]
GO

-- Add Primary Key Constraint
ALTER TABLE [ref].[rf_seller]
    ADD CONSTRAINT PK_rf_seller PRIMARY KEY CLUSTERED (seller_id)
    ON [PRIMARY]
GO

-- Add Unique Constraint on Oracle Internal ID
ALTER TABLE [ref].[rf_seller]
    ADD CONSTRAINT UK_rf_seller_internal_id UNIQUE NONCLUSTERED (seller_internal_id)
    ON [PRIMARY]
GO

-- Performance Index for Talend lookups and application searches
CREATE INDEX IX_rf_seller_active ON [ref].[rf_seller] (is_active) 
ON [PRIMARY]
GO

/*==============================================================*/
/* Table : rf_seller_bank_account                               */
/*==============================================================*/
CREATE TABLE [ref].[rf_seller_bank_account] (
    -- Identification
    [seller_bank_account_id]            [bigint] IDENTITY(1,1) NOT NULL,
    [seller_internal_id]                [bigint]               NOT NULL,
    [seller_name]                       [nvarchar](240)        NULL,

    -- Bank Details
    [bank_name]                         [nvarchar](360)        NULL,
    [bank_country_code]                 [nvarchar](60)         NULL,
    [bank_branch_name]                  [nvarchar](360)        NULL,
    [bank_branch_number]                [nvarchar](30)         NULL,
    [bank_bic_code]                     [nvarchar](30)         NULL,

    -- Bank Account Details
    [bank_iban_number]                  [nvarchar](50)         NULL,
    [bank_account_name]                 [nvarchar](360)        NULL,
    [bank_account_name_alternative]     [nvarchar](360)        NULL,
    [bank_receipt_method]               [nvarchar](100)        NULL,

    -- Accounting
    [asset_account]                     [nvarchar](500)        NULL,
    [accounting_segment5_bank_activity]   [nvarchar](25)         NULL,

    -- Flags
    [is_enabled_for_billing]            [char](1)              NULL,
    [is_enabled_for_ap]                 [char](1)              NULL,
    [is_enabled_for_ar]                 [char](1)              NULL,

    -- Validity Dates
    [bank_start_date]                   [datetime]            NULL,
    [bank_end_date]                     [datetime]            NULL,
    [bank_account_start_date]           [datetime]            NULL,
    [bank_account_end_date]             [datetime]            NULL,
    [is_active]                         [char](1)              NULL,
    [source_last_update_date]               [datetime]         NULL,
	[insert_date]                       [datetime]            NOT NULL CONSTRAINT DF_rf_seller_bank_acc_ins DEFAULT GETDATE(),
    [update_date]                       [datetime]            NULL
) ON [PRIMARY]
GO

-- Add Primary Key Constraint
ALTER TABLE [ref].[rf_seller_bank_account]
    ADD CONSTRAINT PK_rf_seller_bank_account PRIMARY KEY CLUSTERED (seller_bank_account_id)
    ON [PRIMARY]
GO

-- Add Index for Performance (Targeting Active Status)
CREATE NONCLUSTERED INDEX IX_rf_seller_bank_account_active 
    ON [ref].[rf_seller_bank_account] (is_active) 
    ON [PRIMARY]
GO
