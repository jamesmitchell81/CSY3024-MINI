

-- GENERAL MAINTENANCE

SELECT * FROM VehicleReportedIssues;

SELECT * FROM VehicleView WHERE isVehicleInMaintenance(idVehicle) IS TRUE;

-- Create a General Maintenance.
INSERT INTO Maintenance (_idVehicle, BriefDescription, MaintenanceEntryDate)
SELECT i._idVehicle, r.MaintenanceIssues, NOW()
FROM CheckIn i
INNER JOIN ReportedIssues r ON i._idReportedIssues = r.idReportedIssues
WHERE r._MaintenanceLogNumber IS NULL;


-- Show CRUD


SELECT MaintenanceLogNumber, idMaintenanceItem, ItemDescription FROM MaintenanceView;


-- SHOW TRIGGER



-- General Maintenance complete.
SELECT *
FROM Maintenance
WHERE MaintenanceLogNumber IN (SELECT _MaintenanceLogNumber 
							  FROM MaintenanceItem 
                              WHERE (_CompletedBy IS NOT NULL
                              AND CompletionDate IS NOT NULL))
AND (_ReturnedBy IS NOT NULL
AND DateReturned IS NOT NULL);



-- MOT "Safety Checks"


-- Create a MOT MaintenanceItem for a year ago.
INSERT INTO Maintenance (_idVehicle, _ReturnedBy, BriefDescription, MaintenanceEntryDate, DateReturned)
VALUES (1, 10, "MOT Check", DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR));


SELECT * FROM Maintenance;

-- Create MOT Check List Items
INSERT INTO MOTCheckListItem (_MaintenanceLogNumber, _idMOTCheckList, _Mechanic, CheckPerformedDate)
SELECT 2, idMOTCheckList, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR)
FROM MOTCheckList;


-- Determine if MOT maintenance is required on a vehicle.
SELECT m._idVehicle
FROM Maintenance m
WHERE (DATEDIFF(NOW(), DateReturned) >= 1)
AND MaintenanceLogNumber IN (SELECT _MaintenanceLogNumber FROM MOTCheckListItem);


-- Create a MOT MaintenanceItem for this year.
INSERT INTO Maintenance (_idVehicle, BriefDescription, MaintenanceEntryDate)
VALUES (1, "MOT Check", NOW());

SELECT * FROM Maintenance WHERE BriefDescription = "MOT Check";

-- Create MOT Check List Items
INSERT INTO MOTCheckListItem (_MaintenanceLogNumber, _idMOTCheckList, _Mechanic, CheckPerformedDate)
SELECT 3, idMOTCheckList, 10, NOW()
FROM MOTCheckList;


SELECT * FROM MOTCheckListItem c WHERE c._MaintenanceLogNumber = 3;


-- Find the MOTCheckListItems that did not pass.
SELECT Title, Description, Passed
FROM MOTCheckListItem c
INNER JOIN MOTListView v ON c._idMOTCheckList = v.idMOTCheckList
WHERE c._MaintenanceLogNumber = 3
AND Passed IS FALSE;


-- Create MaintenanceItems for MOTCheckListItems that did not pass.
INSERT INTO MaintenanceItem(_MaintenanceLogNumber, ItemDescription)
SELECT i._MaintenanceLogNumber, CONCAT_WS(' - ', l.Title, l.Description) AS ItemDescription
FROM MOTCheckListItem i
INNER JOIN MOTListView l ON i._idMOTCheckList = l.idMOTCheckList
WHERE i._MaintenanceLogNumber = 3
AND NOT i.Passed;


SELECT * FROM MaintenanceItem WHERE _MaintenanceLogNumber = 3;

-- Now to use some parts.
SELECT * FROM PartsStockView;

-- CREATE PROCEDURE `UsePart` (IN mechanic INT, IN maintenance_item INT, IN part_type INT)
Call UsePart(10, 4, 4);

Call UsePart(10, 5, 5);


SELECT * FROM PartsStockView;


