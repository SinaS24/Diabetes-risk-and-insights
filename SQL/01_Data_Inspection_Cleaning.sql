-- Preview data
SELECT TOP 5 * FROM [Diabetes Diagnosis];

-- Check total number of rows
SELECT COUNT(*) AS Total_Rows FROM [Diabetes Diagnosis];

-- Table structure and data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Diabetes Diagnosis';

-- Check for missing data 
SELECT 
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Null_Age,
    SUM(CASE WHEN BMI IS NULL THEN 1 ELSE 0 END) AS Null_BMI,
    SUM(CASE WHEN Glucose IS NULL THEN 1 ELSE 0 END) AS Null_Glucose,
    SUM(CASE WHEN BloodPressure IS NULL THEN 1 ELSE 0 END) AS Null_BloodPressure,
    SUM(CASE WHEN HbA1c IS NULL THEN 1 ELSE 0 END) AS Null_HbA1c,
    SUM(CASE WHEN LDL IS NULL THEN 1 ELSE 0 END) AS Null_LDL,
    SUM(CASE WHEN HDL IS NULL THEN 1 ELSE 0 END) AS Null_HDL,
    SUM(CASE WHEN Triglycerides IS NULL THEN 1 ELSE 0 END) AS Null_Triglycerides,
    SUM(CASE WHEN WaistCircumference IS NULL THEN 1 ELSE 0 END) AS Null_WaistCircumference,
    SUM(CASE WHEN HipCircumference IS NULL THEN 1 ELSE 0 END) AS Null_HipCircumference,
    SUM(CASE WHEN WHR IS NULL THEN 1 ELSE 0 END) AS Null_WHR,
    SUM(CASE WHEN FamilyHistory IS NULL THEN 1 ELSE 0 END) AS Null_FamilyHistory,
    SUM(CASE WHEN DietType IS NULL THEN 1 ELSE 0 END) AS Null_DietType,
    SUM(CASE WHEN Hypertension IS NULL THEN 1 ELSE 0 END) AS Null_Hypertension,
    SUM(CASE WHEN MedicationUse IS NULL THEN 1 ELSE 0 END) AS Null_MedicationUse,
    SUM(CASE WHEN Outcome IS NULL THEN 1 ELSE 0 END) AS Null_Outcome
FROM [Diabetes Diagnosis];

-- Update boolean columns data types to BIT

ALTER TABLE [Diabetes Diagnosis] ALTER COLUMN FamilyHistory BIT;
ALTER TABLE [Diabetes Diagnosis]ALTER COLUMN Hypertension BIT;
ALTER TABLE [Diabetes Diagnosis]ALTER COLUMN MedicationUse BIT;
ALTER TABLE [Diabetes Diagnosis]ALTER COLUMN Outcome BIT;

-- Check pregnancy distribution as the numbers seem unsually high
-- SELECT 
--    Pregnancies, COUNT(*) AS Count
-- FROM [Diabetes Diagnosis]
-- GROUP BY Pregnancies
-- ORDER BY Pregnancies DESC;

-- Checking pregnancy correlation with age to troubleshoot
-- SELECT 
--    Pregnancies, 
--    AVG(Age) AS Avg_Age,
--    COUNT(*) AS Count
-- FROM [Diabetes Diagnosis]
-- GROUP BY Pregnancies
-- ORDER BY Pregnancies DESC;

-- Check diabetes propotions per pregnancy count
-- SELECT Pregnancies,
--       COUNT(*) AS Total_People,
--       SUM(CASE WHEN Outcome = 1 THEN 1 ELSE 0 END) AS Diabetes_Count,
--       ROUND(100.0 * SUM(CASE WHEN Outcome = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Diabetes_Percentage
-- FROM [Diabetes Diagnosis]
-- GROUP BY Pregnancies
-- ORDER BY Pregnancies DESC;

-- Remove pregnancy column (Determined that the pregnancy count is an error)
-- ALTER TABLE [Diabetes Diagnosis]
-- DROP COLUMN Pregnancies;

-- Create Age Groups 
-- ALTER TABLE [Diabetes Diagnosis] ADD Age_Group NVARCHAR(50);
UPDATE [Diabetes Diagnosis]
SET Age_Group = CASE 
    WHEN Age < 20 THEN 'Teen'
    WHEN Age BETWEEN 20 AND 39 THEN 'Young Adult'
    WHEN Age BETWEEN 40 AND 59 THEN 'Middle Aged'
    ELSE 'Senior'
END;

SELECT Age_Group FROM [Diabetes Diagnosis] 