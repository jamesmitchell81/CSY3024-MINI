-- find all available vehciles




SELECT idVehicles FROM Vehicles
WHERE idVehicles NOT IN 
(SELECT _idVehicles FROM Reservations WHERE '2015-12-08 12:00:00' BETWEEN DepartureDate AND ReturnDueDate) 
AND idVehicles NOT IN 
(SELECT _idVehicle FROM Maintenance WHERE DateReturned IS NULL AND DateReturned > '2015-12-08 12:00:00');

SELECT * FROM Reservations;
SELECT * FROM VehicleReservation;

DROP TABLE VehicleReservation;

SELECT * FROM Billings;
DROP TABLE Billings;

SELECT * 
FROM Reservations r
WHERE idReservations NOT IN (SELECT _idReservations FROM Journey WHERE OdomenterEnd IS NULL);

SELECT * FROM Reservations;

SELECT * FROM JourneyView
            WHERE _idFacultyMembers = 1
            AND OdometerEnd IS NULL;
            
            
SELECT (OdometerEnd - OdometerStart) As TotalMiles FROM Journey WHERE _idReservations = 1 AND NOT (OdometerEnd IS NULL);


SELECT * FROM Billings;

ALTER TABLE Billings CHANGE MileageRate TotalCost FLOAT;
ALTER TABLE Billings CHANGE LitresFuelPurchased FuelCost FLOAT;

ALTER TABLE Journey CHANGE JourneyStart JourneyStart DATE;
ALTER TABLE Journey CHANGE JourneyEnd JourneyEnd DATE;

SELECT * FROM JourneyComplete;