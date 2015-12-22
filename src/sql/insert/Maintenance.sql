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
SELECT * 
FROM Maintenance
WHERE MaintenanceLogNumber NOT IN (SELECT _MaintenanceLogNumber FROM MaintenanceItem);

INSERT INTO MaintenanceItem (_MaintenanceLogNumber, ItemDescription)
SELECT MaintenanceLogNumber, BriefDescription
FROM Maintenance
WHERE MaintenanceLogNumber = 1;

-- Outstanding Maintenance. (picked up not complete)
SELECT * 
FROM Maintenance
WHERE MaintenanceLogNumber IN (SELECT _MaintenanceLogNumber FROM MaintenanceItem)
AND (_ReturnedBy IS NULL OR DateReturned IS NULL);


-- General Maintenance complete.
SELECT * 
FROM Maintenance
WHERE MaintenanceLogNumber IN (SELECT _MaintenanceLogNumber FROM MaintenanceItem)
AND (_ReturnedBy IS NOT NULL AND DateReturned IS NOT NULL);
