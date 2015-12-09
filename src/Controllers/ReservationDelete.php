<?php namespace MINI\Controllers;

class ReservationDelete extends Controller
{

  public function display($params)
  {
    // get details of item to delete
    $id = $params['id'];
    $reservation =  $params['reservation'];

    $data = [
      "action" => "/faculty/{$id}reservation/delete/{$reservation}",
      "returnto" => "/faculty"
    ];

    $html = $this->view->render('DeleteConfirm', $data);
    $this->response->setContent($html);
  }

  public function delete($params)
  {
    $id = $params['id'];
    $reservation = $params['reservation'];
    $data = $this->request->getParameters();
    // validate input

    // remove reservation

    // redirect
  }
}