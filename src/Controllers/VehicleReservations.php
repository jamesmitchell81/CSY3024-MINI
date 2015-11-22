<?php namespace MINI\Controllers;

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
}