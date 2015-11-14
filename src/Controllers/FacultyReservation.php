<?php namespace MINI\Controllers;

use Http\Request;
use Http\Response;
use MINI\Template\View;

class FacultyReservation
{
  private $request;
  private $response;
  private $view;

  public function __construct(Request $request, Response $response, View $view)
  {
    $this->request = $request;
    $this->response = $response;
    $this->view = $view;
  }

  public function show()
  {
    $html = $this->view->render('ReservationForm');
    $this->response->setContent($html);
  }

  public function make()
  {
    var_dump($this->request->getParameters());
  }

}
