# Diabetes Risk & Insights Dashboard

This Power BI project analyzes health data to uncover insights into diabetes risk factors and health outcomes. Built to simulate a professional, user-facing dashboard, this project takes a comprehensive and stakeholder-friendly approach to visual storytelling, with intuitive navigation across key focus areas.

The dashboard mimics a multi-page website experience, covering:

- **Overview** — Key diabetic statistics and average medical indicators
- **Risk Factors** — Visual breakdown of physical and hereditary risk contributors
- **Lifestyle** — How diet, age, and medication use relate to diabetes
- **Risk Predictor** — A dynamic calculator that outputs a diabetes risk score based on selected health inputs

The goal is to help stakeholders (e.g., clinicians, healthcare analysts, policy advisors) understand contributing factors and identify high-risk profiles.

---

# Project Background

You're a data analyst working for a health analytics organization supporting preventive care initiatives. Your team is tasked with delivering clear insights into diabetes risk indicators, patterns across population groups, and tools to help inform early interventions.

The data used is anonymized health survey data, which includes medical metrics (e.g., glucose, blood pressure, BMI), lifestyle indicators (e.g., diet type), and diabetic outcomes. 

Your stakeholders want to know:

- What key health and lifestyle traits are most strongly linked to diabetes?
- Can you visually segment risk by age, family history, or obesity?
- How can we create a tool to estimate individual diabetes risk?
- What preventive actions are most actionable across groups?

This dashboard answers those questions in an intuitive and engaging way.

---

# Data Structure & Initial Checks

The dataset used is a cleaned version of a diabetes health survey. It includes the following fields:

- **Medical Metrics**: BloodPressure, Glucose, BMI, Triglycerides, HbA1c, WHR (Waist-to-Hip Ratio), HDL, LDL
- **Lifestyle Inputs**: Diet type, Medication use, Family history, Hypertension
- **Demographic**: Age group
- **Outcome**: Binary diabetic/non-diabetic label

Extensive DAX measures were written for:
- Categorizing WHR risk
- Generating risk score outputs
- Creating diabetes rate percentages by subgroups
- Calculating medical indicator averages

[Power BI Report Link Here]

---

# Executive Summary

### Overview of Findings

- **Diabetes prevalence** in the dataset is 34.4%
- **Age and BMI** show strong correlation with diabetic outcomes
- Individuals with **unbalanced diets** and **family history** are significantly more likely to be diabetic
- Over **55% of diabetics are on medication**, yet glycemic markers like HbA1c remain elevated in older adults
- A custom-built **risk score model** allows users to simulate risk levels based on 6 key health inputs

### Recommendation Themes

- Flag at-risk individuals using WHR, blood pressure, and glucose ranges
- Promote balanced dietary habits to reduce incidence in younger age groups
- Use the dynamic risk calculator to personalize prevention strategies

---

# Insights Deep Dive

### Risk Factors
- Visualizations show diabetics consistently have **higher BMI and blood pressure** levels
- A large percentage of diabetics fall into **high WHR categories**, suggesting visceral fat is a strong indicator
- **Family history** plays a significant role, with nearly 88% of diabetics reporting it

### Lifestyle
- **Unbalanced diets** are linked to a 61.8% diabetes rate
- **HbA1c levels** among diabetics are elevated across all age groups, especially seniors
- Over **55% of diabetics use medication**, yet outcome markers remain suboptimal

### Risk Predictor
- Users input 6 variables (Age, BMI, BP, Glucose, Family History, Hypertension)
- A weighted DAX-based model scores risk from 0–100:
  - Low Risk: <29
  - Moderate Risk: 30–59
  - High Risk: 60+
- Weights and cutoffs are based on clinical standards and tested thresholds

---

# Recommendations

- Prioritize prevention in **older adults**, especially those with high glucose/BMI and family history
- Use risk scores in **clinical decision-making** to direct resources efficiently
- Encourage public health initiatives around **diet education and screening**
- Refine the risk predictor by incorporating gender and physical activity when data is available

---

# Assumptions & Caveats

- The data is **synthetic or anonymized**, limiting demographic precision
- Gender and physical activity data were **not available**, limiting model completeness
- The risk predictor is not a diagnostic tool, but a **relative indicator of risk**
- External validation would improve confidence in generalizability

---

