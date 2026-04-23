# 🏥 USA Hospitals Exploratory Data Analysis (EDA) 
<img width="300" height="200" alt="image" src="https://github.com/user-attachments/assets/50632e7b-2c49-4836-9163-ae6149b97f4d" />


## 👥 Team Members

- Abanoub
- Pollob 
- Supriya

## 📅 Project Date
23 April 2026

---

## 📊 Project Repo
👉 [View GitHub Repository](https://github.com/SupriyaGiri14/SQL-Miniproject)

---

## 📌 Project Overview
This project performs an Exploratory Data Analysis (EDA) on Medicare-certified hospitals in the United States using data from **Data.CMS.gov**. The study integrates clinical quality ratings with financial billing data to identify trends in healthcare pricing, quality, and geographic cost variations.

---

## 🎯 Objectives
- Analyze 1.5M+ records covering over 5,000 U.S. hospitals.
- Identify **"Hidden Gem"** hospitals (5-star rating at below-average cost).
- Compare state-level pricing for specific surgeries like Hip Replacements.
- Examine the gap between hospital-billed charges and actual Medicare reimbursements.

---

## 📁 Dataset & Schema
The dataset provides structural information including hospital ownership, emergency services, and location. The raw data was optimized into a **4-Table Schema**:
- **hospitals**: Facility details and quality ratings.
- **billing**: Financial metrics including discharges and payments.
- **locations**: Geographic data (City, State, Zip, County).
- **ref_drg**: Reference table for medical procedure descriptions.

---

## 🛠️ Technologies Used
- **Python**: Data cleaning, transformation, and SQL connection.
- **MySQL**: Relational database management and complex business queries.
- **Pandas**: Structural data optimization.

---

## 📊 Key Analysis Performed
1. **High Quality, Low Cost Analysis**
   - [cite_start]Merged Clinical and Financial tables to filter for 5-star hospitals[cite: 190, 194].
   - [cite_start]Calculated national average prices per treatment to find "Hidden Gems"[cite: 191].

2. **State-Level Price Comparison**
   - [cite_start]Used Common Table Expressions (CTEs) to isolate the top 5 highest and bottom 5 lowest charging states for Hip Replacements[cite: 200, 202].

3. **Revenue & Payment Analysis**
   - [cite_start]Calculated "Received Percentage" to see how much of a hospital's billed charge is actually covered by Medicare[cite: 207].
   - [cite_start]Identified pricing outliers and payment gaps[cite: 207].

---

## 📈 Insights
- **Quality vs. Cost**: High quality (5-star) does not inherently require higher costs; several elite hospitals charge below the national average for complex procedures like heart transplants.
- **Geographic Disparity**: Significant variation exists in surgery costs; for example, Maryland ($29,199) charges nearly triple what Vermont ($10,391) does for Hip and Knee replacements.
- **Billing Inefficiency**: Actual reimbursements represent only a small fraction of total billed charges, suggesting significant pricing inflation in hospital billing practices.
- **Medicare Contribution**: Most "Hidden Gem" hospitals show a high Medicare contribution percentage (often >80-90%) toward the total payment.

---

## 🚀 How to Run This Project
```bash
git clone [https://github.com/SupriyaGiri14/SQL-Miniproject.git](https://github.com/SupriyaGiri14/SQL-Miniproject.git)
cd SQL-Miniproject
# Run Python scripts for data cleaning or import .sql files into MySQL
