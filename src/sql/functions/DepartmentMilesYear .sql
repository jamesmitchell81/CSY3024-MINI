DROP FUNCTION IF EXISTS DepartmentMilesYear;

DELIMITER $$

CREATE FUNCTION DepartmentMilesYear(department INT, yr INT) RETURNS INT
BEGIN
DECLARE year_days INT;
DECLARE s_date, e_date DATE;
DECLARE miles INT;

SET year_days = 365;
SET s_date = MAKEDATE(yr, 1);
-- Plus one day as '2015-12-31' is '2015-12-31 00:00:00'
SET e_date = MAKEDATE(yr, year_days + 1); 


IF DAYOFMONTH(e_date) = 31 THEN
	-- Plus two days as '2015-12-31' is '2015-12-31 00:00:00'
	SET e_date = MAKEDATE(yr, year_days + 2);
    
END IF;

SELECT SUM(j.OdometerEnd - j.OdometerStart) INTO miles
FROM CompletedJourneys j
INNER JOIN DepartmentReservations r ON r.idReservation = j._idReservation
WHERE j.CheckedOutDate BETWEEN s_date AND e_date
AND j.CheckInDate BETWEEN s_date AND e_date
AND idDepartment = department
GROUP BY idDepartment;

IF miles IS NULL THEN 
	SET miles = 0; 
END IF;

RETURN miles;

END$$

DELIMITER ;