<?php namespace MINI\Controllers;

class MaintenanceDetailItem extends Controller
{
  public function display($params)
  {
    // get vehicle and lognumber details.
    $data = ['action' => '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item'];

    if ( $params )
    {
      $data = ['action' => '/vehicle/{reg}/maintenance-detail/{lognumber}/maintenace-item/update/{id:\d}'];
    }

    $html = $this->view->render('MaintenanceItemForm', $data);
    $this->response->setContent($html);
  }

  public function displayRemove($params)
  {
    var_dump($params);

    $data = [];
    $html = $this->view->render('MaintenanceItemDeleteConfirm', $data);
    $this->response->setContent($html);
  }

  public function add($params)
  {
    var_dump($params);
    $data = $this->request->getParameters();
    var_dump($data);
    // validate

    // insert

    // redirect
  }

  public function update()
  {
    $details = $this->request->getParameters();

    // validate

    // update.

    // redirect.
  }

  public function delete($params)
  {
    $data = $this->request->getParameters();

    // validate

    // delete

    // redirect.
  }
}