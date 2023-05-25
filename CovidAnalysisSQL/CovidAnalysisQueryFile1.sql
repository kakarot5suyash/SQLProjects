-- Exploration of Covid Deaths and Covid Vaccinations Data

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidAnalysisProject..CovidDeaths
ORDER BY 1,2