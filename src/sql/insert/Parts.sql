INSERT INTO PartCategory (PartCategoryName)
VALUES ("Oil"), ("Gauges"), ("Electrics"), ("Brakes"), ("Engine"), ("Engine Cooling"), ("Exhaust"), ("Fuel Supply");


INSERT INTO PartType (_idPartCategory, PartName, MinimumQuantity)
VALUES
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Oil"), "Oil", 10), -- Oil
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Oil"), "Oil filter", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Oil"), "Oil gasket", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Oil"), "Oil pump", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Gauges"), "Fuel gauge", 10), -- Gauges
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Gauges"), "Speedometer", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Gauges"), "Tyre pressure gauge", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Ignition coil", 10), -- Electics
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Alternator", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Battery", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Distributor", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Spark plug", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Fog Light bulb", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Headlamp bulb", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Tail light bulb", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Electrics"), "Indicator bulb", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Brakes"), "Brake pad", 10), -- Brakes
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Brakes"), "Brake drum", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Brakes"), "Brake pedal", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Brakes"), "Brake piston", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Brakes"), "Brake pump", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Brakes"), "Caliper", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine"), "Camshaft", 10), -- Engine
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine"), "Air intake housing", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine"), "Crank shaft", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine"), "Cylinder head", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine Cooling"), "Fan blade", 10), -- Engine cooling.
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine Cooling"), "Fan clutch", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine Cooling"), "Water pump", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Engine Cooling"), "Water tank", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Exhaust"), "Exhaust pipe", 10), -- Exhaust
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Exhaust"), "Catalytic converter", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Exhaust"), "Heat shield", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Exhaust"), "Exhaust gasket", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Fuel Supply"), "Air filter", 10), -- fuel supply
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Fuel Supply"), "Carburettor", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Fuel Supply"), "Fuel cell", 10),
((SELECT idPartCategory FROM PartCategory c WHERE c.PartCategoryName = "Fuel Supply"), "Fuel tank", 10);

INSERT INTO SundryItem (Name, Quantity, MinimumQuantity)
VALUES
("Nuts", 200, 100),
("Bolts", 200, 100);

SELECT * FROM PartsStockView;

