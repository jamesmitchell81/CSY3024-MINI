<?php namespace MINI\Controllers;

use MINI\Util\Session;
use MINI\Util\Validation;
use MINI\Models\Reservation;
use MINI\Models\ReservationGateway;
use MINI\Models\VehicleGateway;

class ReservationUpdate extends Controller
{

  public function display($params)
  {
    $id = Session::get('id');
    $reservation = $params['reservation'];

    // get current data.
    $current = (new ReservationGateway)->findUserReservation($id, $reservation);
    $vehicles = (new VehicleGateway)->findAll();

    // map date to fields.
    $fields = [
      'reservation'   => $reservation,
      'departuredate' => $current['DepartureDate'],
      'returndate'    => $current['ReturnDueDate'],
      'vehicle'       => $current['_idVehicles'],
      'postcode'      => $current['Destination'],
      'vehicles'      => $vehicles
    ];

    $data = [
      "action" => "/faculty/reservation/update/{$reservation}",
      "field"  => $fields
    ];

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function update($params)
  {
    $id = Session::get('id');
    $reservation = $params['reservation'];

    $form = $this->request->getParameters();

    if  (!array_key_exists('vehicle', $form) ) $form['vehicle'] = 0;

    $valid = new Validation;
    $valid->validate("departuredate", $form['departuredate'])->required()->date()->future();
    $valid->validate("returndate", $form['returndate'])->required()->date()->future();
    $valid->validate("vehicle", $form['vehicle'])->not(0, "A vehicle has not be selected");
    $valid->validate("postcode", $form['postcode'])->required()->ukPostCode();

    if ( !$valid->passed() )
    {
      $data = [
        "action" => "/faculty/reservation/add",
        "errors" => $valid->feedback(),
        "fields" => $form
      ];
      $html = $this->view->render('ReservationForm', $data);
      $this->response->setContent($html);
      return;
    }

    $reservation = new Reservation;
    $reservation->id = $params['reservation'];
    $reservation->facultyMember = $id;
    $reservation->vehicle = $form['vehicle'];
    $reservation->departure = $form['departuredate'];
    $reservation->return = $form['returndate'];;
    $reservation->destination = $form['postcode'];

    // update
    $reserve = (new ReservationGateway)->update($reservation);

    // redirect
    header("Location: /faculty");
  }}