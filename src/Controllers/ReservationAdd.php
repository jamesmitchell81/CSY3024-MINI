<?php namespace MINI\Controllers;

use MINI\Util\Session;
use MINI\Util\Validation;
use MINI\Models\Reservation;
use MINI\Models\ReservationGateway;
use MINI\Models\VehicleGateway;

class ReservationAdd extends Controller
{
  public function display()
  {
    $id = Session::get('id');
    // default form dates
    $from = date('Y-m-d');
    $to = date('Y-m-d');

    $vehicles = (new VehicleGateway)->findAvailable($from, $to);

    $data = [
      "action" => "/faculty/reservation/add",
      "field"    => [
        'departuredate'  => $from,
        'returndate'     => $to,
        "vehicles" => $vehicles
      ]
    ];

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function add()
  {
    $id = Session::get('id');
    $form = $this->request->getParameters();

    if  (!array_key_exists('vehicle', $form) ) $form['vehicle'] = 0;

    $valid = new Validation;
    $valid->validate("departuredate", $form['departuredate'])->required()->date();
    $valid->validate("returndate", $form['returndate'])->required()->date();
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
    $reservation->facultyMember = $id;
    $reservation->vehicle = $form['vehicle'];
    $reservation->departure = $form['departuredate'];
    $reservation->return = $form['returndate'];;
    $reservation->destination = $form['postcode'];
    $reservation->mileageRate = (new VehicleGateway)->find($id)['MileageRate'];

    $reserve = (new ReservationGateway)->insert($reservation);

    // redirect on success.
    header("Location: /faculty");
  }
}