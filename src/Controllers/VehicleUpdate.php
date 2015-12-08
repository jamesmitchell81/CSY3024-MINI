<?php namespace MINI\Controllers;

class VehicleUpdate extends Controller
{

  public function display($params)
  {
    $reg = array_key_exists('reg', $params) ? $params['reg'] : '';

    // get current data.

    $data = [
      'action' => '/vehicle/{reg}/update'
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