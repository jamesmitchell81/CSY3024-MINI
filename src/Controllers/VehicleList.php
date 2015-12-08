<?php namespace MINI\Controllers;

use MINI\Models\VehicleGateway;

class VehicleList extends Controller
{

  public function display()
  {
    // get vehicles.
    $vehicles = new VehicleGateway;
    $list = $vehicles->findAll();

    $data = [
      'vehicles' => $list
    ];

    $html = $this->view->render('VehicleList', $data);
    $this->response->setContent($html);
  }
}