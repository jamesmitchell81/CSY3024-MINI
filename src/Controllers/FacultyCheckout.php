<?php namespace MINI\Controllers;

class FacultyCheckout extends Controller
{

  public function display($params)
  {
    // get reservation by id.
    // get reserved vehicle.
    // get vehicle odominator current.
    $data = [
      'odometerStart' => 1234
    ];
    $html = $this->view->render('ReservationCheckout', $data);
    $this->response->setContent($html);
  }

  public function checkout()
  {
    $current = $this->request->getParameters();
    // insert current, update current.
    // $this->response->redirect('http://localhost/faculty');
    header("Location: /faculty");
    exit;
  }

}