<?php namespace MINI\Controllers;

use MINI\Util\Session;
use MINI\Models\ReservationGateway;

class ReservationDelete extends Controller
{

  public function display($params)
  {
    // get details of item to delete
    $id = Session::get('id');
    $reservation =  $params['reservation'];

    $data = [
      "action" => "/faculty/reservation/delete/{$reservation}",
      "returnto" => "/faculty"
    ];

    $html = $this->view->render('DeleteConfirm', $data);
    $this->response->setContent($html);
  }

  public function delete($params)
  {
    $reservation = $params['reservation'];
    (new ReservationGateway)->delete($reservation);

    // redirect
    header("Location: /faculty");
  }
}