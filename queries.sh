#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo  "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo  "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo  "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo  "$($PSQL "SELECT Max(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo  "$($PSQL "SELECT COUNT(*)
FROM (SELECT game_id FROM games WHERE winner_goals > 2) AS games_with_high_goals
")"

echo -e "\nWinner of the 2018 tournament team name:"
echo  "$($PSQL "select t.name
from teams t
join games g on g.winner_id = t.team_id
where year = 2018 and round = 'Final'
")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo  "$($PSQL "SELECT DISTINCT name AS teams
FROM (
    SELECT t1.name
    FROM games g
    JOIN teams t1 ON g.winner_id = t1.team_id
    WHERE g.year = 2014 AND g.round = 'Eighth-Final'
    
    UNION
    
    SELECT t.name
    FROM games g
    JOIN teams t ON g.opponent_id = t.team_id
    WHERE g.year = 2014 AND g.round = 'Eighth-Final'
) AS team_names
ORDER BY teams ASC
")"  


echo -e "\nList of unique winning team names in the whole data set:"
echo  "$($PSQL "select distinct(t.name)
from teams t
join games g 
on g.winner_id = t.team_id 
order by t.name")"

echo -e "\nYear and team name of all the champions:"
echo   "$($PSQL "select g.year as year , t.name as champion
from games g 
join teams t on g.winner_id = t.team_id
where round = 'Final'
order by year asc")"

echo -e "\nList of teams that start with 'Co':"
echo  "$($PSQL "select name 
from teams 
where name LIKE 'Co%'")"
