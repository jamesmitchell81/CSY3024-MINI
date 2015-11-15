<?php namespace MINI\Controllers;

class MechanicHome extends Controller
{

  public function display()
  {
    $data = [];
    $html = $this->view->render("MechanicHome", $data);
    $this->response->setContent($html);
  }
}