<?php

return [
    // Global.
    // ['GET',  '/insertParts',                 ['MINI\Controllers\InsertParts', 'insert']],
    // Mechanics.
    ['GET',  '/mechanic',                        ['MINI\Controllers\MechanicHome', 'display']],
    ['GET',  '/mechanic/{id:\d+}/checkout',      ['MINI\Controllers\MaintenanceCheckout', 'display']],
    ['POST', '/mechanic/checkout',               ['MINI\Controllers\MaintenanceCheckout', 'checkout']],
    ['GET',  '/mechanic/{id}/mot/vehicle/{reg}', ['MINI\Controllers\MaintenanceMOT', 'display']],
    // Vehicle Maintenance.
    ['GET',  '/vehicle/{reg}/maintenance-detail', ['MINI\Controllers\MaintenanceDetail', 'display']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/add', ['MINI\Controllers\MaintenanceDetailItem', 'add']],
    ['GET',  '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/{id:\d+}/update', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/{id:\d+}/update', ['MINI\Controllers\MaintenanceDetailItem', 'update']],
    ['POST', '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/{id:\d+}/remove', ['MINI\Controllers\MaintenanceDetailItem', 'delete']],
    // Vehicles.
    ['GET',  '/vehicles',             ['MINI\Controllers\VehicleList',   'display']],
    // Parts.
    ['GET', '/parts', ['MINI\Controllers\PartsList', 'display']],
    // Department.
];



