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
