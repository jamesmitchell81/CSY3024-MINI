<?php

namespace MINI\Controllers;

use Http\Request;
use Http\Response;
use MINI\Template\View;

class FacultyHome
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

    public function display()
    {
      // get user reservations
      // get user checked out

      // show user reservations
      // show user checked out
      $data = [];
      $html = $this->view->render('FacultyHome', $data);
      $this->response->setContent($html);
    }
}