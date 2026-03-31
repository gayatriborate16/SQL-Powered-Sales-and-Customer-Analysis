# SQL-Powered-Sales-and-Customer-Analysis
#  Sales Analysis SQL Project

##  Project Overview

This project focuses on analyzing sales data using SQL to extract meaningful business insights such as revenue trends, customer behavior, and product performance.

---

##  Objectives

* Calculate total revenue generated
* Analyze yearly and monthly sales trends
* Identify top customers and products
* Measure business growth rate
* Evaluate customer lifetime value

---

##  Dataset

The dataset includes:

* Customers information
* Transactions data
* Date dimension table
* Market details

---

##  Tools & Technologies

* SQL (MySQL)
* Database Design
* Data Analysis

---

##  Key SQL Analysis

### 1. Total Revenue

```sql
SELECT sum(sales_amount) AS total_revenue
FROM transactions;
```

### 2. Yearly Revenue Growth

```sql
SELECT d.year, SUM(t.sales_amount) AS yearly_revenue
FROM transactions t
JOIN date d
ON t.order_date = d.date
GROUP BY d.year;
```

### 3. Top Customers

```sql
SELECT c.custmer_name, SUM(t.sales_amount) AS total_revenue
FROM transactions t 
JOIN customers c
ON t.customer_code = c.customer_code
GROUP BY c.custmer_name
ORDER BY total_revenue DESC
LIMIT 10;
```

---

##  Key Insights

* Identified highest revenue generating customers
* Found best performing months and years
* Analyzed product performance
* Calculated customer lifetime value

---

##  Future Improvements

* Add Power BI Dashboard
* Optimize queries
* Add indexing for performance
* Create stored procedures

---
