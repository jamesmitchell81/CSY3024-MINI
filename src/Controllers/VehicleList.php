<?php namespace MINI\Controllers;

use MINI\Models\Vehicles;

class VehicleList extends Controller
{

  public function display()
  {
    // get vehicles.
    $vehicles = new Vehicles;
    $list = $vehicles->getAllVehicles();

    $data = [
      'vehicles' => $list
    ];

    $html = $this->view->render('VehicleList', $data);
    $this->response->setContent($html);
  }
}