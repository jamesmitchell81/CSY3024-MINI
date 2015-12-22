-- General Maintenance
SELECT * FROM Maintenance;

INSERT INTO Maintenance (_idVehicle, BriefDescription, MaintenanceEntryDate)
SELECT 
    i._idVehicle, i.MaintenanceIssues, CURRENT_TIMESTAMP
FROM
    CheckIn i
WHERE
    MaintenanceIssues IS NOT NULL
        AND NOT (_idVehicle IN (SELECT 
            m._idVehicle
        FROM
            Maintenance m
        WHERE
            m.BriefDescription = i.MaintenanceIssues
                AND DateReturned IS NULL
                AND m._idVehicle = i._idVehicle));


-- Outstanding Maintenance. (Not picked up)
SELECT 
    *
FROM
    Maintenance
WHERE
    MaintenanceLogNumber NOT IN (SELECT 
            _MaintenanceLogNumber
        FROM
            MaintenanceItem);


INSERT INTO MaintenanceItem (_MaintenanceLogNumber, ItemDescription)
SELECT MaintenanceLogNumber, BriefDescription
FROM Maintenance
WHERE MaintenanceLogNumber = 1;

-- Outstanding Maintenance. (picked up not complete)
SELECT 
    *
FROM
    Maintenance
WHERE
    MaintenanceLogNumber IN (SELECT 
            _MaintenanceLogNumber
        FROM
            MaintenanceItem)
        AND (_ReturnedBy IS NULL
        OR DateReturned IS NULL);

UPDATE MaintenanceItem 
SET 
    _CompletedBy = 9,
    CompletionDate = CURRENT_TIMESTAMP
WHERE
    _MaintenanceLogNumber = 1;

-- add a part to be used.
INSERT INTO PartsUsed (_idPartsInventory, _MechanicOut, _idMaintenanceItem, DateOut)
VALUES (1, 10, 1, CURRENT_TIMESTAMP);

-- General Maintenance complete.
SELECT 
    *
FROM
    Maintenance
WHERE
    MaintenanceLogNumber IN (SELECT 
            _MaintenanceLogNumber
        FROM
            MaintenanceItem
        WHERE
            (_CompletedBy IS NOT NULL
                AND CompletionDate IS NOT NULL))
        AND (_ReturnedBy IS NOT NULL
        AND DateReturned IS NOT NULL);



-- Determine if maintenance is required on a vehicle.

SELECT 
    m._idVehicle
FROM
    Maintenance m
WHERE
    ((NOW() - YEAR(DateReturned)) > 1)
        AND MaintenanceLogNumber IN (SELECT 
            _MaintenanceLogNumber
        FROM
            MOTCheckListItem)
            


-- INSERT INTO Maintenance (1, 


-- Create MOT Check List Items
-- INSERT INTO MOTCheckListItem (_MaintenanceLogNumber, _idMOTCheckList, _MechanicIn











