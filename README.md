

## Introduction
The data job market is evolving rapidly, and data analyst roles are at the center of this transformation. This project explores:

- **Top-paying data analyst jobs 💰**
- **In-demand skills 🔥**
- **Where high demand meets high salaries**

Check out the SQL queries used in this analysis here: [Project_sql folder](/Project_sql/)

---

## 📌 Background
Through SQL queries, I sought to answer these key questions:

1️⃣ **What are the top-paying data analyst jobs?**
2️⃣ **What skills are required for these top-paying jobs?**
3️⃣ **What skills are most in demand for data analysts?**
4️⃣ **Which skills are associated with higher salaries?**
5️⃣ **What are the most optimal skills to learn?**

---

## 🛠 Tools Used
- **SQL**
- **PostgreSQL**
- **Visual Studio Code**
- **Git & GitHub**

---

## 📊 The Analysis

### 1️⃣ Top-Paying Data Analyst Jobs
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
📌 **Insight:** This query identifies the highest-paying data analyst jobs by filtering out roles with missing salary data and sorting by salary.



---

### 2️⃣ Skills Required for Top-Paying Jobs
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10  
)
SELECT top_paying_jobs.*, skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```
📌 **Insight:** Lists the most common skills required for the highest-paying data analyst jobs.



---

### 3️⃣ Most In-Demand Skills for Data Analysts
```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
📌 **Insight:** Highlights the top 5 most in-demand skills for data analysts.



---

### 4️⃣ Skills Associated with Higher Salaries
```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS AVERAGE_SALARY
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY AVERAGE_SALARY DESC
LIMIT 20;
```
📌 **Insight:** Determines which skills lead to higher salaries in data analytics.



---

### 5️⃣ Most Optimal Skills to Learn
```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),
AVERAGE_SALARY AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 2) AS AVERAGE_SALARY
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
)
SELECT
    sd.skill_id,  
    sd.skills,
    sd.demand_count,
    avg_sal.AVERAGE_SALARY  
FROM skills_demand AS sd
INNER JOIN AVERAGE_SALARY AS avg_sal ON sd.skill_id = avg_sal.skill_id;
```
📌 **Insight:** Identifies the skills that have both high demand and high salary potential.



---

## 🎯 What I Learned
- SQL is a powerful tool for extracting valuable insights from job market data.
- The highest-paying data analyst roles require a combination of specialized technical skills.
- Some skills, like Python and SQL, are consistently in high demand.
- Salary potential varies significantly based on skillset, location, and industry.

---

## 🏁 Conclusion
This analysis helps aspiring data analysts make informed decisions about which skills to learn and which job opportunities to target. By focusing on skills that are both in demand and associated with higher salaries, job seekers can maximize their earning potential.

🚀 **Next Steps:**
- Automate data updates using Python scripts.
- Create interactive dashboards using Tableau or Power BI.
- Expand the analysis to include other data roles like Data Scientists and BI Analysts.

🔗 **Check the full project and queries here:** [Project_sql folder](/Project_sql/)



