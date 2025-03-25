-- Check for outliers and distributions
SELECT 
    'BMI' AS Metric, 
    MIN(BMI) AS Min_Value, 
    MAX(BMI) AS Max_Value, 
    AVG(BMI) AS Avg_Value, 
    STDEV(BMI) AS StdDev_Value
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'Glucose', MIN(Glucose), MAX(Glucose), AVG(Glucose), STDEV(Glucose)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'BloodPressure', MIN(BloodPressure), MAX(BloodPressure), AVG(BloodPressure), STDEV(BloodPressure)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'HbA1c', MIN(HbA1c), MAX(HbA1c), AVG(HbA1c), STDEV(HbA1c)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'LDL', MIN(LDL), MAX(LDL), AVG(LDL), STDEV(LDL)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'HDL', MIN(HDL), MAX(HDL), AVG(HDL), STDEV(HDL)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'Triglycerides', MIN(Triglycerides), MAX(Triglycerides), AVG(Triglycerides), STDEV(Triglycerides)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'WaistCircumference', MIN(WaistCircumference), MAX(WaistCircumference), AVG(WaistCircumference), STDEV(WaistCircumference)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'HipCircumference', MIN(HipCircumference), MAX(HipCircumference), AVG(HipCircumference), STDEV(HipCircumference)
FROM [Diabetes Diagnosis]
UNION ALL
SELECT 
    'WHR', MIN(WHR), MAX(WHR), AVG(WHR), STDEV(WHR)
FROM [Diabetes Diagnosis];

-- Relationship Between Risk Factors and Diabetes Outcome
SELECT 
    FamilyHistory, Hypertension, MedicationUse, 
    COUNT(*) AS Cases, 
    SUM(CASE WHEN Outcome = 1 THEN 1 ELSE 0 END) AS Diabetic_Cases,
    SUM(CASE WHEN Outcome = 0 THEN 1 ELSE 0 END) AS Non_Diabetic_Cases
FROM [Diabetes Diagnosis]
GROUP BY FamilyHistory, Hypertension, MedicationUse;

-- Correlation between Glucose, BMI and Diabetes Outcome
SELECT Outcome, AVG(Glucose) AS Avg_Glucose, AVG(BMI) AS Avg_BMI
FROM [Diabetes Diagnosis]
GROUP BY Outcome;

-- Hypertension vs Diabetes Outcome
SELECT Hypertension, Outcome, COUNT(*) AS Count
FROM [Diabetes Diagnosis]
GROUP BY Hypertension, Outcome;