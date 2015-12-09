<?php namespace MINI\Controllers;

class ReservationUpdate extends Controller
{

  public function display($params)
  {
    $id = $params['id'];
    $reservation = $params['reservation'];

    // get current data.

    $data = [
      "action" => "/faculty/{$id}/reservation/update/{$reservation}"
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