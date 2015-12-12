<?php namespace MINI\Controllers;

use Http\Request;
use Http\Response;

use MINI\Util\Session;
use MINI\Template\View;
use MINI\Models\FacultyGateway;
use MINI\Models\ReservationGateway;
use MINI\Models\JourneyGateway;
use MINI\Models\VehicleGateway;

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
      $uid = Session::get('id');

      // get user details, user reservations, checked out
      $details = (new FacultyGateway)->find($uid);
      $reservations = (new ReservationGateway)->findUserPending($uid);
      $checkedout = (new JourneyGateway)->findCheckout($uid);
      $completed = (new JourneyGateway)->findCompleted($uid);

      $vehicles = [];
      $vehicleDB = new VehicleGateway;
      foreach ($reservations as $key => $reservation) {
        $id = $reservation['idReservations'];
        $reservations[$key]['vehicles'] = $vehicleDB->findReservationVehicles($id);
      }

      $data = [
        'userdetails'  => $details,
        'reservations' => $reservations,
        'checkouts'    => $checkedout,
        'completed'    => $completed
      ];

      $html = $this->view->render('FacultyHome', $data);
      $this->response->setContent($html);
    }
}