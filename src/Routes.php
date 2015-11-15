<?php

return [
    // Global
    ['GET',  '/', ['MINI\Controllers\Home', 'display']],
    ['POST', '/login', ['MINI\Controllers\Login', 'authorise']],
    // Faculty
    ['GET',  '/faculty', ['MINI\Controllers\FacultyHome', 'display']],
    ['GET',  '/faculty/reserve', ['MINI\Controllers\FacultyReservation', 'display']],
    ['POST', '/faculty/reserve', ['MINI\Controllers\FacultyReservation', 'make']],
    ['GET',  '/faculty/checkout/{id:\d}', ['MINI\Controllers\FacultyCheckout', 'display']],
    ['POST', '/faculty/checkout', ['MINI\Controllers\FacultyCheckout', 'checkout']],
    ['GET',  '/faculty/checkin/{id:\d}', ['MINI\Controllers\FacultyCheckin', 'display']],
    ['POST', '/faculty/checkin', ['MINI\Controllers\FacultyCheckin', 'checkin']],
    // Mechanics
    ['GET',  '/mechanic', ['MINI\Controllers\MechanicHome', 'display']],
    ['GET',  '/mechanic/checkout/{id:\d}', ['MINI\Controllers\MaintenanceCheckout', 'display']],
    ['POST', '/mechanic/checkout', ['MINI\Controllers\MaintenanceCheckout', 'checkout']],
    // Vehicle
    ['GET', '/vehicle/maintenance-detail/{id:\d}', ['MINI\Controllers\MaintenanceDetail', 'display']],
    ['GET', '/vehicle/maintenance-detail/maintenace-item/{id:\d}', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['GET', '/vehicle/maintenance-detail/maintenace-item/add{id:\d}', ['MINI\Controllers\MaintenanceDetailItem', 'add']],
    ['GET', '/vehicle/maintenance-detail/maintenace-item/update{id:\d}', ['MINI\Controllers\MaintenanceDetailItem', 'update']],
];