SELECT *
FROM portfolioproject..coviddeaths
WHERE continent is not null
ORDER BY 3,4

SELECT *
FROM portfolioproject..covidvaccination
ORDER BY 3,4

---SELECTING DATAS TO BE USE
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM portfolioproject..coviddeaths
ORDER BY 1,2


---COMPARING THE TOTAL CASES AND THE TOTAL DEATHS
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercent
FROM portfolioproject..coviddeaths
ORDER BY 1,2
--- % OF DEATHS IN NIGERIA
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercent
FROM portfolioproject..coviddeaths
WHERE location='Nigeria'
ORDER BY 1,2

---COMPARING THE % OF THE POPULATION THAT HAD COVID-19 IN NIGERIA
SELECT location, date, population, total_cases, (total_cases/population)*100 AS CasesPercent
FROM portfolioproject..coviddeaths
WHERE location='Nigeria'
ORDER BY 1,2

---COUNTRIES WITH HIGHEST NUMBER OF CASES IN AFRICA COMPARE TO THEIR POPULATION
SELECT location, population, MAX(total_cases) AS Highest_Cases, MAX(total_cases/population)*100 AS HighestCasesPercent
FROM portfolioproject..coviddeaths
WHERE continent='Africa'
GROUP BY location, population 
ORDER BY HighestCasesPercent DESC

---COUNTRIES WITH HIGHEST NUMBER OF CASES IN AFRICA
SELECT location, population, MAX(total_cases) AS Highest_Cases, MAX(total_cases/population)*100 AS HighestCasesPercent
FROM portfolioproject..coviddeaths
WHERE continent='Africa'
GROUP BY location, population 
ORDER BY Highest_Cases DESC

---COUNTRIES WITH HIGHEST DEATH RATE IN AFRICA COMPARE TO THEIR POPULATION
SELECT location, population, MAX(total_deaths) AS Highest_Deaths, MAX(total_deaths/population)*100 AS HighestDeathPercent
FROM portfolioproject..coviddeaths
WHERE continent='Africa'
GROUP BY location, population 
ORDER BY HighestDeathPercent DESC

---COUNTRIES WITH HIGHEST DEATH RATE IN AFRICA
SELECT location, population, MAX(total_deaths) AS Highest_Deaths, MAX(total_deaths/population)*100 AS HighestDeathPercent
FROM portfolioproject..coviddeaths
WHERE continent='Africa'
GROUP BY location, population 
ORDER BY Highest_Deaths DESC

--COUNTRIES WITH HIGHEST DEATH COUNTS IN AFRICA
SELECT location, MAX(CAST(total_deaths AS int)) AS HighestDeathCounts
FROM portfolioproject..coviddeaths
WHERE continent='Africa'
GROUP BY location
ORDER BY HighestDeathCounts DESC

--- COUNTRIES WITH THE HIGHEST DEATH RATE IN THE WORLD
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCounts
FROM portfolioproject..coviddeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCounts DESC

--- TOTAL DEATH COUNTS FOR EACH CONTINENTS
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCounts
FROM portfolioproject..coviddeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCounts DESC

--- TOTAL NUMBER OF DEATHS IN AFRICA
SELECT continent, SUM(CAST(total_deaths AS int)) AS SumDeathCounts
FROM portfolioproject..coviddeaths
WHERE continent = 'Africa'
GROUP BY continent
ORDER BY SumDeathCounts

--- TOTAL NUMBER OF CASES IN AFRICA
SELECT continent, SUM(total_cases) AS SumCasesCounts
FROM portfolioproject..coviddeaths
WHERE continent = 'Africa'
GROUP BY continent
ORDER BY SumCasesCounts

---PERCENTAGE OF SUM OF TOTAL DEATHS TO SUM OF TOTAL CASES
SELECT continent, SUM(total_cases) AS SumCasesCounts, SUM(CAST(total_deaths AS int)) AS SumDeathCounts, (SUM(CAST(total_deaths AS int))/SUM(total_cases))*100 AS percenttotaldeaths
FROM portfolioproject..coviddeaths
WHERE continent='Africa'
GROUP BY continent

---JOINING THE COVIDDEATHS AND COVIDVACCINATION TABLES TOGETHER
SELECT * 
FROM portfolioproject..coviddeaths CD
JOIN portfolioproject..covidvaccination CV
	ON CD.location = CV.location
	AND CD.date = CV.date

--- CHECK FOR PEOPLE FULLY VACCINATED VS THE POPULATION IN AFRICA
SELECT CD.location, CD.date, CD.population, CV.people_fully_vaccinated
FROM portfolioproject..coviddeaths CD
JOIN portfolioproject..covidvaccination CV
	ON CD.location = CV.location
	AND CD.date = CV.date
WHERE CD.continent= 'Africa'


 