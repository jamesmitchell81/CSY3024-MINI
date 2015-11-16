<?php namespace MINI\Controllers;

class FacultyReservation extends Controller
{

  public function display($params = [])
  {
    $data = ['action' => '/faculty/reserve/add'];

    if ( array_key_exists('action', $params) )
    {
      $data = ['action' => '/faculty/reserve/update'];
      // .. get current.
    }

    $html = $this->view->render('ReservationForm', $data);
    $this->response->setContent($html);
  }

  public function add()
  {
    var_dump($this->request->getParameters());
  }

  public function update()
  {
    var_dump($this->request->getParameters());
  }

  public function delete()
  {

  }
}
