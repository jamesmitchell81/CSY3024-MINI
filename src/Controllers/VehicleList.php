<?php namespace MINI\Controllers;

use MINI\Models\VehicleGateway;
use MINI\Util\Clean;

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

  public function available($params)
  {
    $seats = Clean::int($params['seats']);
    $from = Clean::date($params['from']);
    $to = Clean::date($params['to']);

    $vehicles = new VehicleGateway;
    $list = $vehicles->findAvailable($seats, $from, $to);

    $data['vehicles'] = $list;

    $html = $this->view->render('VehicleSelectionList', $data);
    $this->response->setContent($html);
  }
}