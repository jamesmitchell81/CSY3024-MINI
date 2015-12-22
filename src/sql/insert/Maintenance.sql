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
    (DATEDIFF(NOW(), DateReturned) >= 1)
        AND MaintenanceLogNumber IN (SELECT 
            _MaintenanceLogNumber
        FROM
            MOTCheckListItem);
            


INSERT INTO Maintenance (_idVehicle, _ReturnedBy, BriefDescription, MaintenanceEntryDate, DateReturned)
VALUES (1, 10, "MOT Check", DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR));


SELECT * FROM Maintenance;


-- Create MOT Check List Items
INSERT INTO MOTCheckListItem (_MaintenanceLogNumber, _idMOTCheckList, _Mechanic, CheckPerformedDate)
SELECT 4, idMOTCheckList, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR)
FROM MOTCheckList;

SELECT * FROM MOTCheckListItem;

-- Find the MOTCheckListItems that did not pass.
SELECT * 
FROM MOTCheckListItem
WHERE NOT Passed;

-- Create MaintenanceItems for MOTCheckListItems that did not pass.
INSERT INTO MaintenanceItem(_MaintenanceLogNumber, ItemDescription)
SELECT i._MaintenanceLogNumber, CONCAT_WS(' - ', l.Title, l.Description) AS ItemDescription
FROM MOTCheckListItem i
INNER JOIN MOTListView l ON i._idMOTCheckList = l.idMOTCheckList
WHERE i._MaintenanceLogNumber = 4
AND NOT i.Passed;

SELECT * FROM MaintenanceItem WHERE _MaintenanceLogNumber = 4;


-- TO DO

-- Prevent MOT logs from being marked complete if not all MOTItems pass
-- Prevent Vehicles being reserved/checkout when under miantenance.
-- Required Queries.

-- Check Assignment Brief for anything else that is needed.






