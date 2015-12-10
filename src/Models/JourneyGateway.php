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

  public function findCheckout($user)
  {
    $SQL = 'SELECT * FROM JourneyView
            WHERE _idFacultyMembers = :user
            AND OdometerEnd IS NULL';
    $statement = new Statement($this->connection);
    $statement->setInt('user', $user);
    return $statement->select($SQL)->all();
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

  public function update()
  {

  }

}