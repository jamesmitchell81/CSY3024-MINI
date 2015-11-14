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