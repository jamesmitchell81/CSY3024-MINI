ALTER TABLE FacultyMembers CHANGE MoblieNo MobileNo VARCHAR(45);


DROP DATABASE MINI;


USE MINI;
SHOW TABLES;

SELECT * FROM Journey;

DELETE FROM Reservations;

SELECT * FROM Departments;
SELECT * FROM Vehicles;
SELECT * FROM VehicleType;
SELECT * FROM FacultyMembers;
SELECT * FROM Reservations;
SELECT * FROM Journey;

-- views
SELECT * FROM VehicleView;
SELECT * FROM FacultyMembersView;
SELECT * FROM JourneyView;

TRUNCATE TABLE Billings;
TRUNCATE TABLE Departments;
TRUNCATE TABLE FacultyMembers;
TRUNCATE TABLE Journeys;
TRUNCATE TABLE Manufacturers;
TRUNCATE TABLE Models;
TRUNCATE TABLE ReservationStatusCode;
TRUNCATE TABLE Reservations;
TRUNCATE TABLE VehicleType;
TRUNCATE TABLE Vehicles;
