<?php

return [
    // Global.
    ['GET',  '/', ['MINI\Controllers\Home', 'display']],
    ['POST', '/login', ['MINI\Controllers\Login', 'authorise']],
    // Faculty.
    ['GET',  '/faculty',                 ['MINI\Controllers\FacultyHome', 'display']],
    //  Reserve
    ['GET',  '/faculty/reservation/add',             ['MINI\Controllers\ReservationAdd', 'display']],
    ['GET',  '/faculty/reservation/update/{id:\d}',  ['MINI\Controllers\ReservationUpdate', 'display']],
    ['GET',  '/faculty/reservation/delete/{id:\d}',  ['MINI\Controllers\ReservationDelete', 'display']],
    ['POST', '/faculty/reservation/add',             ['MINI\Controllers\ReservationAdd', 'add']],
    ['POST', '/faculty/reservation/update/{id:\d}',  ['MINI\Controllers\ReservationUpdate', 'update']],
    ['POST', '/faculty/reservation/delete/{id:\d}',  ['MINI\Controllers\ReservationDelete', 'delete']],
    //  Checkout
    ['GET',  '/faculty/checkout/{id:\d}', ['MINI\Controllers\FacultyCheckout', 'display']],
    ['POST', '/faculty/checkout',         ['MINI\Controllers\FacultyCheckout', 'checkout']],
    ['GET',  '/faculty/checkin/{id:\d}',  ['MINI\Controllers\FacultyCheckin', 'display']],
    ['POST', '/faculty/checkin',          ['MINI\Controllers\FacultyCheckin', 'checkin']],
    // Mechanics.
    ['GET',  '/mechanic',                  ['MINI\Controllers\MechanicHome', 'display']],
    ['GET',  '/mechanic/checkout/{id:\d}', ['MINI\Controllers\MaintenanceCheckout', 'display']],
    ['POST', '/mechanic/checkout',         ['MINI\Controllers\MaintenanceCheckout', 'checkout']],
    ['GET',  '/mechanic/{id}/mot/vehicle/{reg}', ['MINI\Controllers\MaintenanceMOT', 'display']],
    // Vehicle Maintenance.
    ['GET',  '/vehicle/{reg}/maintenance-detail', ['MINI\Controllers\MaintenanceDetail', 'display']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/add', ['MINI\Controllers\MaintenanceDetailItem', 'add']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/update/{id:\d}', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/update/{id:\d}', ['MINI\Controllers\MaintenanceDetailItem', 'update']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/remove/{id:\d}', ['MINI\Controllers\MaintenanceDetailItem', 'displayRemove']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/remove/{id:\d}', ['MINI\Controllers\MaintenanceDetailItem', 'delete']],
    // Vehicles.
    ['GET',  '/vehicles', ['MINI\Controllers\VehicleList', 'display']],
    ['GET',  '/vehicle/add', ['MINI\Controllers\VehicleDetails', 'display']],
    ['POST', '/vehicle/add', ['MINI\Controllers\VehicleDetails', 'add']],
    ['GET',  '/vehicle/update/{reg}', ['MINI\Controllers\VehicleDetails', 'display']],
    ['POST', '/vehicle/update', ['MINI\Controllers\VehicleDetails', 'update']],
    ['GET',  '/vehicle/delete', ['MINI\Controllers\VehicleDetails', 'displayRemove']],

    ['POST', '/vehicle/delete', ['MINI\Controllers\VehicleDetails', 'delete']],
];