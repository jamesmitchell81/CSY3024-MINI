<?php namespace MINI\Controllers;

class ReservationDelete extends Controller
{

  public function display($params)
  {
    // get details of item to delete
    $id = array_key_exists('id', $params) ? $params['id'] : return;
    $data = [
      "action" => "/faculty/reservation/delete/{$id}",
      "returnto" => "/faculty"
    ];

    $html = $this->view->render('DeleteConfirm', $data);
    $this->response->setContent($html);
  }

  public function delete($params)
  {
    $id = array_key_exists('id', $params) ? $params['id'] : return;
    $data = $this->request->getParameters();
    // validate input

    // remove reservation

    // redirect
  }
}