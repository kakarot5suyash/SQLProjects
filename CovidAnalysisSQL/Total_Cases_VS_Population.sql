-- Total Cases vs Population
-- shows what percentage of population got infected
--SELECT
--	location, date, population, total_cases, (total_cases/population)*100 AS 
--	InfectedPercentage
--FROM
--	CovidAnalysisProject..CovidDeaths
--WHERE
--	location LIKE '%states%'
--ORDER BY 1,2


--SELECT
--	location, date, population, total_cases, (total_cases/population)*100 AS 
--	InfectedPercentage
--FROM
--	CovidAnalysisProject..CovidDeaths
--WHERE
--	location = 'India'
--ORDER BY
--	1,2



-- Looking at countries with highest infection rate compared to population
SELECT
	location, population, MAX(total_cases) AS MaxInfected,
	MAX((total_cases/population))*100 AS InfectPercentage
FROM
	CovidAnalysisProject..CovidDeaths
GROUP BY
	location, population
ORDER BY
	InfectPercentage DESC

