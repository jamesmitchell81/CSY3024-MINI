<?php namespace MINI\Controllers;

class MaintenanceCheckout extends Controller
{

  public function display($params)
  {
    // get vehicle details.
    $data = [
      'vehicle' => 'tfbs1',
      'type'    => 'hatchback',
      'seats'   => 5,
      'defaultDate' => date('Y-m-d')
    ];
    $html = $this->view->render("MaintenanceCheckout", $data);
    $this->response->setContent($html);
  }

  public function checkout()
  {
    $details = $this->request->getParameters();

    header("Location: /vehicle/maintenance-detail/1");
    exit;
  }
}