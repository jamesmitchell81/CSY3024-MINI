<?php namespace MINI\Controllers;

use MINI\Models\Vehicle;
use MINI\Models\VehicleGateway;

class VehicleAdd extends Controller
{

  public function display($params)
  {
    $data = [
      'action' => '/vehicle/add'
    ];

    $html = $this->view->render('VehicleForm', $data);
    $this->response->setContent($html);
  }

  public function add()
  {
    $details = $this->request->getParameters();

    // validate.

    $vehicle = new Vehicle;
    $vehicle->reg = $details['vehicle-reg'];
    $vehicle->mileageRate = $details['mileage-rate'];
    $vehicle->currentMileage = $details['current-mileage'];
    $vehicle->model = $details['model'];
    $vehicle->manufacturer = $details['make'];
    $vehicle->seats = $details['seats'];
    $vehicle->type = $details['type'];

    $complete = (new VehicleGateway)->insert($vehicle);

    var_dump($complete);
    var_dump($details);
  }
}