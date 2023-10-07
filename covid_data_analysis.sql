create schema covid;
use covid;
-- 1.Total number of rows:
select count(*) from coviddeaths;

desc coviddeaths;
desc covidvaccinations;

-- adding another column of date with date as datatype bcoz previous date column was in text datatype
alter table coviddeaths add column Date_2 date;

UPDATE coviddeaths
SET Date_2 = STR_TO_DATE(date , '%Y-%m-%d');

-- 2. Total death ratio to total cases:
select distinct(continent) from coviddeaths where continent !="";

select continent,location,sum(new_cases) as Total_cases,
sum(new_deaths) as Total_Deaths,
concat(round(sum(new_deaths)/sum(new_cases)*100,2),"%") as death_ratio
from coviddeaths where continent !=""
group by continent,location 
order by death_ratio desc;


-- 3. The death ratio for India and its neighbouring countries:

select location,sum(new_cases) as Total_cases,
sum(new_deaths) as Total_Deaths,
concat(round(sum(new_deaths)/sum(new_cases)*100,2),"%") as death_ratio
from coviddeaths
where location='India' or location='Pakistan'or 
location='Bangladesh'or location='China'
or location='Afghanistan'or location='Sri Lanka'or
 location='Nepal'
 group by location order by death_ratio desc ;
 
 
 -- 4. Total cases vs population
 select * from coviddeaths;
 
 select location ,population from coviddeaths where location ="Andorra";
 
 select location, population, sum(new_cases) as Total_cases,round((sum(new_cases)/population)*100,2) Infection_Ratio
from coviddeaths
where continent!=''
group by location,population
order by Infection_Ratio desc;

-- 5 . Countries with the highest death percentage per population
select * from coviddeaths;

select location ,population, sum(new_deaths) as total_deaths ,
concat(round(sum(new_deaths)/population*100,2),"%") as Death_percent
from coviddeaths 
where continent!=""
group by location , population 
order by Death_percent desc;


-- 6. Break down by continents

select continent, sum(population) as total_population,
 sum(new_deaths) total_deaths
from coviddeaths
where continent!=''
group by continent;

-- 7. Continents with the highest death count per population
select continent, sum(population) Total_Population, sum(new_deaths) Total_Deaths
, sum(new_deaths)/sum(population) Death_Percentage
from coviddeaths
where continent!=''
group by continent;

-- 8. highest and lowest total case vs total death via date

select date, sum(new_cases) Total_case, sum(new_deaths) Total_Deaths,
round((sum(new_deaths)/ sum(new_cases))*100,2) 
as  DeathPercentage
from coviddeaths
where continent!=""
group by date
order by DeathPercentage desc limit 1 ; 

select date, sum(new_cases) Total_case, sum(new_deaths) Total_Deaths,
round((sum(new_deaths)/ sum(new_cases))*100,2) 
as  DeathPercentage
from coviddeaths
where continent!=""
group by date
order by DeathPercentage  limit 1 ;  



-- 9. which continent has highest total cases 
select continent ,sum(total_cases) as cases from coviddeaths 
 where continent !="" group by continent 
 order by sum(total_cases) desc  ;


 -- 10. Total vaccinations achieved  by location
select * from covidvaccinations;
select continent ,location,sum(new_vaccinations) as 
total_vaccinations_achieved from covidvaccinations  group by continent,location
order by sum(new_vaccinations) desc ;
 





  




