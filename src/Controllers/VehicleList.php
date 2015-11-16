<?php namespace MINI\Controllers;

class VehicleList extends Controller
{

  public function display()
  {
    // get vehicles.
    $data = [];
    $html = $this->view->render('VehicleList', $data);
    $this->response->setContent($html);
  }
}