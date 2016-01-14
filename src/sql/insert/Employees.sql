-- MINI Faculty Members
INSERT INTO MINIEmployee (Title, FirstName, LastName, EmailAddress, OfficeNo)
VALUES 
("Mr", "James", "Mitchell", "james@mini.ac.uk", "12345-123456"),
("Mr", "Owen", "Routier", "owen@mini.ac.uk", "12345-123456"),
("Miss", "Isla", "Routier", "isla@mini.ac.uk", "12345-123456"),
("Mrs", "Sally", "Routier", "sally@mini.ac.uk", "12345-123456"),
("Mr", "Adam", "Routier", "adam@mini.ac.uk", "12345-123456"),
("Mrs", "Sue", "Mitchell", "sue@mini.ac.uk", "12345-123456"),
("Mr", "Simon", "Mitchell", "simon@mini.ac.uk", "12345-123456"),
("Mrs", "Joanna", "Hatfield", "joanna@mini.ac.uk", "12345-123456");

-- MINI Mechanics
INSERT INTO MINIEmployee (Title, FirstName, LastName, EmailAddress, OfficeNo)
VALUES 
("Mr", "Jonnie", "Jackson", "jonnie@mini.ac.uk", "12345-654321"),
("Mr", "Johann", "Gudmonsson", "johannn@mini.ac.uk", "12345-654321"),
("Mr", "Chris", "Powell", "chris@mini.ac.uk", "12345-654321"),
("Mr", "Ademola", "Lookman", "ademola@mini.ac.uk", "12345-654321");

-- MINI Agents
INSERT INTO MINIEmployee (Title, FirstName, LastName, EmailAddress, OfficeNo)
VALUES 
("Mr", "Reza", "Ghoochannejhad", "reza@mini.ac.uk", "12345-345678"),
("Mr", "Chris", "Solly", "chris.solly@mini.ac.uk", "12345-345678");

INSERT INTO Department (DepartmentName)
VALUES ("Computing"), ("Business"), ("Graphic Design"), ("Art"), ("Fashion");

INSERT INTO FacultyMembers (_idMINIEmployee, _idDepartment, MobileNo)
VALUES 
(1, (SELECT idDepartment FROM Department WHERE DepartmentName = "Computing"), "12345-123-123"), 
(2, (SELECT idDepartment FROM Department WHERE DepartmentName = "Computing"),"12345-123-123"),
(3, (SELECT idDepartment FROM Department WHERE DepartmentName = "Art"), "12345-123-123"),
(4, (SELECT idDepartment FROM Department WHERE DepartmentName = "Fashion"), "12345-123-123"),
(5, (SELECT idDepartment FROM Department WHERE DepartmentName = "Computing"), "12345-123-123"),
(6, (SELECT idDepartment FROM Department WHERE DepartmentName = "Business"), "12345-123-123"),
(7, (SELECT idDepartment FROM Department WHERE DepartmentName = "Computing"), "12345-123-123"),
(8, (SELECT idDepartment FROM Department WHERE DepartmentName = "Graphic Design"), "12345-123-123");

INSERT INTO MechanicRole (Title) 
VALUES 
("Parts Manager"),
("Mechanic"),
("Trainee");

INSERT INTO Mechanic (_idMINIEmployee, _idMechanicRole)
VALUES 
(9, 2),
(10, 2),
(11, 1),
(12, 3);

INSERT INTO TFBSAgent (_idMINIEmployee)
VALUE (13), (14);


INSERT INTO MINICreditCards (MINICreditCardsNum, _idMINIEmployee)
VALUES 
("1234567890123456", 1),
("2345678901234561", 2),
("3456789012345612", 3),
("4567890123456123", 4),
("5678901234561234", 5),
("6789012345612345", 6),
("7890123456123456", 7),
("8901234561234567", 8);

INSERT INTO MINICardDetails (_MINICreditCardsNum, IssueNumber, ValidFromMonth, ValidFromYear, ExpiresMonth, ExpiresYear)
VALUES 
("1234567890123456", "01", 10, 2012, 10, 2015),
("2345678901234561", "01", 10, 2012, 10, 2016),
("3456789012345612", "01", 10, 2012, 10, 2016),
("4567890123456123", "01", 10, 2012, 10, 2016),
("5678901234561234", "01", 10, 2012, 10, 2016),
("6789012345612345", "01", 10, 2012, 10, 2016),
("7890123456123456", "01", 10, 2012, 10, 2016),
("8901234561234567", "01", 10, 2012, 10, 2016),
("1234567890123456", "02", 10, 2015, 10, 2019);



SELECT * FROM MechanicView;
SELECT * FROM FacultyMemberView;


