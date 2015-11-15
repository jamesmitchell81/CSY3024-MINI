<?php namespace MINI\Controllers;

class FacultyReservation extends Controller
{
  public function display()
  {
    $html = $this->view->render('ReservationForm');
    $this->response->setContent($html);
  }

  public function make()
  {
    var_dump($this->request->getParameters());
  }

}
