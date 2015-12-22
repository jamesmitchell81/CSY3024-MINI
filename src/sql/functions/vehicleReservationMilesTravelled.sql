-- SET miles_traveled = vehicleReservationMilesTravelled(_reservation, _vehicle);
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