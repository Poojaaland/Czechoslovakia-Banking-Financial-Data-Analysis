📖 Project Overview

This project is based on the Czechoslovakia Bank Financial Dataset, which contains banking data such as client information, accounts, transactions, loans, cards, and district details.
The objective of this project is to perform data cleaning, transformation, ad-hoc SQL analysis, and dashboard visualization to generate actionable insights for the bank.
This project was completed as part of my internship project in the domain of Data Analytics / Business Intelligence.


🎯 Problem Statement

The bank wants to analyze its financial dataset to identify:
Customer demographic trends
Bank performance year-wise and month-wise
Account and card usage behavior
Profitability insights
Major expense patterns
Loan portfolio segmentation
Customer satisfaction improvement areas
Opportunities for introducing new financial products/services
The analysis was divided into:

✅ Q1 to Q5 solved using PostgreSQL
✅ Q6 to Q8 solved using Power BI dashboard visualizations


🛠 Tools & Technologies Used

Microsoft Excel (Data Cleaning & Transformation)
PostgreSQL (Ad-hoc SQL Queries, Joins, Aggregations, Case Statements)
Power BI (Dashboard Development, Data Modeling, Visual Analytics)


📂 Dataset Description
The dataset contains the following tables:
Account: account details, account opening date, frequency
Card: card issued date, card type
Client: client demographic details and birth number
Disposition: relationship between clients and accounts
District: district-wise demographic and economic details
Loan: loan amount, duration, loan status
Order: order details linked with accounts
Transaction: transaction type, amount, date, bank information


🧹 Data Cleaning & Transformation (Excel + SQL)
Before analysis, the dataset was cleaned and transformed to ensure accuracy and consistency.

🔹 Account Table
Converted date column into yyyy-mm-dd format by adjusting year values.
Replaced frequency codes into meaningful values such as:
Monthly Issuance
Weekly Issuance
Issuance after a Transaction
Created a derived column Card_Assigned:
Silver → Monthly issuance
Diamond → Weekly issuance
Gold → Issuance after a transaction

🔹 Card Table
Replaced card type values:
junior → Silver
classic → Gold
gold → Diamond
Converted issued date column into standardized format.

🔹 Client Table
Converted birth_number into date format.
Created a new column Sex using birth_number logic:
Male format: YYMMDD
Female format: YYMM+50DD

🔹 Loan Table
Converted loan date column into standard date format.
Updated loan status values:
A → Contract Finished
B → Loan Not Paid
C → Running Contract
D → Client in Debt

🔹 Transaction Table
Corrected transaction year inconsistencies.
Updated missing bank values based on year.


🧠 Ad-hoc SQL Analysis (PostgreSQL)

The following business questions were answered using SQL queries:

✅ Q1: Client Demographic Profile
Age distribution
Gender distribution
District-wise demographic comparison

✅ Q2: Bank Performance Analysis
Year-wise performance trends
Month-wise transaction analysis
Profitability and transaction volume changes over time

✅ Q3: Account Type Usage & Profitability
Most common account types
Usage patterns and profitability comparison

✅ Q4: Card Usage & Profitability
Most frequently used card types
Card-wise profitability and transaction analysis

✅ Q5: Major Expenses
Identified expense transaction types
Expense trend patterns to suggest reduction areas


📊 Power BI Dashboard & Visualization (Q6 to Q8)

Power BI was used to create interactive dashboards for deeper business insights.

✅ Q6: Loan Portfolio Analysis Dashboard
Loan distribution by status, duration, and account type
Loan segmentation by age group and gender
District-wise loan distribution (Map Visualization)
Top 5 and Bottom 5 districts based on loan amount
✅ Q7: Customer Service & Satisfaction Dashboard

Transaction behavior trends
Account balance analysis
Card usage insights
District-wise client profile visualization
KPIs such as active cards, total transactions, and low balance accounts

✅ Q8: New Product / Service Opportunity Dashboard
Profitability analysis by account type and card type
Transaction patterns by customer segment
District-wise profitability map
Key KPIs for product and service decision-making


📌 Key Insights Generated

District-wise client segmentation helps in targeted banking services.
Certain account types contribute higher profitability.
Card usage trends indicate customer preference towards specific card categories.
Loan portfolio analysis highlights risk and debt segments.
Transaction patterns suggest potential product improvements and marketing strategies.


🚀 Conclusion

This project demonstrates an end-to-end Data Analytics workflow, including:
Data Cleaning and Transformation
SQL-based Ad-hoc Data Analysis
Business Intelligence Dashboard Creation
Business Insight Generation
It helped me strengthen my skills in Excel, PostgreSQL, Power BI, and Data Analytics.
