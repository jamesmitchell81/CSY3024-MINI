<?php namespace MINI\Controllers;

use MINI\Models\ReservationGateway;
use MINI\Util\Clean;

class VehicleReservations extends Controller
{
  // get current reservations
  public function display()
  {


    $this->response->setContent('current reservation details');
  }

  // get department of specific reservation.
  public function department($params)
  {
    $this->response->setContent('department: has reserved ... reservation number');
  }

  public function vehicle($params)
  {
    $v = (new ReservationGateway)->findVehicle(Clean::int($params['id']));
    $data['vehicles'] = $v;

    $html = $this->view->render('VehicleSelectionList', $data);
    $this->response->setContent($html);
  }
}