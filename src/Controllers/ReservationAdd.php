<?php namespace MINI\Controllers;

use MINI\Util\Validation;
use MINI\Models\Reservation;
use MINI\Models\ReservationGateway;

class ReservationAdd extends Controller
{
  public function display($params)
  {

    // $valid = new Validation;
    // if ( !$valid->numberInt('id', $params['id'])->passed() )
    //   header("Location:/");

    $data = [
      "action" => "/faculty/{$params['id']}/reservation/add"
    ];

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function add($params)
  {
    $form = $this->request->getParameters();

    if  (!array_key_exists('vehicle', $form) ) $form['vehicle'] = 0;

    $valid = new Validation;
    $valid->validate("departuredate", $form['departuredate'])->required()->date();
    $valid->validate("returndate", $form['returndate'])->required()->date();
    $valid->validate("requiredseats", $form['requiredseats'])->required();
    $valid->validate("vehicle", $form['vehicle'])->not(0, "A vehicle has not be selected");
    $valid->validate("postcode", $form['postcode'])->required()->ukPostCode();

    if ( !$valid->passed() )
    {
      $data = [
        "action" => "/faculty/{$params['id']}/reservation/add",
        "errors" => $valid->feedback(),
        "fields" => $form
      ];
      $html = $this->view->render('ReservationForm', $data);
      $this->response->setContent($html);
      return;
    }

    $reservation = new Reservation;
    $reservation->facultyMember = $params['id'];
    $reservation->vehicle = $form['vehicle'];
    $reservation->departure = $form['departuredate'];
    $reservation->return = $form['returndate'];;
    $reservation->destination = $form['postcode'];

    $reserve = (new ReservationGateway)->insert($reservation);

    // redirect on success.
    header("Location: /faculty/{$params['id']}");
  }
}