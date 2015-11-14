<?php

return [
    ['GET', '/', ['MINI\Controllers\Home', 'show']],
    ['POST', '/login', ['MINI\Controllers\Login', 'authorise']],
    ['GET', '/faculty/', ['MINI\Controllers\FacultyHome', 'show']],
    ['GET', '/faculty/reserve', ['MINI\Controllers\FacultyReservation', 'show']],
    ['POST', '/faculty/reserve', ['MINI\Controllers\FacultyReservation', 'make']]
];