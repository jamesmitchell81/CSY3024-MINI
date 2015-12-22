CREATE PROCEDURE `updateCostAtCheckIn` (IN _reservation INT, IN _vehicle INT)
BEGIN
DECLARE miles_traveled MEDIUMINT;
DECLARE mileage_rate, new_cost FLOAT;
DECLARE current_cost FLOAT;

SET miles_traveled = vehicleReservationMilesTravelled(_reservation, _vehicle);
SELECT MileageRate INTO mileage_rate FROM VehicleView WHERE idVehicle = _vehicle;

SET new_cost = (miles_traveled * mileage_rate);

IF NOT EXISTS (SELECT _idReservation FROM Billings WHERE _idReservation = _reservation) THEN
	INSERT INTO Billings (_idReservation, TotalCost)
    VALUES (_reservation, new_cost);
ELSE 
	SELECT TotalCost INTO current_cost FROM Billings WHERE _idReservation = _reservation;
	SET new_cost = new_cost + current_cost;
	UPDATE Billings SET TotelCost = new_cost WHERE _idReservation = _reservation;
END IF;

END
