SELECT * FROM CheckOut;
SELECT * FROM CheckIn;


SELECT * FROM Billings WHERE _idReservation = 9;

SELECT * FROM VehicleView INNER JOIN VehicleReservation ON _idVehicle = idVehicle WHERE _idReservation = 9;


SELECT * FROM CurrentJourneys;

INSERT INTO Reservation (_idMINIEmployee, DepartureDate, ReturnDueDate, Destination)
VALUES (1, '2015-12-31', '2015-12-31', 'NN1 2DL');

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES (2, 10), (3, 10);

Call CheckoutReservationVehicles(10, 13);

SELECT * FROM VehicleView;

INSERT INTO CheckIn(_idVehicle, _idReservation, _AgentIn, OdometerEnd, MaintenanceIssues)
VALUES 
(2, 10, 13, 6624, "Car would not start"), -- 3.6
(3, 10, 13, 7100, "Oil Leak"); -- 2.4


SELECT * FROM CurrentJourneys;
SELECT * FROM CompletedJourneys;

SELECT * FROM PartsUsed;

SELECT * FROM Reservation;
SELECT * FROM Maintenance WHERE _ReturnedBy IS NULL; -- 4, 6, 1
SELECT * FROM VehicleView WHERE NOT isVehicleAvailable(idVehicle, CURDATE(), CURDATE()); -- 5, 7
SELECT * FROM Vehicle;
