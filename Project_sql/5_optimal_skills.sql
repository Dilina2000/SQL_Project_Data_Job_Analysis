/* 
    What are the most optimal skills to learn aka high demand and high paying skills?
    Remote positions with specified salaries
*/

WITH skills_demand AS(
    SELECT 
       skills_dim.skill_id,
       skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
    
   

),AVERAGE_SALARY AS (
SELECT 
  skills_dim.skill_id,
    skills_dim.skills,
    ROUND(AVG(salary_year_avg),2) AS AVERAGE_SALARY
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
     skills_dim.skill_id


)

SELECT 
    sd.skill_id,  
    sd.skills,
    sd.demand_count,
    avg_sal.AVERAGE_SALARY  
FROM    
    skills_demand AS sd
INNER JOIN AVERAGE_SALARY AS avg_sal ON sd.skill_id = avg_sal.skill_id
