<?php

return [
    // Global.
    ['GET',  '/insertParts',                 ['MINI\Controllers\InsertParts', 'insert']],
    // Mechanics.
    ['GET',   '/mechanic', ['MINI\Controllers\MechanicHome', 'display']],
    ['GET',   '/maintenance/checkout/general/issue/{issue:\d+}', ['MINI\Controllers\MaintenanceCheckout', 'display']],
    ['POST',  '/maintenance/checkout/general/issue/{issue:\d+}',      ['MINI\Controllers\MaintenanceCheckout', 'checkout']],
    ['GET',  '/maintenance/log/{log:\d+}', ['MINI\Controllers\MaintenanceDetail', 'display']],

    ['GET',  '/maintenance/log/{log:\d+}/complete', ['MINI\Controllers\MaintenanceDetail', 'complete']],

    ['GET',  '/maintenance/log/{log:\d+}/additem', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST',  '/maintenance/log/{log:\d+}/additem', ['MINI\Controllers\MaintenanceDetailItem', 'add']],
    ['GET',  '/maintenance/log/{log:\d+}/complete/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'complete']],
    ['GET',  '/maintenance/log/{log:\d+}/reopen/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'reopen']],
    ['GET',  '/maintenance/log/{log:\d+}/delete/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'delete']],
    ['GET',   '/maintenance/log/{log:\d+}/update/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST',  '/maintenance/log/{log:\d+}/update/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'update']],
    ['GET',   '/maintenance/log/{log:\d+}/update/{item:\d+}/parts/remove/{id:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'removePart']],

    // Vehicle Maintenance.
    ['GET',  '/vehicles',             ['MINI\Controllers\VehicleList',   'display']],
    // Parts.
    ['GET', '/parts', ['MINI\Controllers\PartsList', 'display']],
    // Department.
];



