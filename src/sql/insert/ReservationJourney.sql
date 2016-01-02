
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
(2, 2, 14, 50, 2);


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
(3, 3, 14, 45, 3);


SELECT * FROM Billings;
SELECT * FROM CheckIn;


-- Reservation 4

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (4, CURDATE(), CURDATE(), 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(5, 4);

Call CheckoutReservationVehicles(4, 14);

INSERT INTO ReportedIssues(MaintenanceIssues) VALUES ( "Ticking sound coming from the engine");
INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, _idReportedIssues)
VALUES 
(5, 4, 13, 35, 4);


-- Reservation 5

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (5, CURDATE(), CURDATE(), 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(6, 5);

Call CheckoutReservationVehicles(5, 14);

INSERT INTO ReportedIssues(MaintenanceIssues) VALUES ("Veering to the right");
INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, _idReportedIssues)
VALUES 
(6, 5, 13, 35, 5);



-- Reservation 6

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (6, CURDATE(), CURDATE(), 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(7, 6);

Call CheckoutReservationVehicles(6, 14);

INSERT INTO ReportedIssues(MaintenanceIssues) VALUES ("Rumberling under the car");
INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, _idReportedIssues)
VALUES 
(7, 6, 13, 35, 6);

-- Reservation 7

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (7, CURDATE(), CURDATE(), 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(8, 7);

Call CheckoutReservationVehicles(7, 14);

INSERT INTO ReportedIssues(MaintenanceIssues) VALUES ("Headlights flickering");
INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, _idReportedIssues)
VALUES 
(8, 7, 14, 28, 7);



