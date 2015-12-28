-- Create a new reservation
--  With 3 vehicles

-- Insert the reservation
INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (1, '2015-12-21', '2015-12-21', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 1),
(2, 1),
(3, 1);

Call CheckoutReservationVehicles(1, 13);
Call CheckInReservationVehicles(1, 14, 1000);

-- Test to ensure a vehicle in use etc.
INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (2, '2015-12-22', '2015-12-22', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 2),
(2, 2),
(3, 2);

Call CheckoutReservationVehicles(2, 14);
Call CheckInReservationVehicles(2, 14, 2500);

-- Test to ensure a vehicle in use etc.
INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (3, '2015-12-23', '2015-12-23', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 3),
(2, 3),
(3, 3);

Call CheckoutReservationVehicles(3, 14);
Call CheckInReservationVehicles(3, 14, 3500);


-- Test to ensure a vehicle in use etc.
INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (4, '2015-12-24', '2015-12-24', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 4),
(2, 4),
(3, 4);

Call CheckoutReservationVehicles(4, 14);
Call CheckInReservationVehicles(4, 14, 4500);


-- Test to ensure a vehicle in use etc.
INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (5, '2015-12-25', '2015-12-25', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 5),
(2, 5),
(3, 5);

Call CheckoutReservationVehicles(5, 14);
Call CheckInReservationVehicles(5, 14, 4500);

INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (5, '2015-12-26', '2015-12-26', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 6),
(2, 6),
(3, 6);

Call CheckoutReservationVehicles(6, 14);
Call CheckInReservationVehicles(6, 14, 4500);

INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (5, '2015-12-27', '2015-12-27', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 7),
(2, 7),
(3, 7);

Call CheckoutReservationVehicles(7, 14);
Call CheckInReservationVehicles(7, 14, 5500);

SELECT * FROM Billings;


INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (5, '2015-12-28', '2015-12-28', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 8),
(2, 8),
(3, 8);

Call CheckoutReservationVehicles(8, 14);
Call CheckInReservationVehicles(8, 14, 5500);

SELECT * FROM Billings;



INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (5, '2015-12-29', '2015-12-29', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 9),
(2, 9),
(3, 9);

Call CheckoutReservationVehicles(9, 14);
Call CheckInReservationVehicles(9, 14, 6500);


INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (5, '2015-12-30', '2015-12-30', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 10),
(2, 10),
(3, 10);

Call CheckoutReservationVehicles(10, 14);
-- Call CheckInReservationVehicles(10, 14, 7500);


INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, MaintenanceIssues)
VALUES 
(1, 10, 13, 7500, "The Brakes at soft"), -- 1.2
(2, 10, 13, 6525, "Car would not start"), -- 3.6
(3, 10, 13, 7000, "Oil Leak"); -- 2.4

SELECT * FROM Billings;

SELECT _idVehicle FROM CheckIn WHERE MaintenanceIssues IS NOT NULL;

INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (5, '2016-01-01', '2016-01-01', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(4, 11),
(5, 11),
(6, 11);

Call CheckoutReservationVehicles(11, 14);

INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, MaintenanceIssues)
VALUES 
(4, 11, 13, 30, "The tyres are flat"), -- 1.2
(5, 11, 13, 30, "The lights do not work"), -- 3.6
(6, 11, 13, 40, "Oil Leaking"); -- 2.4

SELECT * FROM Checkout;

SELECT * FROM CurrentJourneys;


-- Make a Reservation where only some cars are checkedout.
INSERT INTO Reservation (_idFacultyMember, DepartureDate, ReturnDueDate, Destination)
VALUES (1, '2015-12-24', '2015-12-24', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(4, 12),
(5, 12),
(6, 12);

INSERT INTO CheckOut (_idVehicle, _idReservation, _AgentOut, OdometerStart)
VALUES 
(4, 12, 13, (SELECT CurrentMileage FROM Vehicle WHERE idVehicle = 4)),
(5, 12, 13, (SELECT CurrentMileage FROM Vehicle WHERE idVehicle = 5));

Call CheckInReservationVehicles(12, 14, 40);

SELECT * FROM CurrentJourneys;

SELECT * FROM Vehicle;
