<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class BillingGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function insert($resID, $totalCost, $totalMileage, $fuel)
  {
    $SQL = 'INSERT INTO Billings (_idReservations, TotalCost, TotalMileage, FuelCost)
            VALUES (:id, :cost, :mileage, :fuel)';
    $statement = new Statement($this->connection);
    $statement->setInt("id", $resID)->setStr("cost", $totalCost);
    $statement->setInt("mileage", $totalMileage)->setStr("fuel", $fuel);
    return $statement->insert($SQL);
  }
}