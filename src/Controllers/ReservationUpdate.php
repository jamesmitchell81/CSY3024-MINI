<?php namespace MINI\Controllers;

use MINI\Util\Session;
use MINI\Util\Validation;
use MINI\Models\Reservation;
use MINI\Models\VehicleGateway;
use MINI\Models\ReservationGateway;
use MINI\Models\VehicleReservationGateway;
use MINI\Models\VehicleReservations;

class ReservationUpdate extends Controller
{

  public function display($params)
  {
    $id = Session::get('id');
    $reservation = $params['reservation'];

    // get current data.
    $current = (new ReservationGateway)->findUserReservation($id, $reservation);
    $vehiclesBooked = (new VehicleGateway)->findReservationVehicles($reservation);
    $available = (new VehicleGateway)->findAvailable($current['DepartureDate'], $current['ReturnDueDate']);

    // map date to fields.
    $fields = [
      'reservation'   => $reservation,
      'departuredate' => $current['DepartureDate'],
      'returndate'    => $current['ReturnDueDate'],
      'postcode'      => $current['Destination'],
      'vehicles'      => [
        'booked' => $vehiclesBooked,
        'available'     => $available
      ]
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
    $valid->validate("postcode", $form['postcode'])->required()->ukPostCode();

    $valid->validate("vehicle", $form['vehicle'])->not(0, "A vehicle has not be selected");

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

    $rid = $params['reservation'];
    $departure = $form['departuredate'];
    $return = $form['returndate'];;
    $destination = $form['postcode'];

    // update
    $reserve = (new ReservationGateway)->update($rid, $departure, $return, $destination);

    $s = (new VehicleReservationGateway)->delete($rid);

    $vr = new VehicleReservations;
    $vr->reservation = $rid;
    foreach ($form['vehicle'] as $vehicle) {
      $vr->vehicles[] = $vehicle;
    }
    (new VehicleReservationGateway)->insert($vr);

    // redirect
    header("Location: /faculty");
  }}