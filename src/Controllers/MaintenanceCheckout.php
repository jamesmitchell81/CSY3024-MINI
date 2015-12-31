<?php namespace MINI\Controllers;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class MaintenanceCheckout extends Controller
{

  public function display($params)
  {
    $vehicle = $params['vehicle'];
    $reservation = $params['reservation'];

    // select from vehiclereported issues where idVehicle =
    $SQL = 'SELECT * FROM VehicleReportedIssues WHERE _idReservation = :reservation AND idVehicle = :vehicle';
    $statement = new Statement(new Connection);
    $statement->setInt('vehicle', $vehicle);
    $statement->setInt('reservation', $reservation);
    $details = $statement->select($SQL)->first();

    $data = [
      'details' => $details
    ];

    $html = $this->view->render('MaintenanceCheckOut', $data);
    $this->response->setContent($html);
  }

  public function checkout($params)
  {
    $vehicle = $params['vehicle'];
    $description = $this->request->getParameter('description');

    $SQL = 'INSERT INTO Maintenance (_idVehicle, BriefDescription, MaintenanceEntryDate)
            VALUES (:vehicle, :description, CURRENT_TIMESTAMP)';

    $statement = new Statement(new Connection);
    $statement->setInt('vehicle', $vehicle);
    $statement->setInt('description', $description);
    $statement->insert($SQL);

    header('Location:/mechanic');
  }
}