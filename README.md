# credit Risk Prediction End to End Pipeline  
This project implements an automated and scalable credit risk pipeline leveraging Azure and AWS S3. Data is ingested from S3 into Azure Data Lake Storage using Azure Data Factory, then transformed using Azure Databricks. Processed data is stored in Azure Synapse Analytics for reporting and analysis, with visualizations delivered through Power BI. Machine learning models are developed and deployed using Azure Machine Learning.


## 🚀 Tech Stack

- **Azure Data Lake Storage Gen2** – Raw & processed data storage
- **Azure Databricks** – Data ingestion, preprocessing, feature engineering
- **Apache Spark (PySpark)** – Scalable data transformation
- **Azure Synapse Analytics** – Exploratory data analysis (SQL-based)
- **Azure Machine Learning Studio** – Model building & deployment (optional stage)
- **Power BI** – Business insights visualization

---

## 📦 Dataset Description

The dataset contains information about **credit card clients in Taiwan**, including:

- Demographics: `AGE`, `SEX`, `EDUCATION`, `MARRIAGE`
- Financial data: `LIMIT_BAL`, bill and payment amounts
- Repayment history: `PAY_0` to `PAY_6`
- Target variable: `default payment next month` (binary)

> **Source**: [UCI Credit Card Dataset](https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients)

---

## 🔧 Data Preprocessing Steps (in Databricks)

- ✅ Mounted Azure Data Lake using OAuth configs
- ✅ Loaded raw CSV into a Spark DataFrame
- ✅ Checked for missing/null values
- ✅ Calculated skewness for continuous variables
- ✅ Applied log transformation to skewed columns using `log1p`
- ✅ Created `TOTAL_BILL`, `TOTAL_PAY`, and `PAY_RATIO` features
- ✅ Filtered out records with `LIMIT_BAL < 10000`
- ✅ Retained categorical features as encoded (for ML pipeline)

> ⚠️ Label mappings are skipped intentionally to maintain numeric encoding for machine learning. They can be applied later in Power BI or Azure ML if needed.

---

## 🔍 Synapse Analytics – SQL-Based Insights

Example insights generated in Synapse:

- Default rate overall and by demographic
- Average credit limit across age groups
- Payment behavior vs. bill amounts
- Repayment delay trends (`PAY_n`)
- High-risk segments by education/marriage

---

## 📊 Power BI Dashboards

Data exported to Power BI for rich interactive dashboards:

- Default vs. Non-Default analysis
- Avg. payment vs. bill heatmaps
- LIMIT_BAL and PAY_RATIO scatter plots
- Trend lines by PAY history
- Drill-downs by age, gender, and education

---
