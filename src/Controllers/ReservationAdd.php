<?php namespace MINI\Controllers;

use MINI\Util\Validation;
use MINI\Models\Reservation;
use MINI\Models\ReservationGateway;

class ReservationAdd extends Controller
{
  $valid = new Validation;
  public function display($params)
  {
    if ( !$valid->numberInt('id', $params['id'])->passed() )
      header("Location:/");

    $data = [
      "action" => "/faculty/{$params['id']}/reservation/add"
    ];

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function add($params)
  {
    $data = $this->request->getParameters();
    // validate
    // validate post code.
    //api.postcodes.io/postcodes/$postCode/validate;
    $valid = new Validation;

    $valid->validate("departure-date", $data['departure-date'])
          ->required()
          ->date();

    // insert
    // $reservation = new Reservation;
    // $facultyMember = $data[''];
    // $vehicle;
    // $status = "Pending";
    // $departure;
    // $return;

    // redirect on success.
    // header("Location: /faculty");
  }
}