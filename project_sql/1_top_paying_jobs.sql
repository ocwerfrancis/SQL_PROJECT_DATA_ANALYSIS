/*
QN: What are the top paying data analyst jobs
- Forcuses on jobnpostings with specified salaries(remove Nulls)
- why? Highlight the top paying opoortunities for data analysts, offering insights into employment options and location flexibility.
*/

SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date::DATE,
	name as company_name
FROM
    job_postings_fact jpf 
LEFT JOIN company_dim cd 
	ON jpf.company_id = cd.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
