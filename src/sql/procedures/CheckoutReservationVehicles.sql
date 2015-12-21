CREATE PROCEDURE `CheckoutReservationVehicles` (IN idReservation INT, IN Agent INT)
BEGIN
DECLARE current_mileage MEDIUMINT;
DECLARE vehicle, jump INT;
DECLARE output TEXT DEFAULT '';
DECLARE vehicles CURSOR FOR SELECT _idVehicle FROM VehicleReservation WHERE _idReservation = idReservation;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET jump = 1;

    OPEN vehicles;
    
    REPEAT
		FETCH vehicles INTO vehicle;
        
        -- provide output for debuging
        SET output = CONCAT(output, ", ", vehicle);
        
        -- get the current mileage for the vehicle of the reservation.
		SELECT CurrentMileage INTO current_mileage
		FROM Vehicle 
		WHERE idVehicle = vehicle;
		
        -- Ensure duplicate entry is not attempted
		IF NOT EXISTS (SELECT * FROM CheckOut WHERE _idVehicle = vehicle AND _idReservation = idReservation) THEN
			-- insert the detail including current mileage
			INSERT INTO CheckOut (_idVehicle, _idReservation, _AgentOut, OdometerStart)
			VALUES (vehicle, idReservation, Agent, current_mileage);
		END IF;
	
	UNTIL jump = 1 END REPEAT;
    
	CLOSE vehicles;
    
    -- for debugging.
    SELECT output;
END