CREATE DEFINER = CURRENT_USER TRIGGER `MINI`.`CheckIn_AFTER_UPDATE` AFTER UPDATE ON `CheckIn` FOR EACH ROW
BEGIN

	-- update the vehicle.currentmileage
	UPDATE Vehicle SET CurrentMileage = new.OdometerEnd WHERE idVehicle = new._idVehicle;

END
