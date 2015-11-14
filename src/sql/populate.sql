INSERT INTO Departments (DepartmentName)
VALUES ("Computing"), ("Business"), ("Graphic Design"), ("Art"), ("Fashion");

INSERT INTO FacultyMember (_idDepartment, Title, FirstName, LastName, EmailAddress)
VALUES (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Computing",
  "Mr", "James", "Mitchell", "james@mini.ac.uk"
), (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Computing",
  "Mr", "Owen", "Routier", "owen@mini.ac.uk"
), (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Art",
  "Miss", "Isla", "Routier", "isla@mini.ac.uk"
), (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Fashion",
  "Mrs", "Sally", "Routier", "sally@mini.ac.uk"
), (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Computing",
  "Mr", "Adam", "Routier", "adam@mini.ac.uk"
), (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Business",
  "Mrs", "Sue", "Mitchell", "sue@mini.ac.uk"
), (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Computing",
  "Mr", "Simon", "Mitchell", "simon@mini.ac.uk"
), (
  SELECT idDepartment FROM Departments WHERE DepartmentName = "Graphic Design",
  "Mrs", "Joanna", "Hatfield", "joanna@mini.ac.uk"
);

INSERT INTO Mechanic (Title, FirstName, LastName, ...Grade...)

-- Types: Minibus, Car
INSERT INTO Vehicles (VehicleReg, MileageRate, Type, SeatCount, CurrentMileage)
VALUES
("tfbs1", 1.2, "Hatchback", 5, 0),
("tfbs2", 3.6, "Minibus",  12, 0),
("tfbs3", 2.4, "Minivan",   8, 0),
("tfbs1", 1.8, "Saloon",    5, 0),

-- MOT Lists.
INSERT INTO MOTCategory (Title)
VALUES
("Interior Checks"),
("Exterior Checks"),
("Under Bonnet Checks"),
("Under Vehicle Checks"),
("Emissions");

INSERT INTO MOTCheckList (_idMOTCategory, Description)
VALUES
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Seats and Seatbelts"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Warning Lamps"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Switches (position lamp, headlamp, hazards"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "View to front, wipers & washers"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Brake controls, servo operation"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Steering wheel & column"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Doors, mirrors, horn"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Speedometer, driver controls"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Registration plates"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Lamps, registration plate lamps"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Indicators, hazards"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Headlamps & aim"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Stop lamps, fog lamps, reflectors"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Wheels, tyres"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Shock absorbers"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Mirrors, wiper blades, fuel tank cap"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Glazing"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Doors, boot lid, loading doors, bonnet"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "Towbars"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "External Checks"), "General condition of body"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Vehicle structure"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Braking system"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Exhaust system, fuel system"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Speed limiter"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Steering & power steering components"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Suspension components"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Steering including power steering"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Drive shafts"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Suspension, shock absorbers"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Wheel bearings"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Wheels & tyres"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Brake systems & mechanical components"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Exhaust system"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Fuel system & fuel tank"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Structure, general vehicle condition"),
(SELECT idMOTCategory FROM MOTCategory WHERE Title = "Emissions"), "Emissions"),


-- Parts
INSERT INTO PartList (PartName, MinimumQuantity)
VALUES
("Oil", 10),
("Oil filters", 10),
("Cam belts", 10),
("...", 10),



