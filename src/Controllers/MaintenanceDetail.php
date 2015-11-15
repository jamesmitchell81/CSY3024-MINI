<?php namespace MINI\Controllers;

class MaintenanceDetail extends Controller
{

  public function display($params)
  {
    // get vehicle data.
    $data = [];
    $html = $this->view->render('MaintenanceDetail', $data);
    $this->response->setContent($html);
  }
}