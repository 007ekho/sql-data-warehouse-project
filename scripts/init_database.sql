
/* =========================================================
   DATA WAREHOUSE INITIAL SETUP SCRIPT
   Author: Success Ekhosuehi
   Purpose: Create standard medallion architecture schemas
            in a reusable, safe way.
========================================================= */


/* =========================================================
   1. USE DATABASE
   ---------------------------------------------------------
   Make sure we are working inside the correct database.
========================================================= */

USE datawarehouse;
GO


/* =========================================================
   2. CREATE SCHEMAS (BRONZE / SILVER / GOLD)
   ---------------------------------------------------------
   Pattern:
   - BRONZE = raw ingested data
   - SILVER = cleaned / transformed data
   - GOLD   = business-ready / analytics layer

   NOTE:
   We use IF NOT EXISTS so script is SAFE to rerun.
========================================================= */

-- Create BRONZE schema (raw data layer)
IF NOT EXISTS (
    SELECT 1 FROM sys.schemas WHERE name = 'bronze'
)
BEGIN
    EXEC('CREATE SCHEMA bronze');
END
GO


-- Create SILVER schema (cleaned / transformed layer)
IF NOT EXISTS (
    SELECT 1 FROM sys.schemas WHERE name = 'silver'
)
BEGIN
    EXEC('CREATE SCHEMA silver');
END
GO


-- Create GOLD schema (analytics / reporting layer)
IF NOT EXISTS (
    SELECT 1 FROM sys.schemas WHERE name = 'gold'
)
BEGIN
    EXEC('CREATE SCHEMA gold');
END
GO


/* =========================================================
   3. VERIFY RESULT
   ---------------------------------------------------------
   Quick check to confirm schemas exist
========================================================= */

SELECT name AS schema_name
FROM sys.schemas
WHERE name IN ('bronze', 'silver', 'gold');
GO
