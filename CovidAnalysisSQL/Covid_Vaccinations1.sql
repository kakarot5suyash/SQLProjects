-- Covid Vaccinations Exploration
SELECT
	*
FROM 
	CovidAnalysisProject..CovidVaccinations

-- Joining CovidDeaths and CovidVaccinations
SELECT
	*
FROM 
	CovidAnalysisProject..CovidDeaths dea
JOIN
	CovidAnalysisProject..CovidVaccinations vac
	ON
	dea.location = vac.location
	AND dea.date = vac.date


-- Looking at Total Population vs Vaccinations
SELECT
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM
	CovidAnalysisProject..CovidDeaths dea
JOIN
	CovidAnalysisProject..CovidVaccinations vac
	ON
		dea.location = vac.location
		AND dea.date = vac.date
WHERE
	dea.continent IS NOT NULL
ORDER BY
	1, 2, 3


-- using partition with the above query
SELECT
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(CAST(vac.new_vaccinations AS int))OVER (PARTITION BY dea.location)AS TotalVaccinations
FROM
	CovidAnalysisProject..CovidDeaths dea
JOIN
	CovidAnalysisProject..CovidVaccinations vac
	ON
		dea.location = vac.location
		AND dea.date = vac.date
WHERE
	dea.continent IS NOT NULL
ORDER BY 
	2,3




SELECT
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(CAST(vac.new_vaccinations AS int))OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)AS TotalVaccinations
FROM
	CovidAnalysisProject..CovidDeaths dea
JOIN
	CovidAnalysisProject..CovidVaccinations vac
	ON
		dea.location = vac.location
		AND dea.date = vac.date
WHERE
	dea.continent IS NOT NULL
ORDER BY 
	2,3



-- Using the above query with CTE
WITH popvsvac (Continent, Location, Date, Population, New_Vaccinations, TotalVaccinations)
AS
(
SELECT
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(CAST(vac.new_vaccinations AS int))OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)AS TotalVaccinations
FROM
	CovidAnalysisProject..CovidDeaths dea
JOIN
	CovidAnalysisProject..CovidVaccinations vac
	ON
		dea.location = vac.location
		AND dea.date = vac.date
WHERE
	dea.continent IS NOT NULL
--ORDER BY 
	--2,3
)

SELECT 
	*, (TotalVaccinations/Population)  * 100
FROM
	popvsvac



-- Creating Temp Table for population vs vaccinations percentage
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
	Continent nvarchar (255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_Vaccinations numeric,
	TotalVaccinations numeric
)

-- Inserting into Temp Table
INSERT INTO #PercentPopulationVaccinated
SELECT
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(CAST(vac.new_vaccinations AS int))OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)AS TotalVaccinations
FROM
	CovidAnalysisProject..CovidDeaths dea
JOIN
	CovidAnalysisProject..CovidVaccinations vac
	ON
		dea.location = vac.location
		AND dea.date = vac.date
--WHERE
	--dea.continent IS NOT NULL
--ORDER BY 
--	2,3

SELECT 
	*, (TotalVaccinations/Population)*100
FROM 
	#PercentPopulationVaccinated



-- Creating a view to store data for later visualizations
CREATE VIEW 
	PercentPopulationVaccinated 
	AS
	SELECT
		dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
		, SUM(CAST(vac.new_vaccinations AS int))OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)AS TotalVaccinations
	FROM
		CovidAnalysisProject..CovidDeaths dea
	JOIN
		CovidAnalysisProject..CovidVaccinations vac
		ON
			dea.location = vac.location
			AND dea.date = vac.date
	WHERE
		dea.continent IS NOT NULL


