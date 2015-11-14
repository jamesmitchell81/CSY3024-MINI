<?php

namespace MINI\Controllers;

use Http\Request;
use Http\Response;
use MINI\Template\View;

class Home
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
        $data = [
            'name' => $this->request->getParameter('name', 'stranger'),
            'pagetitle' => 'Home',
            'menuItems' => [['href' => '/', 'text' => 'Home']],
        ];
        // $html = $this->renderer->render('Home', $data);
        $html = $this->view->render('Login', $data);
        $this->response->setContent($html);
    }
}