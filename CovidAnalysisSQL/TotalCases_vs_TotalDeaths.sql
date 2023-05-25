-- Total Cases vs Total Deaths

-- Getting total deaths per total cases percentage	i.e. DeathPercentage
--SELECT location, date, total_cases, total_deaths, (CONVERT(decimal , total_deaths) / total_cases)*100 AS DeathPercentage
--FROM CovidAnalysisProject.dbo.CovidDeaths
--ORDER BY 1,2


-- Getting Death Percentage of covid cases in India
--SELECT location, date, total_cases, total_deaths, (CONVERT(decimal, total_deaths)/total_cases) * 100 AS DeathPercentage
--FROM CovidAnalysisProject..CovidDeaths
--WHERE location = 'India'
--ORDER BY 1,2



-- Selecting Distinct Countries whose DeathPercentage is greater than 10%
--SELECT location, SUM(CONVERT(INT,total_cases)) AS total_cases, SUM(CONVERT(INT,total_deaths)) AS total_deaths, (CONVERT(decimal, total_deaths)/total_cases) * 100 AS DeathPercentage
--FROM CovidAnalysisProject..CovidDeaths
--WHERE (CONVERT(decimal, total_deaths)/total_cases) * 100 > 10
--GROUP BY location

SELECT location, date, total_cases, total_deaths, (CONVERT(decimal, total_deaths)/total_cases) * 100 AS DeathPercentage
FROM CovidAnalysisProject..CovidDeaths
WHERE  location LIKE '%States%'
ORDER BY 1,2

