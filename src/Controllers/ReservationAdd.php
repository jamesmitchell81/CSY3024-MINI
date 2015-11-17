<?php namespace MINI\Controllers;

class ReservationAdd extends Controller
{

  public function display()
  {
    $data = [
      "action" => "/faculty/reservation/add"
    ];

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function add()
  {
    $data = $this->request->getParameters();
    // validate

    // insert

    // redirect
    header("Location: /faculty");
  }
}