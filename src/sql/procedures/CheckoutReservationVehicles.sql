CREATE PROCEDURE `CheckoutReservationVehicles` (IN idReservation INT, IN Agent INT)
BEGIN
DECLARE current_mileage MEDIUMINT;
DECLARE vehicle, jump INT;
DECLARE vehicles CURSOR FOR SELECT r._idVehicle FROM VehicleReservation r WHERE r._idReservation = idReservation;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET jump = 1;

    OPEN vehicles;
    
    REPEAT
		FETCH vehicles INTO vehicle;
        
        -- get the current mileage for the vehicle of the reservation.
		SELECT CurrentMileage INTO current_mileage
		FROM Vehicle v
		WHERE v.idVehicle = vehicle;
		
        -- Ensure duplicate entry is not attempted
		IF NOT EXISTS (SELECT * FROM CheckOut c WHERE c._idVehicle = vehicle AND c._idReservation = idReservation) THEN
			-- insert the detail including current mileage
			INSERT INTO CheckOut (_idVehicle, _idReservation, _AgentOut, OdometerStart)
			VALUES (vehicle, idReservation, Agent, current_mileage);
		END IF;
	
	UNTIL jump = 1 END REPEAT;
    
	CLOSE vehicles;
    
END