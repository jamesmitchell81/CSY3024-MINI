
SELECT * FROM Reservation;

-- Reservation 1

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (1, '2015-12-31', '2015-12-31', 'NN1 2DL');

INSERT INTO VehicleReservation
VALUES 
(1, 1);

Call CheckoutReservationVehicles(1, 13);

INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, MaintenanceIssues)
VALUES 
(1, 1, 13, 30, "Brake lights are not working");


-- Reservation 2

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (2, '2015-12-31', '2015-12-31', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(2, 2);

Call CheckoutReservationVehicles(2, 13);

INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, MaintenanceIssues)
VALUES 
(2, 2, 14, 50, "Brakes are Hard!");


-- Reservation 3

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (3, '2015-12-31', '2015-12-31', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(3, 3);

Call CheckoutReservationVehicles(3, 13);

INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, MaintenanceIssues)
VALUES 
(3, 3, 14, 45, "Engine making high pitched noise");


SELECT * FROM Billings;
SELECT * FROM CheckIn;

