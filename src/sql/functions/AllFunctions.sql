DROP FUNCTION IF EXISTS allMaintenanceItemsComplete;

DELIMITER $$

CREATE FUNCTION allMaintenanceItemsComplete(m_log_number INT) RETURNS BOOLEAN
BEGIN

RETURN (SELECT idMaintenanceItem 
			  FROM MaintenanceItem 
              WHERE _MaintenanceLogNumber = m_log_number 
              AND _CompletedBy IS NULL 
              AND CompletionDate IS NULL) IS NULL;

END$$

DELIMITER ;



DROP FUNCTION IF EXISTS arePartsInStrock;

DELIMITER $$

CREATE FUNCTION arePartsInStrock(partID INT, quantity INT) RETURNS BOOLEAN
BEGIN


RETURN EXISTS (
	SELECT * 
    FROM PartsStockView
    WHERE idPartType = partID
    AND InStock >= quantity
);


END $$

DELIMITER ;


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



DROP FUNCTION IF EXISTS isVehicleAvailable;

DELIMITER $$

-- is vehicle already reserved for dates.
CREATE FUNCTION isVehicleAvailable (vehicle INT, s_date DATE, e_date DATE) RETURNS BOOLEAN
BEGIN

-- is vehicle booked out for these days.
RETURN NOT EXISTS(
	SELECT _idVehicle
	FROM VehicleReservation
	WHERE _idVehicle = vehicle
	AND _idReservation IN (
		SELECT idReservation 
		FROM Reservation
		WHERE (DepartureDate BETWEEN s_date AND e_date)
		OR (ReturnDueDate BETWEEN s_date AND e_date)
	)
);



END $$


DELIMITER ;




DROP FUNCTION IF EXISTS isVehicleInMaintenance;

DELIMITER $$

CREATE FUNCTION isVehicleInMaintenance (vehicle INT) RETURNS BOOLEAN
BEGIN


RETURN EXISTS (SELECT MaintenanceLogNumber 
			   FROM Maintenance 
               WHERE _idVehicle = vehicle 
               AND _ReturnedBy IS NULL);


END $$

DELIMITER ;


DROP FUNCTION IF EXISTS isVehicleInUse;

DELIMITER $$

CREATE FUNCTION isVehicleInUse (vehicle INT) RETURNS BOOLEAN
-- has vehicle not yet been returned?
BEGIN

-- if is in CheckOut
-- if is NOT in CheckIn

RETURN EXISTS(SELECT _idVehicle FROM CheckOut WHERE _idVehicle = vehicle) 
	   AND 
       NOT EXISTS (SELECT _idVehicle FROM CheckIn WHERE _idVehicle = _idVehicle);

END $$

DELIMITER ;


DROP FUNCTION IF EXISTS VehicleMilesYear;

DELIMITER $$

CREATE FUNCTION VehicleMilesYear(vehicle INT, yr INT) RETURNS INT
BEGIN
DECLARE year_days INT; 
DECLARE s_date, e_date DATE;
DECLARE miles INT;

SET year_days = 365;
SET s_date = MAKEDATE(yr, 1);
SET e_date = MAKEDATE(yr, year_days + 1);

IF DAYOFMONTH(e_date) = 31 THEN
	SET e_date = MAKEDATE(yr, year_days + 2);
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


DROP FUNCTION IF EXISTS vehicleReservationMilesTravelled;

DELIMITER $$

CREATE FUNCTION vehicleReservationMilesTravelled (_reservation INT, _vehicle INT) RETURNS MEDIUMINT
BEGIN
DECLARE mileage MEDIUMINT;

SELECT ABS(OdometerEnd - OdometerStart) INTO mileage
FROM CheckOut o
INNER JOIN CheckIn i ON i._idReservation = o._idReservation AND i._idVehicle = o._idVehicle 
WHERE i._idReservation = _reservation AND i._idVehicle = _vehicle;

IF mileage IS NULL THEN
	RETURN 0;
END IF;

RETURN mileage;

END $$

DELIMITER ;




