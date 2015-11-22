<?php namespace MINI\Controllers;

class Vehicle extends Controller
{
  public function mileage($params)
  {
    $reg = $params['reg'];
    $year = $params['year'];

    // get vehicle milage for year.

    // $html = $this->view->render('')
    $this->response->setContent("Vehicle: $reg, Mileage: , Year: $year");
  }
}