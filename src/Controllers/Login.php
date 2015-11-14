<?php namespace MINI\Controllers;

use Http\Request;
use Http\Response;

class Login
{
    private $request;
    private $response;

    public function __construct(Request $request, Response $response)
    {
        $this->request = $request;
        $this->response = $response;
    }

    public function authorise()
    {
      var_dump($this->request->getParameter('email'),
        $this->request->getParameter('password'));
    }
}