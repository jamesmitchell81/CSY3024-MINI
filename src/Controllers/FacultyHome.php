<?php

namespace MINI\Controllers;

use Http\Request;
use Http\Response;
use MINI\Template\view;

class FacultyHome
{

    private $request;
    private $response;
    private $view;

    public function __construct(Request $request, Response $view, Renderer $view)
    {
        $this->request = $request;
        $this->response = $response;
        $this->renderer = $view;
    }

    public function show()
    {
      // get user reservations
      // get user checked out

      // show user reservations
      // show user checked out
    }
}