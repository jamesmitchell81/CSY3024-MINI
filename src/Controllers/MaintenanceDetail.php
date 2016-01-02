<?php namespace MINI\Controllers;

use MINI\Models\PartsGateway;
use MINI\Util\Session;
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

    $this->addParts($open);

    $SQL = 'SELECT * FROM MaintenanceItem i INNER JOIN MechanicView m ON i._CompletedBy = m.idMINIEmployee
            WHERE i._MaintenanceLogNumber = :log AND i._CompletedBy IS NOT NULL';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $completed = $statement->select($SQL)->all();

    // get parts used
    $this->addParts($completed);

    $data = [
      'details'   => $details,
      'open'      => $open,
      'completed' => $completed,
      'log'       => $log
    ];

    $html = $this->view->render('MaintenanceDetail', $data);
    $this->response->setContent($html);
  }

  public function complete($params)
  {
    $log = $params['log'];
    $mechanic = Session::get('id');

    $SQL = 'UPDATE Maintenance
            SET _ReturnedBy = :mechanic, DateReturned = CURRENT_TIMESTAMP
            WHERE MaintenanceLogNumber = :log';

    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $statement->setInt('mechanic', $mechanic);
    $complete = $statement->update($SQL);

    if ( !is_a($complete, "PDOException") )
    {
      header('Location:/mechanic');
    } else {
      $data = [
        'error'  => $complete->errorInfo[2],
        'return' => "/maintenance/log/$log"
      ];

      $html = $this->view->render('Error', $data);
      $this->response->setContent($html);
    }

  }

  private function addParts(&$arr)
  {
    $length = count($arr);
    for ( $i = 0; $i < $length; $i++ )
    {
       $parts = (new PartsGateway)->partsUsedForItem($arr[$i]['idMaintenanceItem']);
       $arr[$i]['parts'] = $parts;
    }
  }

}