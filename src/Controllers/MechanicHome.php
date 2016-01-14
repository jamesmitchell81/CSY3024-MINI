<?php namespace MINI\Controllers;

use MINI\Util\Session as Session;
use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class MechanicHome extends Controller
{

  public function display()
  {
    $connection = new Connection;
    $statement = new Statement($connection);

    //get mechanic view
    $SQL = "SELECT * FROM MechanicView WHERE idMINIEmployee = :id";
    $statement->setInt('id', Session::get('id'));
    $mechanic = $statement->select($SQL)->first();

    // get vehicles with issues that have not yet been added to maintenance.
    $SQL = 'SELECT * FROM VehicleReportedIssues';
    $statement = new Statement($connection);
    $issues = $statement->select($SQL)->all();

    // get vehicles in under maintenance.
    $SQL = 'SELECT * FROM Maintenance m
            INNER JOIN VehicleView v ON m._idVehicle = v.idVehicle
            WHERE _ReturnedBy IS NULL';
    $statement = new Statement($connection);
    $maintenance = $statement->select($SQL)->all();

    // display completed maintenance.
    $SQL = 'SELECT * FROM Maintenance m
            INNER JOIN VehicleView v ON m._idVehicle = v.idVehicle
            WHERE _ReturnedBy IS NOT NULL
            ORDER BY DateReturned DESC';
    $statement = new Statement($connection);
    $completed = $statement->select($SQL)->all();

    $data = [
      'mechanic'    => $mechanic,
      'issues'      => $issues,
      'maintenance' => $maintenance,
      'completed'   => $completed
    ];

    $html = $this->view->render('MechanicHome', $data);
    $this->response->setContent($html);
  }


}

