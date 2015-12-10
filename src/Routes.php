<?php

return [
    // Global.
    ['GET',  '/', ['MINI\Controllers\Home', 'display']],
    ['POST', '/login', ['MINI\Controllers\Login', 'authorise']],
    // Faculty.
    ['GET',  '/faculty',                 ['MINI\Controllers\FacultyHome', 'display']],
    //  Reserve
    ['GET',  '/faculty/reservation/add',             ['MINI\Controllers\ReservationAdd', 'display']],
    ['GET',  '/faculty/reservation/update/{reservation:\d+}',  ['MINI\Controllers\ReservationUpdate', 'display']],
    ['GET',  '/faculty/reservation/delete/{reservation:\d+}',  ['MINI\Controllers\ReservationDelete', 'display']],
    ['POST', '/faculty/reservation/add',             ['MINI\Controllers\ReservationAdd', 'add']],
    ['POST', '/faculty/reservation/update/{reservation:\d+}',  ['MINI\Controllers\ReservationUpdate', 'update']],
    ['POST', '/faculty/reservation/delete/{reservation:\d+}',  ['MINI\Controllers\ReservationDelete', 'delete']],
    //  Checkout
    ['GET',  '/faculty/checkout/{reservation:\d+}', ['MINI\Controllers\FacultyCheckout', 'display']],
    ['POST', '/faculty/checkout/{reservation:\d+}', ['MINI\Controllers\FacultyCheckout', 'checkout']],
    ['GET',  '/faculty/checkin/{reservation:\d+}',  ['MINI\Controllers\FacultyCheckin', 'display']],
    ['POST', '/faculty/checkin/{reservation:\d+}',  ['MINI\Controllers\FacultyCheckin', 'checkin']],
    // Mechanics.
    ['GET',  '/mechanic',                        ['MINI\Controllers\MechanicHome', 'display']],
    ['GET',  '/mechanic/{id:\d+}/checkout',       ['MINI\Controllers\MaintenanceCheckout', 'display']],
    ['POST', '/mechanic/checkout',               ['MINI\Controllers\MaintenanceCheckout', 'checkout']],
    ['GET',  '/mechanic/{id}/mot/vehicle/{reg}', ['MINI\Controllers\MaintenanceMOT', 'display']],
    // Vehicle Maintenance.
    ['GET',  '/vehicle/{reg}/maintenance-detail', ['MINI\Controllers\MaintenanceDetail', 'display']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/add', ['MINI\Controllers\MaintenanceDetailItem', 'add']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/update/{id:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/update/{id:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'update']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/remove/{id:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'displayRemove']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/remove/{id:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'delete']],
    // Vehicles.
    ['GET',  '/vehicles',             ['MINI\Controllers\VehicleList',   'display']],
    // ['GET',  '/vehicles/{seats:\d+}/available/{from}/{to}', ['MINI\Controllers\VehicleList', 'available']],
    ['GET',  '/vehicles/available/{from}/{to}', ['MINI\Controllers\VehicleList', 'available']],
    ['GET',  '/vehicle/add',          ['MINI\Controllers\VehicleAdd',    'display']],
    ['POST', '/vehicle/add',          ['MINI\Controllers\VehicleAdd',    'add']],
    ['GET',  '/vehicle/{reg}/update', ['MINI\Controllers\VehicleUpdate', 'display']],
    ['POST', '/vehicle/{reg}/update', ['MINI\Controllers\VehicleUpdate', 'update']],
    ['GET',  '/vehicle/{reg}/delete', ['MINI\Controllers\VehicleDelete', 'display']],
    ['POST', '/vehicle/{reg}/delete', ['MINI\Controllers\VehicleDelete', 'delete']],
    // Vehicle details.
    ['GET', '/vehicle/{reg}/mileage/{year}', ['MINI\Controllers\Vehicle', 'mileage']],
    // Vechicle Reservations.
    ['GET', '/vehicles/reservation/{id:\d+}', ['MINI\Controllers\VehicleReservations', 'vehicle']],
    ['GET', '/vehicles/reservations', ['MINI\Controllers\VehicleReservations', 'display']],
    ['GET', '/vehicle/reservation/{id:\d}/department', ['MINI\Controllers\VehicleReservations', 'department']],
    // Parts.
    // ['GET', '/parts', ['MINI\Controllers\PartsList', 'display']],
    // Department.
    ['GET', '/department/{id}/reservations/{year}', ['MINI\Controllers\Department', 'reservations']],
    ['GET', '/department/{id}/mileage/{year}', ['MINI\Controllers\Department', 'mileage']],
    ['GET', '/department/{id}/billings/{year}', ['MINI\Controllers\Department', 'billings']],
];



