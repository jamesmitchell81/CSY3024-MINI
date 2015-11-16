<?php namespace MINI\Controllers;

use Http\Request;
use Http\Response;
use MINI\Template\View;

class MaintenanceMOT extends Controller
{
  public function __construct(Request $request, Response $response, View $view)
  {
    parent::__construct($request, $response, $view);

    // Create maintenance record description, lognumber entrydate etc.
  }

  public function display($params)
  {
    $data = [];
    $html = $this->view->render('MOTChecklist', $data);
    $this->response->setContent($html);
  }
}