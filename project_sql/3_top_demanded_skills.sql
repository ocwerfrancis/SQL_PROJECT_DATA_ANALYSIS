/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC



WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim sjd
    INNER JOIN job_postings_fact jpf
        ON jpf.job_id = sjd.job_id
    WHERE
        jpf.job_work_from_home = TRUE
        AND
        jpf.job_title_short = 'Data Analyst'
    GROUP BY 
        skill_id
)
SELECT 
    sd.skill_id,
    sd.skills AS skill_name,
    skill_count
FROM 
    skills_dim sd
JOIN 
    remote_job_skills rjs ON sd.skill_id = rjs.skill_id
ORDER BY 
    skill_count DESC