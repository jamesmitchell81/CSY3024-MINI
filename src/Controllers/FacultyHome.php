<?php namespace MINI\Controllers;

use Http\Request;
use Http\Response;

use MINI\Template\View;
use MINI\Models\FacultyGateway;

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

    public function display($params)
    {
      $id = $params['id'];

      // get user details.
      $details = (new FacultyGateway)->find($id);


      // get user reservations
      // get user checked out

      // show user reservations
      // show user checked out
      $data = [
        'details' => $details
      ];

      $html = $this->view->render('FacultyHome', $data);
      $this->response->setContent($html);
    }
}