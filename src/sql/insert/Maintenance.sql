-- General Maintenance
SELECT * FROM Maintenance;

-- Create a General Maintenance.
-- INSERT INTO Maintenance (_idVehicle, BriefDescription, MaintenanceEntryDate)
SELECT v.idVehicle, v.VehicleReg, CONCAT_WS(' ', v.Model, v.Manufacturer) AS Vehicle, i.MaintenanceIssues
FROM CheckIn i
INNER JOIN VehicleView v ON i._idVehicle = v.idVehicle
WHERE MaintenanceIssues IS NOT NULL
AND NOT (_idVehicle IN (SELECT m._idVehicle 
						FROM Maintenance m WHERE m.BriefDescription = i.MaintenanceIssues
						AND DateReturned IS NULL AND m._idVehicle = i._idVehicle));

SELECT * FROM CheckIn;

SELECT * FROM  Maintenance l
            INNER JOIN VehicleView v ON v.idVehicle = l._idVehicle;

SELECT m._idVehicle 
FROM Maintenance m 
WHERE DateReturned IS NULL;

SELECT * FROM Maintenance;

-- Outstanding Maintenance. (Not picked up)
SELECT *
FROM Maintenance
WHERE MaintenanceLogNumber NOT IN (SELECT _MaintenanceLogNumber FROM MaintenanceItem);

-- Create an example maintenance item record
INSERT INTO MaintenanceItem (_MaintenanceLogNumber, ItemDescription)
SELECT MaintenanceLogNumber, BriefDescription
FROM Maintenance
WHERE _ReturnedBy IS NULL AND DateReturned IS NULL;


INSERT INTO MaintenanceItem (_MaintenanceLogNumber, ItemDescription)
VALUES 
(5, "Fix Puncture, Reinflate Tyres"),
(6, "Replace light blubs"),
(5, "Locate and fix oil leak");

-- Outstanding Maintenance. (picked up not complete)
SELECT *
FROM Maintenance
WHERE MaintenanceLogNumber IN (SELECT _MaintenanceLogNumber 
							   FROM MaintenanceItem) 
                               AND (_ReturnedBy IS NULL OR DateReturned IS NULL);

-- Mark the maintenance item complete.
UPDATE MaintenanceItem 
SET 
    _CompletedBy = 9,
    CompletionDate = CURRENT_TIMESTAMP
WHERE
    _MaintenanceLogNumber = 1;
    
-- Quickly mark all complete
UPDATE MaintenanceItem
SET 
	_CompletedBy = 10,
    CompletionDate = CURRENT_TIMESTAMP
WHERE 
	_CompletedBy IS NULL AND CompletionDate IS NULL;


SELECT * FROM Maintenance;
SELECT * FROM MaintenanceItem WHERE _MaintenanceLogNumber = 1;

UPDATE Maintenance
SET 
	_ReturnedBy = 11,
    DateReturned = CURRENT_TIMESTAMP
WHERE 
	_ReturnedBy IS NULL AND DateReturned IS NULL;

SELECT * FROM Maintenance;

-- Return Vehicle from Maintenance
UPDATE Maintenance
SET
	_ReturnedBy = 10,
    DateReturned = CURRENT_TIMESTAMP
WHERE
	MaintenanceLogNumber = 1;

-- General Maintenance complete.
SELECT *
FROM Maintenance
WHERE MaintenanceLogNumber IN (SELECT _MaintenanceLogNumber 
							  FROM MaintenanceItem 
                              WHERE (_CompletedBy IS NOT NULL
                              AND CompletionDate IS NOT NULL))
AND (_ReturnedBy IS NOT NULL
AND DateReturned IS NOT NULL);

-- Determine if MOT maintenance is required on a vehicle.
SELECT m._idVehicle
FROM Maintenance m
WHERE (DATEDIFF(NOW(), DateReturned) >= 1)
AND MaintenanceLogNumber IN (SELECT _MaintenanceLogNumber FROM MOTCheckListItem);

SELECT * FROM Maintenance;            

INSERT INTO Maintenance (_idVehicle, _ReturnedBy, BriefDescription, MaintenanceEntryDate, DateReturned)
VALUES (1, 10, "MOT Check", DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR));

-- Create MOT Check List Items
INSERT INTO MOTCheckListItem (_MaintenanceLogNumber, _idMOTCheckList, _Mechanic, CheckPerformedDate)
SELECT 8, idMOTCheckList, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR)
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

SELECT * FROM PartsInventoryView;
-- Procedure: Assign a part to a maintenanceitem.
Call UsePart(10, 1, 4, @location);

Call UsePart(10, 2, 5, @location);

-- Trigger/Procedure: Prevent MOT logs from being marked complete if not all MOTItems pass
-- Prevent Vehicles being reserved/checkout when under maintenance.

-- Required Queries.
-- Check Assignment Brief for anything else that is needed.



SELECT _idVehicle FROM CheckIn WHERE MaintenanceIssues IS NOT NULL;


SELECT * FROM VehicleReportedIssues;



SELECT * FROM Maintenance;

Call UsePart(10, 8, 19, @location); 
SELECT @location;

SELECT * FROM MaintenanceItem;

INSERT INTO MOTCheckListItem (_MaintenanceLogNumber, _idMOTCheckList, _Mechanic, CheckPerformedDate)
SELECT 8, idMOTCheckList, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR)
FROM MOTCheckList;

UPDATE Maintenance 
SET DateReturned = NULL 
WHERE MaintenanceLogNumber = 1;


SHOW TRIGGERS;


