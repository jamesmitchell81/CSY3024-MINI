DROP FUNCTION IF EXISTS allMaintenanceItemsComplete;

DELIMITER $$

CREATE FUNCTION allMaintenanceItemsComplete(m_log_number INT) RETURNS BOOLEAN
BEGIN

RETURN (SELECT idMaintenanceItem 
			  FROM MaintenanceItem 
              WHERE _MaintenanceLogNumber = m_log_number 
              AND _CompletedBy IS NULL 
              AND CompletionDate IS NULL) IS NULL;

END$$

DELIMITER ;