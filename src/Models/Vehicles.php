<?php namespace MINI\Models;

use MINI\Database\PDODatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class Vehicles
{
  private $data = [];
  private $connection;
  private $statement;

  public function __construct()
  {
    $this->connection = new Connection();
    $this->statement = new Statement();
  }

  public function getAllVehicles()
  {
    $SQL = "SELECT v.*, t.VehicleTypeName FROM Vehicles v INNER JOIN VehicleTypes t ON  v._idVehicleTypes = t.idVehicleTypes";
    return $this->statement->select($SQL)->all();
  }

  // public function getVehiclesByReg($registrations = [])
  // {

  // }


}