# Diabetes Risk & Insights Dashboard

This initiative is aimed at understanding diabetes prevalence, risk factors, and lifestyle patterns. This report is designed for the general public and health agencies or organisations working with diabetic populations to understand prevalence trends, lifestyle risks, and clinical factors influencing diabetes outcomes. A risk score predictor is provided to udnerstand whether you are at risk or not (Disclaimer: Risk score predictor accuracy not officially verified).

### SQL & Dashboard Links

- The **SQL queries** used to inspect, clean and transform the data for this analysis can be found **[here](https://github.com/SinaS24/Diabetes-risk-and-insights/tree/2a7dfc52ca336bbe76504e7b81d50e9379817619/SQL)**.  
- An **interactive Power BI dashboard** used for this report can be found **[here](https://app.powerbi.com/groups/me/reports/b567541e-a134-4cea-a464-d4fe5cffbade/d2dde74a1c093e970564?experience=power-bi)**.  

---

## Dashboard Overview

The Power BI dashboard is structured into four key pages:

### 1. **Overview**
- High-level KPIs and average medical indicators.
- Summary cards include:
  - BMI, Blood Pressure, Glucose, HbA1c, LDL, Triglycerides, HDL, WHR, and Family History prevalence.
- Key visual: % of diabetics across age groups.
- Summary of key insights and observations.

### 2. **Risk Factors**
- Compares diabetics vs. non-diabetics on key medical variables:
  - BMI distribution
  - Blood pressure distribution
  - WHR risk category
  - Family history breakdown
- Trends identifying groups with increased diabetic likelihood.

### 3. **Lifestyle**
- Diet type vs. diabetes rate.
- HbA1c trend by age and diabetes outcome.
- Medication use among diabetics (55% on medication).
- Demonstrates how lifestyle and treatment factors influence diabetic outcomes.

### 4. **Risk Predictor**
- An interactive risk score calculator.
- Inputs: Blood Pressure, Glucose, Age, BMI, Family History, and Hypertension.
- Custom DAX formula to calculate a composite score scaled from 0–100:
  - **Low risk:** < 29
  - **Moderate risk:** 30–59
  - **High risk:** ≥ 60

---

## Tools Used

| Tool       | Purpose                            |
|------------|-------------------------------------|
| SQL        | Data cleaning, transformation, categorisation |
| Power BI   | Data modelling, DAX measures, report design |

---

## Dataset and data dictionary - Diabetes diagnosis 

This dataset contains 9,538 medical records related to diabetes diagnosis and risk factors. It includes various health parameters, lifestyle habits, and genetic predispositions that contribute to diabetes risk. The data is structured with realistic distributions, making it valuable for medical research, statistical analysis, and machine learning applications. 

- Pregnancies: Number of times the patient has been pregnant.
- BMI (Body Mass Index): A measure of body fat based on height and weight (kg/m²).
- Glucose: Blood glucose concentration (mg/dL), a key diabetes indicator.
- BloodPressure: Systolic blood pressure (mmHg), higher levels may indicate hypertension.
- HbA1c: Hemoglobin A1c level (%), representing average blood sugar over months.
- LDL (Low-Density Lipoprotein): "Bad" cholesterol level (mg/dL).
- HDL (High-Density Lipoprotein): "Good" cholesterol level (mg/dL).
- Triglycerides: Fat levels in the blood (mg/dL), high values increase diabetes risk.
- WaistCircumference: Waist measurement (cm), an indicator of central obesity.
- HipCircumference: Hip measurement (cm), used to calculate WHR.
- WHR (Waist-to-Hip Ratio): Waist circumference divided by hip circumference.
- FamilyHistory: Indicates if the individual has a family history of diabetes (1 = Yes, 0 = No).
- DietType: Dietary habits (0 = Unbalanced, 1 = Balanced, 2 = Vegan/Vegetarian).
- Hypertension: Presence of high blood pressure (1 = Yes, 0 = No).
- MedicationUse: Indicates if the individual is taking medication (1 = Yes, 0 = No).
- Outcome: Diabetes diagnosis result (1 = Diabetes, 0 = No Diabetes). 

---

## Data Inspection, Cleaning and Preparation (SQL)

Data inspections, cleaning and structuring was performed in SQL and loaded into Power BI as a clean table.

Key SQL queries included:
- Data inspection, including: rows, distributions, data types, outliers and missing values. 
- Removed pregnancy column due to unusal numbers.
- Created new column to group by Age.
- Updated boolean columns' data types to BIT (Family History, Medication Use, Hypertension and Outcome)

PowerBI:
- Encoded variables with readable labels such as Yes / No for family history and hypertension, balanced, unbalanced, and vegetarian/vegaan for diet type.
- Transformed column data types.

---

## Key DAX Measures

DAX measures were used to implement:

### ➤ Risk Score Calculation

Used a weighted model based on data and additional research. 

```DAX
Risk_Score_2 = 
VAR AgeRisk = SWITCH(TRUE(), Age >= 55, 1, Age >= 35, 0.5, 0)
VAR BMIRisk = SWITCH(TRUE(), BMI >= 32, 1, BMI >= 27, 0.5, 0)
VAR GlucoseRisk = SWITCH(TRUE(), Glucose >= 126, 1, Glucose >= 100, 0.5, 0)
VAR BPRisk = SWITCH(TRUE(), BP >= 135, 1, BP >= 120, 0.5, 0)
VAR FamilyHistoryRisk = IF(FamilyHistory = 1, 1, 0)
VAR HypertensionRisk = IF(Hypertension = 1, 1, 0)

RETURN ROUND(
    (AgeRisk * 1 + BMIRisk * 1.1 + GlucoseRisk * 1.3 + BPRisk * 1.1 + FamilyHistoryRisk * 1.2 + HypertensionRisk * 1) * 15,
1)
```

- Scaled to 0–100 range to improve visual granularity and user understanding.
- Categories defined as:
  - Low risk: < 29
  - Moderate risk: 30–59
  - High risk: ≥ 60

### ➤ % Calculations

Example:
```DAX
% Diabetics With Family History = 
VAR TotalDiabetics = CALCULATE(COUNTROWS(data), data[Outcome_Label] = "Yes")
VAR WithHistory = CALCULATE(COUNTROWS(data), data[Outcome_Label] = "Yes", data[FamilyHistory_Label] = "Yes")
RETURN DIVIDE(WithHistory, TotalDiabetics, 0)
```

Similar logic used for:
- `% Diabetics with medication use`
- `% Diabetics with WHR high risk`
- `% Diabetics with unbalanced diets`
- `% Diabetics with High glucose`
- `% Diabetics that are obese`
- `% Diabetics by BP`
- `% Diabetics by BMI`

---

## Questions Answered

| Question                                                  | Output / Insight                                        |
|-----------------------------------------------------------|----------------------------------------------------------|
| What percentage of the population is diabetic?            | 34.4% overall                                            |
| Do family history or hypertension increase risk?          | Yes, both are strong indicators of diabetes              |
| What lifestyle choices correlate with diabetes?           | Unbalanced diet shows highest diabetes rates             |
| Does age affect HbA1c or diabetes likelihood?             | Yes, older groups have higher HbA1c and prevalence       |
| How many diabetics are on medication?                     | Over 55%                                                 

---

## Caveats and Considerations

While this dashboard provides meaningful insights, the following limitations should be considered:
- Sample Size: The dataset comprises a relatively small sample which may not fully capture broader population trends.
- Geographic Unknowns: The geographic origin of the dataset is unspecified. Regional factors (e.g., diet, healthcare access, genetics) may influence results and limit generalisability.
- Data Quality & Accuracy: The data may contain self-reported or clinically estimated values. No information on data collection methodology is provided, which could affect reliability.
- Lack of Gender Differentiation: The dataset lacks a gender variable, limiting analysis for metrics where clinical benchmarks differ (e.g., WHR).
- Limited Lifestyle Factors: The dataset excludes important lifestyle variables such as physical activity, sleep patterns, alcohol use, or smoking status, which are known contributors to diabetes risk.
- Simplified Risk Scoring: The Diabetes Risk Predictor uses a custom scoring algorithm for illustrative purposes only. It does not represent a clinically validated tool.

Please note that this dashboard is intended for educational and analytical demonstration only and should not be used to inform clinical or policy decisions without further validation.
