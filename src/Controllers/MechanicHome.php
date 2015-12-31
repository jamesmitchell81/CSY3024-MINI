<?php namespace MINI\Controllers;

use MINI\Util\Session as Session;
use MINI\Template\View;
use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class MechanicHome extends Controller
{

  public function display()
  {
    $connection = new Connection;
    $statement = new Statement($connection);

    //get mechanic view
    $statement->setInt('id', Session::get('id'));
    $SQL = "SELECT * FROM MechanicView WHERE idMINIEmployee = :id";
    $mechanic = $statement->select($SQL)->first();

    // get vehicles with issues that have not yet been added to maintenance.
    $statement = new Statement($connection);
    $SQL = 'SELECT * FROM VehicleReportedIssues';
    $issues = $statement->select($SQL)->all();

    // get vehicles in under maintenance.
    $statement = new Statement($connection);
    $SQL = 'SELECT * FROM Maintenance m INNER JOIN VehicleView v ON m._idVehicle = v.idVehicle WHERE _ReturnedBy IS NULL';
    $maintenance = $statement->select($SQL)->all();

    $data = [
      'mechanic'    => $mechanic,
      'issues'      => $issues,
      'maintenance' => $maintenance
    ];

    $html = $this->view->render('MechanicHome', $data);
    $this->response->setContent($html);
  }


}

