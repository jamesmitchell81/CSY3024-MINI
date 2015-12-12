<?php namespace MINI\Controllers;

use MINI\Models\JourneyGateway;
use MINI\Models\VehicleGateway;

class FacultyCheckout extends Controller
{

  public function display($params)
  {
    // get reservation by id.
    $rid = $params['reservation'];
    $vid = $params['vehicle'];

    // get reserved vehicle.
    $vehicle = (new VehicleGateway)->find($vid);
    // get vehicle odominator current.
    $data = [
      'action' => "/faculty/checkout/$vid/$rid",
      'odometerStart' => $vehicle['CurrentMileage']
    ];
    $html = $this->view->render('ReservationCheckout', $data);
    $this->response->setContent($html);
  }

  public function checkout($params)
  {
    $vid = $params['vehicle'];
    $rid = $params['reservation'];

    $current = $this->request->getParameters();
    // insert current, update current.
    $complete = (new JourneyGateway)->insert($vid, $rid, $current['odometer-start']);

    header("Location: /faculty");
  }

}