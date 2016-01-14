-- DISPLAY ALL AVAILABLE VEHICLES
SELECT * 
FROM VehicleView v
WHERE v.idVehicle NOT IN (SELECT _idVehicle FROM Maintenance WHERE DateReturned IS NULL)
AND NOT isVehicleInUse(v.idVehicle)
AND isVehicleAvailable(v.idVehicle, CURDATE(), CURDATE());


-- CHECK IF A PARTICULAR VEHICLE HAS BEEN RESERVED.
SELECT *
FROM VehicleView
WHERE isVehicleAvailable(idVehicle, CURDATE(), CURDATE());

SELECT *
FROM VehicleView
WHERE NOT isVehicleAvailable(idVehicle, CURDATE(), CURDATE());


-- For a reserved vehicle, check which department has the reservation. 
SELECT v.*, d.DepartmentName, r.DepartureDate
FROM VehicleView v
INNER JOIN VehicleReservation vr ON v.idVehicle = vr._idVehicle
INNER JOIN Reservation r ON vr._idReservation = r.idReservation
INNER JOIN FacultyMembers f ON r._idFacultyMember = f._idMINIEmployee
INNER JOIN Department d ON f._idDepartment = d.idDepartment
WHERE NOT isVehicleAvailable(v.idVehicle, CURDATE(), CURDATE());


-- Display how many vehicles each department has used so far.
SELECT *, COUNT(_idVehicle) As VehicleJourneysUsed
FROM DepartmentReservations r
INNER JOIN VehicleReservation v ON v._idReservation = r.idReservation
GROUP BY idDepartment;


-- Display the total mileage of a vehicle driven this year. 
SELECT idVehicle, VehicleMilesYear(idVehicle, YEAR(CURDATE())) AS MilesThisYear
FROM VehicleView;


-- Display the total mileage driven by a department this year.
SELECT DepartmentName, DepartmentMilesYear(idDepartment, YEAR(CURDATE())) AS MileThisYear
FROM Department;


-- Show the bill details for a selected department.
SELECT b._idReservation, d.DepartmentName, TotalCost, f.Name
FROM Billings b
INNER JOIN DepartmentReservations d ON b._idReservation = d.idReservation
INNER JOIN Reservation r ON r.idReservation = b._idReservation
INNER JOIN FacultyMemberView f ON r._idMINIEmployee = f._idMINIEmployee
WHERE idDepartment = 1;


-- Show the maintenance dates of a vehicle.
SELECT v.VehicleReg, v.Manufacturer, v.Model, v.TypeName, m.MaintenanceEntryDate, m.DateReturned
FROM Maintenance m
INNER JOIN VehicleView v ON m._idVehicle = v.idVehicle;


-- Display details of a particular maintenance including what parts are used. 
SELECT BriefDescription, ItemDescription, GROUP_CONCAT(CONCAT_WS(':', i.PartName)) AS PartsUsed
FROM MaintenanceView m
INNER JOIN PartsUsed u ON u._idMaintenanceItem = m.idMaintenanceItem
INNER JOIN PartsInventoryView i ON i.idPartsInventory = u._idPartsInventory
GROUP BY idMaintenanceItem;


-- Display those who booked vehicles but not actually used them. 
SELECT f.Name, f.DepartmentName, r.DepartureDate, r.ReturnDueDate, r.Destination, vv.VehicleReg
FROM Reservation r
INNER JOIN VehicleReservation v ON v._idReservation = r.idReservation
INNER JOIN FacultyMemberView f ON f._idMINIEmployee = r._idMINIEmployee
INNER JOIN VehicleView vv ON vv.idVehicle = v._idvehicle
WHERE v._idVehicle NOT IN (SELECT o._idVehicle FROM CheckOut o WHERE o._idReservation = r.idReservation)
AND CURDATE() > r.ReturnDueDate;
