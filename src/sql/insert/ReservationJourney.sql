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


SELECT * FROM TFBSAgent;


-- Reservation is checked out
INSERT INTO CheckOut (_idVehicle, _idReservation, _AgentOut)
VALUES 
(1, 1, 13),
(2, 1, 13),
(3, 1, 13);




