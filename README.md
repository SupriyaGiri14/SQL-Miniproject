# 🏥 USA Hospitals Exploratory Data Analysis (EDA) 
<[img width="253" height="256" alt="logo" src="https://github.com/user-attachments/assets/947dcc4d-6c76-4228-94d1-c4e9798c78f2"](https://www.google.com/imgres?q=image%20for%20hospital&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fthumbnails%2F004%2F493%2F181%2Fsmall%2Fhospital-building-for-healthcare-background-illustration-with-ambulance-car-doctor-patient-nurses-and-medical-clinic-exterior-free-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fhospital&docid=JGaPN5mQb9pcGM&tbnid=E5nlW4D3ngjpPM&vet=12ahUKEwi658b2v4SUAxWPQfEDHcAqH_sQnPAOegQIExAB..i&w=498&h=350&hcb=2&ved=2ahUKEwi658b2v4SUAxWPQfEDHcAqH_sQnPAOegQIExAB) />

## 👥 Team Members

- Abanoub
- Pollob 
- Supriya

## 📅 Project Date
23 April 2026

---

## 📊 Project Presentation
[cite_start]👉 [View GitHub Repository](https://github.com/SupriyaGiri14/SQL-Miniproject) [cite: 219]

---

## 📌 Project Overview
[cite_start]This project performs an Exploratory Data Analysis (EDA) on Medicare-certified hospitals in the United States using data from **Data.CMS.gov**[cite: 132, 135]. [cite_start]The study integrates clinical quality ratings with financial billing data to identify trends in healthcare pricing, quality, and geographic cost variations[cite: 136, 182].

---

## 🎯 Objectives
- [cite_start]Analyze 1.5M+ records covering over 5,000 U.S. hospitals[cite: 140].
- [cite_start]Identify **"Hidden Gem"** hospitals (5-star rating at below-average cost)[cite: 184].
- [cite_start]Compare state-level pricing for specific surgeries like Hip Replacements[cite: 186].
- [cite_start]Examine the gap between hospital-billed charges and actual Medicare reimbursements[cite: 188].

---

## 📁 Dataset & Schema
[cite_start]The dataset provides structural information including hospital ownership, emergency services, and location[cite: 136]. The raw data was optimized into a **4-Table Schema**:
- [cite_start]**hospitals**: Facility details and quality ratings[cite: 148, 156].
- [cite_start]**billing**: Financial metrics including discharges and payments[cite: 158].
- [cite_start]**locations**: Geographic data (City, State, Zip, County)[cite: 168].
- [cite_start]**ref_drg**: Reference table for medical procedure descriptions[cite: 178].

---

## 🛠️ Technologies Used
- [cite_start]**Python**: Data cleaning, transformation, and SQL connection[cite: 141, 144].
- [cite_start]**MySQL**: Relational database management and complex business queries[cite: 143].
- [cite_start]**Pandas**: Structural data optimization[cite: 142].

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

## 📂 Project Structure
USA_Hospitals_EDA/
│
├── data_cleaning.py
├── schema_setup.sql
├── business_queries.sql
├── final_report.pdf
└── README.md

---

## 📈 Insights
- [cite_start]**Quality vs. Cost**: High quality (5-star) does not inherently require higher costs; several elite hospitals charge below the national average for complex procedures like heart transplants[cite: 215, 216].
- [cite_start]**Geographic Disparity**: Significant variation exists in surgery costs; for example, Maryland ($29,199) charges nearly triple what Vermont ($10,391) does for Hip and Knee replacements[cite: 201, 217].
- [cite_start]**Billing Inefficiency**: Actual reimbursements represent only a small fraction of total billed charges, suggesting significant pricing inflation in hospital billing practices[cite: 218].
- [cite_start]**Medicare Contribution**: Most "Hidden Gem" hospitals show a high Medicare contribution percentage (often >80-90%) toward the total payment[cite: 212].

---

## 🚀 How to Run This Project
```bash
git clone [https://github.com/SupriyaGiri14/SQL-Miniproject.git](https://github.com/SupriyaGiri14/SQL-Miniproject.git)
cd SQL-Miniproject
# Run Python scripts for data cleaning or import .sql files into MySQL
