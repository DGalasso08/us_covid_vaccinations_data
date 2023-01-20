
/* 

BASIC DATA CLEANING AND EXPLORATION FOR VIZ IN TABLEAU

*/

-- 1. Update datatype of date column to date
ALTER TABLE us_vacc
MODIFY COLUMN date date;



-- 2. Replace empty cells with NULL values
UPDATE us_vacc
SET total_vaccinations = NULL WHERE total_vaccinations = '';

UPDATE us_vacc
SET total_distributed = NULL WHERE total_distributed = '';

UPDATE us_vacc
SET people_vaccinated = NULL WHERE people_vaccinated = '';

UPDATE us_vacc
SET people_fully_vaccinated_per_hundred = NULL WHERE people_fully_vaccinated_per_hundred = '';

UPDATE us_vacc
SET total_vaccinations_per_hundred = NULL WHERE total_vaccinations_per_hundred = '';

UPDATE us_vacc
SET people_fully_vaccinated = NULL WHERE people_fully_vaccinated = '';

UPDATE us_vacc
SET people_vaccinated_per_hundred = NULL WHERE people_vaccinated_per_hundred = '';

UPDATE us_vacc
SET distributed_per_hundred = NULL WHERE distributed_per_hundred = '';

UPDATE us_vacc
SET daily_vaccinations_raw = NULL WHERE daily_vaccinations_raw = '';

UPDATE us_vacc
SET daily_vaccinations = NULL WHERE daily_vaccinations = '';

UPDATE us_vacc
SET daily_vaccinations_per_million = NULL WHERE daily_vaccinations_per_million = '';

UPDATE us_vacc
SET share_doses_used = NULL WHERE share_doses_used = '';

UPDATE us_vacc
SET total_boosters = NULL WHERE total_boosters = '';

UPDATE us_vacc
SET total_boosters_per_hundred = NULL WHERE total_boosters_per_hundred = '';



-- 3. Update columns to correct datatype
ALTER TABLE us_vacc
MODIFY COLUMN total_vaccinations int;

ALTER TABLE us_vacc
MODIFY COLUMN total_distributed int;

ALTER TABLE us_vacc
MODIFY COLUMN people_vaccinated int;

ALTER TABLE us_vacc
MODIFY COLUMN people_fully_vaccinated int;

ALTER TABLE us_vacc
MODIFY COLUMN daily_vaccinations_raw int;

ALTER TABLE us_vacc
MODIFY COLUMN daily_vaccinations int;

ALTER TABLE us_vacc
MODIFY COLUMN total_boosters int;

ALTER TABLE us_vacc
MODIFY COLUMN people_fully_vaccinated_per_hundred double;

ALTER TABLE us_vacc
MODIFY COLUMN total_vaccinations_per_hundred double;

ALTER TABLE us_vacc
MODIFY COLUMN people_vaccinated_per_hundred double;
--
ALTER TABLE us_vacc
MODIFY COLUMN distributed_per_hundred double;

ALTER TABLE us_vacc
MODIFY COLUMN daily_vaccinations_per_million double;

ALTER TABLE us_vacc
MODIFY COLUMN share_doses_used double;

ALTER TABLE us_vacc
MODIFY COLUMN total_boosters_per_hundred double;



-- 4. Max people vaccinated by state
SELECT 
	location,
	MAX(people_vaccinated) AS vaccinated_population
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States')
GROUP BY 1;



-- 5. Max people vaccinated by state in just the states
SELECT 
	location,
	MAX(people_vaccinated) AS vaccinated_population
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1;



-- 6. Max people vaccinated by state relative to population
SELECT 
	location,
    MAX(people_vaccinated_per_hundred) AS vaccinated_population_relative_population
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1
ORDER BY 2 DESC;



-- 7. Max fully vaccinated by state
SELECT 
	location,
    MAX(people_fully_vaccinated) AS fully_vaccinated_population
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1
ORDER BY 2 DESC;



-- 8. Max fully vaccinated by state relative to population
SELECT 
	location,
    MAX(people_fully_vaccinated) AS fully_vaccinated_population,
    MAX(people_fully_vaccinated_per_hundred) AS fully_vacc_per_pop
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1
ORDER BY 3 DESC;



-- 9. Daily vaccinations over time by state
SELECT 
    location,
    date,
    daily_vaccinations
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1,2,3
ORDER BY 1,2;



-- 9. Daily vaccinations over time by state with respect to population
SELECT 
    location,
    date,
    daily_vaccinations,
    daily_vaccinations_per_million
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1,2,3,4
ORDER BY 1,2;



-- 10.State's percentage of all people vaccinated 
SELECT 
	location,
	MAX(people_vaccinated) AS vaccinated_population
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1;

SELECT 
	SUM(vaccinated_population) as total_vacc_pop
FROM (
SELECT 
	location,
	MAX(people_vaccinated) AS vaccinated_population
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1) AS a
;
SELECT
	location,
    MAX(people_vaccinated) AS vaccinated_population,
    (MAX(people_vaccinated)/263931835)*100 AS percent_of_total
FROM us_vacc
WHERE location NOT IN ('Bureau of Prisons','Dept of Defense', 'Indian Health Svc','Long Term Care','Veterans Health','United States','American Samoa','Federated States of Micronesia','Marshall Islands','Northern Mariana Islands','Puerto Rico', 'Republic of Palau','Virgin Islands', 'Guam')
GROUP BY 1;









    
