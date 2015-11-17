<?php namespace MINI\Controllers;

class ReservationUpdate extends Controller
{

  public function display()
  {
    $id = array_key_exists('id', $params) ? $params['id'] : 0;
    $data = [
      "action" => "/faculty/reservation/update/{$id}"
    ];

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function update($params)
  {
    $id = array_key_exists('id', $params) ? $params['id'] : return;
    $data = $this->request->getParameters();
    // validate

    // update

    // redirect
    header("Location: /faculty");
  }}