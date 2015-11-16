<?php namespace MINI\Controllers;

class VehicleDetails extends Controller
{

  public function display($params)
  {
    $data = [
      'action' => '/vehicle/add'
    ];

    if ( $params )
    {
      $data = ['action' => '/vehicle/update'];
    }

    $html = $this->view->render('VehicleForm', $data);
    $this->response->setContent($html);
  }

  public function add()
  {
    $details = $this->request->getParameters();

    var_dump($details);
  }
}