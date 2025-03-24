# Diabetes Risk & Insights Dashboard

This initiative is aimed at understanding diabetes prevalence, risk factors, and lifestyle patterns. This report is designed for the general public and health agencies or organisations working with diabetic populations to understand prevalence trends, lifestyle risks, and clinical factors influencing diabetes outcomes. A risk score predictor is provided to udnerstand what your risks are. 

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

Power BI DAX was used to implement:

### ➤ Risk Score Calculation

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
- `% Diabetics With Medication Use`
- `% Diabetics With WHR High Risk`
- `% Diabetics With Unbalanced Diets`

---

## 🔍 Business Questions Answered

| Question                                                  | Output / Insight                                        |
|-----------------------------------------------------------|----------------------------------------------------------|
| What percentage of the population is diabetic?            | 34.4% overall                                            |
| Do family history or hypertension increase risk?          | Yes, both are strong indicators of diabetes              |
| What lifestyle choices correlate with diabetes?           | Unbalanced diet shows highest diabetes rates             |
| Does age affect HbA1c or diabetes likelihood?             | Yes, older groups have higher HbA1c and prevalence       |
| How many diabetics are on medication?                     | Over 55%                                                 |
| Can we predict diabetes risk from user-entered inputs?    | Yes, via a custom-built DAX-powered calculator           |

---

## 📁 Folder Structure

```
📁 Diabetes Risk Dashboard
├── 📄 README.md
├── 📄 Data_Cleaning.sql
├── 📄 Business_Queries.sql
├── 📄 Diabetes_Dashboard.pbix
└── 📄 Screenshots/
```

---

## 📌 Key Learnings

- Built a business-ready dashboard simulating public health analysis.
- Practiced SQL data cleaning, Power BI modeling, and DAX measures.
- Developed a logical risk prediction calculator using medical logic and weighting.
- Balanced stakeholder communication (overview summaries) with data integrity.

---

## ✅ Next Steps

- Add gender-based segmentation if gender field becomes available.
- Explore time-based trends if longitudinal data is added.
- Compare results with real-world diabetic population benchmarks for further tuning.
