
SELECT * FROM CheckIn;

SELECT r.idReportedIssues, i._idReservation, v.idVehicle, v.VehicleReg, 
	   CONCAT_WS(' ', v.Model, v.Manufacturer) AS Vehicle, r.MaintenanceIssues, i.CheckInDate AS ReportedDate
FROM CheckIn i
INNER JOIN VehicleView v ON i._idVehicle = v.idVehicle
INNER JOIN ReportedIssues r ON i._idReportedIssues = r.idReportedIssues
WHERE r.MaintenanceIssues IS NOT NULL
AND (_MaintenanceLogNumber IS NULL OR
NOT (_MaintenanceLogNumber IN (SELECT m.MaintenanceLogNumber
							   FROM Maintenance m 
                               WHERE DateReturned IS NULL)));

SELECT * FROM Reservation;

-- Reservation 1

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (1, '2015-12-31', '2015-12-31', 'NN1 2DL');

INSERT INTO VehicleReservation
VALUES 
(1, 1);

Call CheckoutReservationVehicles(1, 13);

INSERT INTO ReportedIssues(MaintenanceIssues) VALUES ("Brake lights are not working");


INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, _idReportedIssues)
VALUES 
(1, 1, 13, 30, 1);


-- Reservation 2

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (2, '2015-12-31', '2015-12-31', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(2, 2);

Call CheckoutReservationVehicles(2, 13);

INSERT INTO ReportedIssues(MaintenanceIssues) VALUES ("Brakes are Hard!");

INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, _idReportedIssues)
VALUES 
(2, 2, 14, 50, 3);


-- Reservation 3

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (3, '2015-12-31', '2015-12-31', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(3, 3);

Call CheckoutReservationVehicles(3, 13);

INSERT INTO ReportedIssues(MaintenanceIssues) VALUES ( "Engine making high pitched noise");

INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, _idReportedIssues)
VALUES 
(3, 3, 14, 45, 4);


SELECT * FROM Billings;
SELECT * FROM CheckIn;

