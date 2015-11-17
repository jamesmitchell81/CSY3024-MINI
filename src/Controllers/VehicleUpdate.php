<?php namespace MINI\Controllers;

class VehicleUpdate extends Controller
{

  public function display($params)
  {
    $reg = arrray_key_exists('reg', $params) ? $params['reg'] : return;

    // get current data.

    $data = [
      'action' => '/vehicle/update/{reg}'
    ];

    $html = $this->view->render('VehicleForm', $data);
    $this->response->setContent($html);
  }

  public function update()
  {
    $details = $this->request->getParameters();
    var_dump($details);
  }
}