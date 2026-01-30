-- Task 1 Data Quality & Airport profiling
SELECT 
airport_code as airportCode,
TRIM(UPPER(airport_name ->> 'en')) AS airportCleanedName,
TRIM(UPPER(airport_name ->> 'ru')) AS russian_name,
TRIM(LOWER(city ->> 'en')) AS cityCleaned,
LENGTH(TRIM(UPPER(airport_name ->> 'en'))) AS nameLength
FROM airports_data
WHERE LENGTH(TRIM(UPPER(airport_name ->> 'en'))) BETWEEN 10 AND 40 
ORDER BY nameLength DESC 
LIMIT 15;


SELECT *
FROM airports_data
LIMIT 15;

SELECT *
FROM flights
LIMIT 15;

--Task 2 Route Demand Analysis
SELECT
CONCAT_WS('-', departure_airport, arrival_airport) AS "DEP-ARR",
COUNT(flight_no) AS totalFlightsNumberOnTheRoute,
CONCAT(ROUND(AVG(EXTRACT(EPOCH FROM 
(actual_arrival - actual_departure)) / 60.0)), ' ', 'Mins') AS averageFlightDuration
FROM flights
WHERE actual_departure IS NOT NULL 
AND TRIM(UPPER(departure_airport)) IN ('JFK','LAX','SFO')
GROUP BY 
departure_airport, 
arrival_airport
HAVING COUNT(flight_no) >= 5 -- filtering flights greater than 5
AND AVG(EXTRACT(EPOCH FROM (actual_arrival - actual_departure)) / 60.0)  <> 0
LIMIT 10



-- Task 3 REVENUE AND TICKET VALIDATION
SELECT 
UPPER(t.passenger_name) AS passengerName,
COUNT(t.ticket_no) AS totalFlightsTaken,
SUM(tf.amount) AS totalAmountSpend,
ROUND(AVG( CAST(tf.amount AS NUMERIC)),2) AS averageAmountPerFlight
FROM tickets AS t
JOIN ticket_flights AS tf
ON t.ticket_no = tf.ticket_no
WHERE t.passenger_name IS NOT NULL -- Filter passengers without names
AND TRIM(t.passenger_name) LIKE '%_%'
AND tf.amount BETWEEN 50 AND 5000 -- Filter amount between 50 AND 5000
GROUP BY UPPER(t.passenger_name) 
HAVING COUNT(t.ticket_no) >= 1 -- passengers with more that 1 ticket
LIMIT 100;


/*
SELECT *
FROM tickets
LIMIT 20;
*/

/*
SELECT *
FROM ticket_flights
LIMIT 20;
*/



