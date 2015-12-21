-- Types: Minibus, Car
INSERT INTO VehicleType (TypeName, Seats, MileageRate)
VALUES
("Hatchback", 5, 1.2),
("Minibus", 12, 3.6),
("Minivan", 8, 2.4),
("Saloon", 5, 1.8),
("SUV", 8, 2.4);

INSERT INTO Manufacturer (Manufacturer)
VALUES
("Ford"),
("Volkswagen");

INSERT INTO Model (_idManufacturer, _idVehicleType, Model)
VALUES
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Hatchback" ),
  "Focus"
),
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Minibus" ),
  "Transit"
),
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Minivan" ),
  "Cargo"
),
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Saloon" ),
  "Fusion"
),
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Hatchback" ),
  "Golf"
),
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Minibus" ),
  "Microbus"
),
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "SUV" ),
  "Touareg"
),
(
  (SELECT idManufacturer FROM Manufacturer WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Saloon" ),
  "Passat"
);

INSERT INTO Vehicle (_idModel, VehicleReg, CurrentMileage)
VALUES
( (SELECT idModel FROM Model WHERE Model = "Focus"),    "tfbs1", 0), -- ford focus
( (SELECT idModel FROM Model WHERE Model = "Transit"),  "tfbs2", 0), -- ford transit
( (SELECT idModel FROM Model WHERE Model = "Cargo"),    "tfbs3", 0), -- ford cargo
( (SELECT idModel FROM Model WHERE Model = "Fusion"),   "tfbs4", 0), -- ford fusion
( (SELECT idModel FROM Model WHERE Model = "Golf"),     "tfbs5", 0), -- VW Golf
( (SELECT idModel FROM Model WHERE Model = "Microbus"), "tfbs6", 0), -- VW Microbus
( (SELECT idModel FROM Model WHERE Model = "Touareg"),  "tfbs7", 0), -- VW Touareg
( (SELECT idModel FROM Model WHERE Model = "Passat"),   "tfbs8", 0); -- VW Passat
