<?php

namespace MINI\Controllers;

use Http\Request;
use Http\Response;
use MINI\Template\View;

abstract class Controller
{
  protected $request;
  protected $response;
  protected $view;

  public function __construct(Request $request, Response $response, View $view)
  {
    $this->request = $request;
    $this->response = $response;
    $this->view = $view;
  }
}