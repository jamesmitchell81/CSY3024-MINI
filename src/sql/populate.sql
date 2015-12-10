INSERT INTO Departments (DepartmentName)
VALUES ("Computing"), ("Business"), ("Graphic Design"), ("Art"), ("Fashion");

INSERT INTO FacultyMembers (_idDepartments, Title, FirstName, LastName, EmailAddress, OfficeNo, MobileNo)
VALUES (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Computing"),
  "Mr", "James", "Mitchell", "james@mini.ac.uk", "12345-123456", "12345-123-123"
), (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Computing"),
  "Mr", "Owen", "Routier", "owen@mini.ac.uk", "12345-123456", "12345-123-123"
), (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Art"),
  "Miss", "Isla", "Routier", "isla@mini.ac.uk", "12345-123456", "12345-123-123"
), (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Fashion"),
  "Mrs", "Sally", "Routier", "sally@mini.ac.uk", "12345-123456", "12345-123-123"
), (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Computing"),
  "Mr", "Adam", "Routier", "adam@mini.ac.uk", "12345-123456", "12345-123-123"
), (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Business"),
  "Mrs", "Sue", "Mitchell", "sue@mini.ac.uk", "12345-123456", "12345-123-123"
), (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Computing"),
  "Mr", "Simon", "Mitchell", "simon@mini.ac.uk", "12345-123456", "12345-123-123"
), (
  (SELECT idDepartments FROM Departments WHERE DepartmentName = "Graphic Design"),
  "Mrs", "Joanna", "Hatfield", "joanna@mini.ac.uk", "12345-123456", "12345-123-123"
);

-- INSERT INTO MechanicGrade (GradeName)
-- VALUES ("PartsManager", "Mechanic");?

-- INSERT INTO Mechanic (Title, FirstName, LastName, _idMechanicGrade)?

-- Types: Minibus, Car
INSERT INTO VehicleType (TypeName, Seats)
VALUES
("Hatchback", 5),
("Minibus", 12),
("Minivan", 8),
("Saloon", 5),
("SUV", 8);

INSERT INTO Manufacturers (Manufacturer)
VALUES
("Ford"),
("Volkswagen");

INSERT INTO Models (_idManufacturers, _idVehicleType, Model)
VALUES
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Hatchback" ),
  "Focus"
),
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Minibus" ),
  "Transit"
),
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Minivan" ),
  "Cargo"
),
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Ford" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Saloon" ),
  "Fusion"
),
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Hatchback" ),
  "Golf"
),
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Minibus" ),
  "Microbus"
),
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "SUV" ),
  "Touareg"
),
(
  (SELECT idManufacturers FROM Manufacturers WHERE Manufacturer = "Volkswagen" ),
  (SELECT idVehicleType FROM VehicleType WHERE TypeName = "Saloon" ),
  "Passat"
);

INSERT INTO Vehicles (_idModels, VehicleReg, MileageRate, CurrentMileage)
VALUES
( (SELECT idModels FROM Models WHERE Model = "Focus"),    "tfbs1", 1.2, 0), -- ford focus
( (SELECT idModels FROM Models WHERE Model = "Transit"),  "tfbs2", 3.6, 0), -- ford transit
( (SELECT idModels FROM Models WHERE Model = "Cargo"),    "tfbs3", 2.4, 0), -- ford cargo
( (SELECT idModels FROM Models WHERE Model = "Fusion"),   "tfbs4", 1.8, 0), -- ford fusion
( (SELECT idModels FROM Models WHERE Model = "Golf"),     "tfbs5", 1.2, 0), -- VW Golf
( (SELECT idModels FROM Models WHERE Model = "Microbus"), "tfbs6", 3.6, 0), -- VW Microbus
( (SELECT idModels FROM Models WHERE Model = "Touareg"),  "tfbs7", 2.4, 0), -- VW Touareg
( (SELECT idModels FROM Models WHERE Model = "Passat"),   "tfbs8", 1.8, 0); -- VW Passat


-- MOT Lists.
-- INSERT INTO MOTCategory (Title)
-- VALUES
-- ("Interior Checks"),
-- ("Exterior Checks"),
-- ("Under Bonnet Checks"),
-- ("Under Vehicle Checks"),
-- ("Emissions");

-- INSERT INTO MOTCheckList (_idMOTCategory, Description)
-- VALUES
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Seats and Seatbelts"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Warning Lamps"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Switches (position lamp, headlamp, hazards"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "View to front, wipers & washers"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Brake controls, servo operation"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Steering wheel & column"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Doors, mirrors, horn"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Speedometer, driver controls"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Registration plates"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Lamps, registration plate lamps"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Indicators, hazards"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Headlamps & aim"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Stop lamps, fog lamps, reflectors"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Wheels, tyres"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Shock absorbers"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Mirrors, wiper blades, fuel tank cap"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Glazing"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Doors, boot lid, loading doors, bonnet"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Towbars"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "General condition of body"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Vehicle structure"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Braking system"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Exhaust system, fuel system"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Speed limiter"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Steering & power steering components"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Suspension components"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Steering including power steering"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Drive shafts"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Suspension, shock absorbers"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Wheel bearings"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Wheels & tyres"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Brake systems & mechanical components"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Exhaust system"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Fuel system & fuel tank"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Structure, general vehicle condition"),
-- (SELECT idMOTCategory FROM MOTCategory WHERE Title = "Emissions"), "Emissions"),


-- INSERT INTO PartCategory (Name)
-- VALUES ("Oil"), ("Gauges"), ("Electrics"), ("Brakes"), ("Engine"), ("Engine Cooling"), ("Exhaust"), ("Fuel Supply");

-- Parts
-- INSERT INTO Parts (_idCategory, PartName, MinimumQuantity)
-- VALUES
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Oil"), "Oil", 10), -- Oil
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Oil"), "Oil filter", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Oil"), "Oil gasket", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Oil"), "Oil pump", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Gauges"), "Fuel gauge", 10), -- Gauges
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Gauges"), "Speedometer", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Gauges"), "Tyre pressure gauge", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Ignition coil", 10), -- Electics
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Alternator", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Battery", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Distributor", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Spark plug", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Fog Light bulb", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Headlamp bulb", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Tail light bulb", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Electrics"), "Indicator bulb", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Brakes"), "Brake pad", 10), -- Brakes
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Brakes"), "Brake drum", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Brakes"), "Brake pedal", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Brakes"), "Brake piston", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Brakes"), "Brake pump", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Brakes"), "Caliper", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine"), "Camshaft", 10), -- Engine
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine"), "Air intake housing", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine"), "Crank shaft", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine"), "Cylinder head", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine Cooling"), "Fan blade", 10), -- Engine cooling.
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine Cooling"), "Fan clutch", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine Cooling"), "Water pump", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Engine Cooling"), "Water tank", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Exhaust"), "Exhaust pipe", 10), -- Exhaust
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Exhaust"), "Catalytic converter", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Exhaust"), "Heat shield", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Exhaust"), "Exhaust gasket", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Fuel Supply"), "Air filter", 10), -- fuel supply
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Fuel Supply"), "Carburetor", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Fuel Supply"), "Fuel cell", 10),
-- ((SELECT idCategory FROM PartCategory c WHERE c.Name = "Fuel Supply"), "Fuel tank", 10),








