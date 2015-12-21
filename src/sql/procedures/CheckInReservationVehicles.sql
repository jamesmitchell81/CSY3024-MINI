CREATE PROCEDURE `CheckInReservationVehicles` (IN idReservation INT, IN Agent INT, IN OdoEnd MEDIUMINT)
BEGIN
DECLARE vehicle, jump INT;
DECLARE output TEXT DEFAULT '';
DECLARE vehicles CURSOR FOR SELECT _idVehicle FROM VehicleReservation WHERE _idReservation = idReservation;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET jump = 1;

	OPEN vehicles;
    
    REPEAT
		FETCH vehicles INTO vehicle;
        
        SET output = CONCAT(output, ", ", vehicle);
        
        IF NOT EXISTS (SELECT * FROM CheckIn WHERE _idVehicle = vehicle AND _idReservation = idReservation) THEN 
	-- insert the checking
			INSERT INTO CheckIn (_idVehicle, _idReservation, _AgentIn, OdometerEnd)
			VALUES (vehicle, idReservation, Agent, OdoEnd);

		END IF;
        
	UNTIL jump = 1 END REPEAT;

	CLOSE vehicles;
    
    SELECT output;

END
