Mechanic(idMec, FirstName, LastName);
Maintenance(MaintenanceLogNumber, _idVehicle, _idMechanic, Description, EntryDate, ReturnedDate)

MaintenanceLogNumber -> _idVehicle, _idMechanic -> Description, EntryDate, ReturnedDate

MaintenanceVehicle(MaintenanceLogNumber, _idVehicle, _idDescription)
MaintenanceDescription(idDescription, _idMechanic, Description, EntryDate)
MaintenanceCompleted(_MaintenanceLogNumber, _idMechanic, ReturnedDate)

MaintenanceItem(idItem, _MaintenanceLogNumber, _idMechanic, ItemDescription, CompletionDate)


--------------- Parts Normalisation --------
Parts(idParts, Category, Name, MinimumQuantity, MechanicIn, MechanicOut, DateIn, DateOut, SerialNo)

Parts(idParts, Name)
PartsCategory(idParts, _idCategory)
Category(idCategory, Category)
PartMinQuantity(idParts, MinimumQuantity)

PartsInventory(idPartInventory, _idParts, _MechanicIn, DateIn, SerialNo)
PartsUsed(idPartInventory, _MechanicOut, DateOut)


Vehicles(idVehicle, _idVehicleTypes, VehicleReg, MileageRate, Make, Model, Colour, Seats, CurrentMileage, Image)

-- Partial.
(a, b) -> c and b -> c
-- Transistive.
a -> b and b -> c

-- Remove Repeating groups.
Vehicles(idVehicle, _idVehicleTypes, _idVehicleColours, _idVehicleModels, VehicleReg, MileageRate, Seats, CurrentMileage, Image)


Vehicles(idVehicle, _idVehicleTypes, _idVehicleColours, _idVehicleModels, VehicleReg, CurrentMileage, Image)

VehicleColours(idVehicleColours, Colour)

VehicleTypes(idVehicleTypes, TypeName, MileageRate)
VehicleModels(idVehicleModels, _idManufacturer, ModelName, Seats) n -> 1 Manufacturer(idManufacturer, Manufacturer)

---

Vehicles(idVehicle, _idVehicleColours, _idVehicleModels, VehicleReg, CurrentMileage, Image)

VehicleColours(idVehicleColours, Colour)
VehicleTypes(idVehicleTypes, TypeName, Seats, MileageRate)
VehicleModels(idVehicleModels, _idManufacturer, _idVehicleTypes, ModelName) n -> 1 Manufacturer(idManufacturer, Manufacturer)


