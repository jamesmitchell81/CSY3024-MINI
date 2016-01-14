INSERT INTO MOTCategory (Title)
VALUES
("Interior Checks"),
("Exterior Checks"),
("Under Bonnet Checks"),
("Under Vehicle Checks"),
("Emissions");

INSERT INTO MOTCheckList (_idMOTCategory, Description)
VALUES
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Seats and Seatbelts"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Warning Lamps"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Switches (position lamp, headlamp, hazards"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "View to front, wipers & washers"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Brake controls, servo operation"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Steering wheel & column"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Doors, mirrors, horn"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Interior Checks"), "Speedometer, driver controls"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Registration plates"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Lamps, registration plate lamps"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Indicators, hazards"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Headlamps & aim"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Stop lamps, fog lamps, reflectors"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Wheels, tyres"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Shock absorbers"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Mirrors, wiper blades, fuel tank cap"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Glazing"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Doors, boot lid, loading doors, bonnet"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "Towbars"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Exterior Checks"), "General condition of body"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Vehicle structure"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Braking system"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Exhaust system, fuel system"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Speed limiter"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Steering & power steering components"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Bonnet Checks"), "Suspension components"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Steering including power steering"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Drive shafts"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Suspension, shock absorbers"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Wheel bearings"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Wheels & tyres"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Brake systems & mechanical components"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Exhaust system"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Fuel system & fuel tank"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Under Vehicle Checks"), "Structure, general vehicle condition"),
((SELECT idMOTCategory FROM MOTCategory WHERE Title = "Emissions"), "Emissions");


SELECT * FROM MOTListView;