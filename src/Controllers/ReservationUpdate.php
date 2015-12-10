<?php namespace MINI\Controllers;

use MINI\Models\ReservationGateway;
use MINI\Models\VehicleGateway;

class ReservationUpdate extends Controller
{

  public function display($params)
  {
    $id = $params['id'];
    $reservation = $params['reservation'];

    // get current data.
    $current = (new ReservationGateway)->findUserReservation($id, $reservation);
    $seats = (new VehicleGateway)->findVehicleSeats($current['_idVehicles']);

    // map date to fields.
    $fields = [
      'departuredate' => $current['DepartureDate'],
      'returndate'    => $current['ReturnDueDate'],
      'vehicle'       => $current['_idVehicles'],
      'requiredseats' => $seats['Seats'],
      'postcode'      => $current['Destination']
    ];

    $data = [
      "action" => "/faculty/{$id}/reservation/update/{$reservation}",
      "field"  => $fields
    ];

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function update($params)
  {
    $id = $params['id'];
    $reservation = $params['reservation'];

    $data = $this->request->getParameters();
    // validate

    // update

    // redirect
    header("Location: /faculty");
  }}