<?php namespace MINI\Controllers;

class FacultyCheckin extends Controller
{

  public function display($params)
  {
    // get checked out reservation.
    $data = []; // checked reservation.

    $html = $this->view->render('FacultyCheckin', $data);
    $this->response->setContent($html);
  }

  public function checkin()
  {

  }
}
