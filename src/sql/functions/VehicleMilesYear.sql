DROP FUNCTION IF EXISTS VehicleMilesYear;

DELIMITER $$

CREATE FUNCTION VehicleMilesYear(vehicle INT, yr INT) RETURNS INT
BEGIN
DECLARE s_date, e_date DATE;
DECLARE miles INT;

SET s_date = MAKEDATE(yr, 1);
SET e_date = MAKEDATE(yr, 365);

IF DAYOFMONTH(e_date) = 30 THEN
	SET e_date = MAKEDATE(yr, 366);
END IF;


SELECT SUM(OdometerEnd - OdometerStart) INTO miles
FROM CompletedJourneys j -- should concider changing ... whole view may not be required.
INNER JOIN Vehicle v ON v.idVehicle = j._idVehicle
WHERE CheckedOutDate BETWEEN s_date AND e_date
AND CheckInDate BETWEEN s_date AND e_date
AND _idVehicle = vehicle
GROUP BY _idVehicle;

IF miles IS NULL THEN 
	SET miles = 0; 
END IF;

RETURN miles;

END$$

DELIMITER ;

