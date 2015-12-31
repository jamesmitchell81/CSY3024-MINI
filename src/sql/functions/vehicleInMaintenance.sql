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