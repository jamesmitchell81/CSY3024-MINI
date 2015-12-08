<?php namespace MINI\Controllers;

class VehicleDelete extends Controller
{

  public function display($params)
  {
    $reg = array_key_exists('reg', $params) ? $params['reg'] : '';

    // get current data.
    $data = [
      'action' => '/vehicle/delete/{reg}',
      'returnto' => '/vehicles'
    ];

    $html = $this->view->render('DeleteConfirm', $data);
    $this->response->setContent($html);
  }

  public function delete()
  {
    $details = $this->request->getParameters();
    var_dump($details);
  }
}