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

DROP FUNCTION IF EXISTS isVehicleInUse;

-- has vehicle not yet been returned?
CREATE FUNCTION isVehicleInUse (vehicle INT) RETURNS BOOLEAN
BEGIN

-- if is in CheckOut
-- if is NOT in CheckIn

RETURN EXISTS(
	SELECT _idVehicle
	FROM CheckOut o
	INNER JOIN CheckIn i ON i._idVehicle = o._idVehicle AND i._idReservation = o._idReservation
    WHERE _idVehicle = vehicle;
);

DELIMITER ;