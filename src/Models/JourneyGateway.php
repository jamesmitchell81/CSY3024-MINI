<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class JourneyGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function find($id)
  {
    $SQL = "SELECT * FROM JourneyView WHERE _idReservations = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", $id);
    return $statement->select($SQL)->first();
  }

  public function findCheckout($user)
  {
    $SQL = 'SELECT * FROM JourneyView
            WHERE _idFacultyMembers = :user AND OdometerEnd IS NULL';
    $statement = new Statement($this->connection);
    $statement->setInt('user', $user);
    return $statement->select($SQL)->all();
  }

  public function findCompleted($user)
  {
    $SQL = 'SELECT * FROM ReservationComplete
            WHERE _idFacultyMembers = :user AND OdometerEnd IS NOT NULL';
    $statement = new Statement($this->connection);
    $statement->setInt("user", $user);
    return $statement->select($SQL)->all();
  }

  public function findMiles($resID)
  {
    $SQL = 'SELECT (OdometerEnd - OdometerStart) As TotalMiles FROM Journeys
            WHERE _idReservations = :id AND NOT (OdometerEnd IS NULL)';
    $statement = new Statement($this->connection);
    $statement->setInt("id", $resID);
    return $statement->select($SQL)->first();
  }

  public function insert($vid, $rid, $mileage)
  {
    $SQL = "INSERT INTO Journeys (_idVehicles, _idReservations, OdometerStart) VALUES (:vid, :rid, :mileagestart)";
    $statement = new Statement($this->connection);
    $statement->setInt('vid', $vid);
    $statement->setInt('rid', $rid);
    $statement->setInt('mileagestart', $mileage);
    return $statement->insert($SQL);
  }

  public function update($vid, $rid, $mileage, $issues = "")
  {
    $SQL = 'UPDATE Journeys SET OdometerEnd = :mileage, MaintenanceIssues = :issues
            WHERE _idReservations = :rid AND _idVehicles = :vid';
    $statement = new Statement($this->connection);
    $statement->setInt("id", $resID)->setInt("mileage", $mileage);
    $statement->setStr("end", $date)->setStr("issues", $issues);
    return $statement->update($SQL);
  }

}