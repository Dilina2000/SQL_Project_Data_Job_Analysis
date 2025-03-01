/*
    What skills are required for the top paying data analyst jobs? 

*/


WITH  top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name

FROM job_postings_fact 
LEFT JOIN company_dim ON  job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10  
)
SELECT top_paying_jobs.*,
        skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

/*
Most In-Demand Skills:

        SQL (8 mentions) is the most frequently required skill, emphasizing its importance in data querying and manipulation.
        Python (7 mentions) follows closely, indicating the demand for programming and data analysis capabilities.
        Tableau (6 mentions) and Power BI (2 mentions) are key visualization tools sought by employers.
        Excel  (3 mentions) remains relevant, reinforcing its necessity in data analysis
*/    