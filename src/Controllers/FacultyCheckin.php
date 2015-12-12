<?php namespace MINI\Controllers;

use MINI\Util\Clean;
use MINI\Util\Validation;
use MINI\Models\ReservationGateway;
use MINI\Models\JourneyGateway;
use MINI\Models\BillingGateway;

class FacultyCheckin extends Controller
{

  public function display($params)
  {
    $resID = $params['reservation'];

    $journey = (new JourneyGateway)->find($resID);

    $data = [
      'action'  => "/faculty/checkin/{$resID}",
      'journey' => $journey
    ];

    $html = $this->view->render('FacultyCheckin', $data);
    $this->response->setContent($html);
  }

  public function checkin($params)
  {
    $resID = $params['reservation'];
    $details = $this->request->getParameters();

    // validate
    $valid = new Validation;
    $valid->validate('odometer-end', $details['odometer-end'])->required()->positiveInt();
    $valid->validate('fuel-purchased', $details['fuel-purchased'])->numberFloat();

    // update journeys.
    $mileage = Clean::int($details['odometer-end']);
    $issues = Clean::string($details['maintenance-issues']);

    // update journey
    (new JourneyGateway)->update($resID, $mileage, date('Y-m-d'), $issues);
    // update billings
    $totalMileage = (new JourneyGateway)->findMiles($resID)['TotalMiles'];
    // $mileageRate = (new ReservationGateway)->find($resID)['MileageRate'];
    $fuel = Clean::number($details['fuel-purchased']);

    $totalCost = ((int)$totalMileage * floatval($mileageRate)) + floatval($fuel);
    $billings = (new BillingGateway)->insert($resID, $totalCost, $totalMileage, $fuel);
    // update vehicles mileage, could be a trigger.


    header("Location: /faculty");
  }
}
