-- City Where Employees are based
SELECT DISTINCT city, count(city)
FROM employee
group by City;

-- Employee Gender Demographics
SELECT city, sum(gender="female") as Females, sum(gender="male") as Males, count(*) as Total_Employees
From employee
group by city;

-- Employee Age Demographics
SELECT JoiningYear, age,
CASE
	WHEN age < 30 THEN 'young'
    WHEN age >= 30 THEN 'old'
END as Age_Bracket
FROM employee
order by age desc;

SELECT city, sum(age>=30) as OLD_Count, sum(age<30) as YOUNG_Count
FROM employee
group by city;

-- How many emp been working for more than 10 years at the company?

SELECT count(JoiningYear) as NUM_OF_EMP_YEARS_MORE_THAN_TEN
FROM employee
WHERE 2024 - joiningyear > 10;

-- Percentage of women and men in each payment tier
SELECT DISTINCT paymenttier,
AVG(gender="female") as females, AVG(gender="male") as males
FROM employee
GROUP BY paymenttier
ORDER BY paymenttier asc;

SELECT DISTINCT paymenttier,
100*sum(case when gender = 'female' then 1 else 0 end)/count(*) fem_perc,
100*sum(case when gender = 'male' then 1 else 0 end)/count(*) male_perc
from employee
GROUP BY paymenttier
ORDER BY paymenttier asc;

-- What is the distribution of educational qualifications among employees?
SELECT DISTINCT city, sum(case when education = 'bachelors' then 1 else 0 end) as Bachelor_Count,
sum(case when education = 'masters' then 1 else 0 end) as Master_Count,
sum(case when education != 'masters' AND education != 'bachelors' then 1 else 0 end) as Other_Degree
FROM employee
group by city;

SELECT DISTINCT city, 100*sum(case when education = 'bachelors' then 1 else 0 end)/count(*) as Bachelor_Count,
100*sum(case when education = 'masters' then 1 else 0 end)/count(*) as Master_Count,
100*sum(case when education != 'masters' AND education != 'bachelors' then 1 else 0 end)/count(*) as Other_Degree
FROM employee
group by city;

SELECT 100*sum(case when education = 'bachelors' then 1 else 0 end)/count(*) as Bachelor_Count,
100*sum(case when education = 'masters' then 1 else 0 end)/count(*) as Master_Count,
100*sum(case when education != 'masters' AND education != 'bachelors' then 1 else 0 end)/count(*) as Other_Degree
FROM employee;

-- How does the length of service (Joining Year) vary across different cities?
SELECT DISTINCT city, AVG(2024 - JoiningYear)
FROM employee
group by city;

-- Is there a correlation between Payment Tier and Experience in Current Domain?
SELECT DISTINCT paymenttier, AVG(ExperienceInCurrentDomain)
FROM employee
group by PaymentTier
order by PaymentTier;

-- Are there any patterns in leave-taking behavior among employees?
SELECT DISTINCT EverBenched, 100*sum(case when LeaveOrNot = 0 then 1 else 0 end)/count(*) as Dont_Leave,
100*sum(case when LeaveOrNot = 1 then 1 else 0 end)/count(*) as Take_Leave
FROM employee
group by EverBenched;

-- Credentials of 10 employees from highest payment tier
SELECT education, age, ExperienceInCurrentDomain, EverBenched
FROM employee
WHERE PaymentTier = 3
LIMIT 10;