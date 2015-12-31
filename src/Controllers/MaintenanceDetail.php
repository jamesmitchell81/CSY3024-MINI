<?php namespace MINI\Controllers;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class MaintenanceDetail extends Controller
{

  public function display($params)
  {
    $log = $params['log'];

    $SQL = 'SELECT * FROM  Maintenance l
            INNER JOIN VehicleView v ON v.idVehicle = l._idVehicle
            WHERE l.MaintenanceLogNumber = :log';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $details = $statement->select($SQL)->first();

    $SQL = 'SELECT * FROM MaintenanceItem i
            WHERE i._MaintenanceLogNumber = :log AND i._CompletedBy IS NULL';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $open = $statement->select($SQL)->all();

    $SQL = 'SELECT * FROM MaintenanceItem i
            WHERE i._MaintenanceLogNumber = :log AND i._CompletedBy IS NOT NULL';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $completed = $statement->select($SQL)->all();

    $data = [
      'details'   => $details,
      'open'      => $open,
      'completed' => $completed,
      'log'       => $log
    ];

    $html = $this->view->render('MaintenanceDetail', $data);
    $this->response->setContent($html);

  }


}