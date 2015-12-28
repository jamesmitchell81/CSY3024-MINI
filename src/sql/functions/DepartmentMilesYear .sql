DROP FUNCTION IF EXISTS DepartmentMilesYear;

DELIMITER $$

CREATE FUNCTION DepartmentMilesYear(department INT, yr INT) RETURNS INT
BEGIN
DECLARE s_date, e_date DATE;
DECLARE miles INT;

SET s_date = MAKEDATE(yr, 1);
SET e_date = MAKEDATE(yr, 365);

IF DAYOFMONTH(e_date) = 30 THEN
	SET e_date = MAKEDATE(yr, 366);
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