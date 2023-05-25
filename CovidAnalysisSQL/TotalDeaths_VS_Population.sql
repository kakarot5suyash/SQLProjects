-- Total Deaths VS Population
SELECT
	location, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM 
	CovidAnalysisProject..CovidDeaths
WHERE
	continent IS NOT NULL
GROUP BY
	location
ORDER BY
	TotalDeathCount DESC


-- Total Death Count by Continent
SELECT
	continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM 
	CovidAnalysisProject..CovidDeaths
WHERE
	continent IS NOT NULL
GROUP BY
	continent
ORDER BY
	TotalDeathCount DESC



-- GLOBAL NUMBERS
-- getting sum of total new cases and new deaths as per the date
SELECT
	SUM(new_cases) AS TotalNewCases, SUM(CAST(new_deaths as INT)) AS TotalNewDeaths,
	(SUM(CAST(new_deaths as INT))/SUM(new_cases))*100 AS DeathPercentage
FROM
	CovidAnalysisProject..CovidDeaths
WHERE
	continent IS NOT NULL
--GROUP BY 
--	date
ORDER BY
	1,2

SELECT 
	SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM 
	CovidAnalysisProject..CovidDeaths
--Where location like '%states%'
WHERE 
	continent is not null 
--GROUP BY 
--	date
ORDER BY 
	1,2
