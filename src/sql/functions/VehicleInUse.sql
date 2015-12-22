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