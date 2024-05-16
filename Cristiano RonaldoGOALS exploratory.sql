SELECT * 
FROM ronaldogoals

-- Total Goals

SELECT COUNT(ID) AS TotalGoals
FROM ronaldogoals 

-- Goals by season 

SELECT  season, COUNT(ID) as GoalsPerSeason
FROM ronaldogoals
GROUP BY season
ORDER BY GoalsPerSeason DESC -- From the data 11/12 season was his most prolific season


-- Goals per season by club
SELECT  season, club, COUNT(ID) as GoalsPerSeason
FROM ronaldogoals
GROUP BY season, club
ORDER BY GoalsPerSeason DESC

-- Goals He scored for each club

SELECT  club, COUNT(ID) as TotalGoals
FROM ronaldogoals
GROUP BY  club
ORDER BY TotalGoals DESC

-- Goals by club and competition

SELECT  club,Competition, COUNT(ID) as TotalGoals
FROM ronaldogoals
GROUP BY  club,Competition
ORDER BY club desc, TotalGoals DESC

-- Percentage of total goals scored per club

WITH CTE_RonaldoGoals AS 
(SELECT  club, COUNT(ID) as TotalGoals
FROM ronaldogoals
GROUP BY  club)
-- ORDER BY TotalGoals DESC)
SELECT club ,TotalGoals, CAST(CAST(TotalGoals AS FLOAT)/ SUM(TotalGoals) OVER ()  * 100 AS DECIMAL(10,2)) AS PercentageGoal
FROM CTE_RonaldoGoals
GROUP BY club
ORDER BY PercentageGoal DESC;

-- I wanted to know the period He scores more goals and the percentage


WITH CTE_PerTimeRange as
(
SELECT
    CASE
        WHEN minute  BETWEEN 0 and 30 THEN '1st 30mins'
		WHEN minute  BETWEEN 31 and 60 THEN '2nd 30mins'
        WHEN minute  BETWEEN 60 and 89 THEN '3rd 30mins'
        ELSE 'Injury Time'
    END AS time_range,
    COUNT(ID) AS goals_count
FROM ronaldogoals
GROUP BY time_range
ORDER BY goals_count DESC
)
SELECT time_range,goals_count, CAST(CAST(goals_count AS FLOAT)/SUM(goals_count) over () * 100 AS DECIMAL (10,2)) AS PerGoalsPerTime
FROM CTE_PerTimeRange
ORDER BY PerGoalsPerTime DESC;


-- Amount of goals he scored by type

SELECT  `Type`, COUNT(ID) AS Goals
FROM ronaldogoals
GROUP BY `Type`
ORDER BY Goals DESC;

-- Top 10 opponent he scored against

SELECT Opponent, count(ID) as count
from ronaldogoals
group by Opponent
order by count desc
limit 10;

-- Total goals home/away

SELECT venue, count(ID) as count
FROM ronaldogoals
GROUP BY venue