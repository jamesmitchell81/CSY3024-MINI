-- find all available vehciles




SELECT idVehicles FROM Vehicles
WHERE idVehicles NOT IN 
(SELECT _idVehicles FROM Reservations WHERE '2015-12-08 12:00:00' BETWEEN DepartureDate AND ReturnDueDate) 
AND idVehicles NOT IN 
(SELECT _idVehicle FROM Maintenance WHERE DateReturned IS NULL AND DateReturned > '2015-12-08 12:00:00');