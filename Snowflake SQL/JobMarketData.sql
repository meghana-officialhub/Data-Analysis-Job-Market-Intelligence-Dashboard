CREATE DATABASE job_market_db;

CREATE SCHEMA job_market_db.analytics;

USE DATABASE job_market_db;
USE SCHEMA analytics;


SELECT *
FROM DATA_ANALYST_JOBS
LIMIT 10;

SELECT COUNT(*)
FROM DATA_ANALYST_JOBS;

--Top Cities Hiring Data Analysts
SELECT location_city,
COUNT(*) AS total_jobs
FROM DATA_ANALYST_JOBS
GROUP BY location_city
ORDER BY total_jobs DESC
LIMIT 10;

--Highest Paying Cities
SELECT 
    location_city,
    AVG(salary_avg_usd_annual) AS avg_salary
FROM DATA_ANALYST_JOBS
GROUP BY location_city
ORDER BY avg_salary DESC
LIMIT 10;

--Most Demanded Skills
SELECT
    SUM(IFF(skill_sql,1,0)) AS sql_jobs,
    SUM(IFF(skill_python,1,0)) AS python_jobs,
    SUM(IFF(skill_excel,1,0)) AS excel_jobs,
    SUM(IFF(skill_tableau,1,0)) AS tableau_jobs,
    SUM(IFF(skill_power_bi,1,0)) AS powerbi_jobs
FROM DATA_ANALYST_JOBS;

--Highest paying industries 
SELECT 
    industry,
    AVG(salary_avg_usd_annual) AS avg_salary
FROM DATA_ANALYST_JOBS
GROUP BY industry
ORDER BY avg_salary DESC;

--Skills that increase salary 
SELECT 
    skill_python,
    AVG(salary_avg_usd_annual) AS avg_salary
FROM DATA_ANALYST_JOBS
GROUP BY skill_python;

--Top companies hiring analysts 
SELECT 
    company_name_clean,
    COUNT(*) AS total_jobs
FROM DATA_ANALYST_JOBS
GROUP BY company_name_clean
ORDER BY total_jobs DESC
LIMIT 10;


--Salary Impact by Skill 
SELECT 
    'SQL' AS skill,
    AVG(CASE WHEN skill_sql THEN salary_avg_usd_annual END) AS avg_salary_with_skill,
    AVG(CASE WHEN NOT skill_sql THEN salary_avg_usd_annual END) AS avg_salary_without_skill
FROM DATA_ANALYST_JOBS

UNION

SELECT 
    'Python',
    AVG(CASE WHEN skill_python THEN salary_avg_usd_annual END),
    AVG(CASE WHEN NOT skill_python THEN salary_avg_usd_annual END)
FROM DATA_ANALYST_JOBS

UNION

SELECT 
    'Excel',
    AVG(CASE WHEN skill_excel THEN salary_avg_usd_annual END),
    AVG(CASE WHEN NOT skill_excel THEN salary_avg_usd_annual END)
FROM DATA_ANALYST_JOBS

UNION

SELECT 
    'Tableau',
    AVG(CASE WHEN skill_tableau THEN salary_avg_usd_annual END),
    AVG(CASE WHEN NOT skill_tableau THEN salary_avg_usd_annual END)
FROM DATA_ANALYST_JOBS

UNION

SELECT 
    'Power BI',
    AVG(CASE WHEN skill_power_bi THEN salary_avg_usd_annual END),
    AVG(CASE WHEN NOT skill_power_bi THEN salary_avg_usd_annual END)
FROM DATA_ANALYST_JOBS;


--Skill combination analysis
SELECT 
    skill_sql,
    skill_python,
    skill_excel,
    COUNT(*) AS job_count
FROM DATA_ANALYST_JOBS
GROUP BY skill_sql, skill_python, skill_excel
ORDER BY job_count DESC
LIMIT 10;


--Top 10 highest paying jobs 
SELECT 
    job_title,
    company_name_clean,
    salary_avg_usd_annual
FROM DATA_ANALYST_JOBS
ORDER BY salary_avg_usd_annual DESC
LIMIT 10;