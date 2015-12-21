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
VALUES (2, '2015-12-21', '2015-12-21', 'NN1 2DL');

SELECT isVehicleAvailable(8, '2015-12-21', '2015-12-21');
SELECT isVehicleInUse(8);

INSERT INTO VehicleReservation (_idVehicle, _idReservation)
VALUES 
(1, 2),
(2, 2),
(3, 2);

Call CheckoutReservationVehicles(2, 14);
SELECT * FROM CheckOut;

