<?php namespace MINI\Controllers;

use Http\Request;
use Http\Response;

use MINI\Util\Session;
use MINI\Template\View;
use MINI\Models\FacultyGateway;
use MINI\Models\ReservationGateway;
use MINI\Models\JourneyGateway;

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
      $id = Session::get('id');

      // get user details, user reservations, checked out
      $details = (new FacultyGateway)->find($id);
      $reservations = (new ReservationGateway)->findUserPending($id);
      $checkedout = (new JourneyGateway)->findCheckout($id);
      $completed = (new JourneyGateway)->findCompleted($id);

      $data = [
        'details'      => $details,
        'reservations' => $reservations,
        'checkouts'    => $checkedout,
        'completed'    => $completed
      ];

      $html = $this->view->render('FacultyHome', $data);
      $this->response->setContent($html);
    }
}