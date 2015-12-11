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
    $SQL = 'SELECT * FROM JourneyComplete
            WHERE _idFacultyMembers = :user';
    $statement = new Statement($this->connection);
    $statement->setInt('user', $user);
    return $statement->select($SQL)->all();
  }

  public function findCompleted($user)
  {
    $SQL = 'SELECT * FROM JourneyComplete
            WHERE _idFacultyMembers = :user';
    $statement = new Statement($this->connection);
    $statement->setInt("user", $user);
    return $statement->select($SQL)->all();
  }

  public function findMiles($resID)
  {
    $SQL = 'SELECT (OdometerEnd - OdometerStart) As TotalMiles FROM Journey
            WHERE _idReservations = :id AND NOT (OdometerEnd IS NULL)';
    $statement = new Statement($this->connection);
    $statement->setInt("id", $resID);
    return $statement->select($SQL)->first();
  }

  public function insert($resID, $mileage, $date)
  {
    $SQL = "INSERT INTO Journey (_idReservations, OdometerStart, JourneyStart) VALUES (:id, :mileagestart, :dateStart)";
    $statement = new Statement($this->connection);
    $statement->setInt('id', $resID);
    $statement->setInt('mileagestart', $mileage);
    $statement->setStr('dateStart', $date);
    return $statement->insert($SQL);
  }

  public function update($resID, $mileage, $date, $issues = "")
  {
    $SQL = 'UPDATE Journey SET OdometerEnd = :mileage, JourneyEnd = :end, MaintenanceIssues = :issues
            WHERE _idReservations = :id';
    $statement = new Statement($this->connection);
    $statement->setInt("id", $resID)->setInt("mileage", $mileage);
    $statement->setStr("end", $date)->setStr("issues", $issues);
    return $statement->update($SQL);
  }

}