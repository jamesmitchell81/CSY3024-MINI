<?php namespace MINI\Controllers;

class MaintenanceDetailItem extends Controller
{

  public function display($params)
  {


    $data = [
      'log' => $params['log']
    ];

    $html = $this->view->render('MaintenanceDetailItem', $data);
    $this->response->setContent($html);
  }

  public function add()
  {

  }
}