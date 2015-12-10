<?php namespace MINI\Controllers;

use MINI\Models\JourneyGateway;
use MINI\Models\ReservationGateway;

class FacultyCheckout extends Controller
{

  public function display($params)
  {
    // get reservation by id.
    $res = $params['reservation'];

    // get reserved vehicle.
    $vehicle = (new ReservationGateway)->findVehicle($res);
    // get vehicle odominator current.
    $data = [
      'action' => "/faculty/checkout/$res",
      'odometerStart' => $vehicle[0]['CurrentMileage']
    ];
    $html = $this->view->render('ReservationCheckout', $data);
    $this->response->setContent($html);
  }

  public function checkout($params)
  {
    $id = $params['reservation'];
    $current = $this->request->getParameters();
    $date = date('Y-m-d');
    // insert current, update current.
    $complete = (new JourneyGateway)->insert($id, $current['odometer-start'], $date);

    header("Location: /faculty");
  }

}