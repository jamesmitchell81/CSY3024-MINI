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




-- Display the total mileage of a vehicle driven this year. 
SELECT idVehicle, VehicleMilesYear(idVehicle, YEAR(CURDATE()))
FROM VehicleView;


-- Display the total mileage driven by a department this year.
SELECT * FROM CompletedJourneys;



-- Show the bill details for a selected department.




-- Show the maintenance dates of a vehicle.





-- Display details of a particular maintenance including what parts are used. 




-- Display those who booked vehicles but not actually used them. 

