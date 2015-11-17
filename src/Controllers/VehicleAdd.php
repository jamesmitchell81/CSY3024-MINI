<?php namespace MINI\Controllers;

class VehicleAdd extends Controller
{

  public function display($params)
  {
    $data = [
      'action' => '/vehicle/add'
    ];

    $html = $this->view->render('VehicleForm', $data);
    $this->response->setContent($html);
  }

  public function add()
  {
    $details = $this->request->getParameters();
    var_dump($details);
  }
}