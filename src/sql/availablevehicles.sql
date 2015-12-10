SELECT 
    *
FROM
    VehicleView
WHERE
    idVehicles NOT IN (SELECT 
            _idVehicles
        FROM
            Reservations
        WHERE
            ('2015-12-10' BETWEEN DepartureDate AND ReturnDueDate)
                AND ('2015-12-10' BETWEEN DepartureDate AND ReturnDueDate))
        AND idVehicles NOT IN (SELECT 
            _idVehicle
        FROM
            Maintenance
        WHERE
            DateReturned IS NULL
                AND DateReturned > '2015-12-10')
        AND Seats >= 5
ORDER BY Seats ASC;

UPDATE Reservations SET DepartureDate = '2015-12-08 09:00:00', ReturnDueDate = '2015-12-09 17:00' WHERE idReservations = 2;