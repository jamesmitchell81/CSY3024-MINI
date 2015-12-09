<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;
use MINI\Util\Clean;

// Table Gateway Pattern, Patterns of Enterprise Application Architecture.
class VehicleGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function findAll()
  {
    $SQL = "SELECT * FROM VehicleView";
    $statement = new Statement($this->connection);
    $data = $statement->select($SQL)->all();
    return $data;
  }

  public function find($id)
  {
    $SQL = "SELECT * FROM VehicleView WHERE idVehicles = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", Clean::int($id));
    return $statement->select($SQL)->first();
  }

  public function findByReg($reg)
  {
    $SQL = "SELECT * FROM VehicleView WHERE VehicleReg = :reg";
    $statement = new Statement($this->connection);
    $statement->setStr("reg", Clean::string($reg));
    return $statement->select($SQL)->first();
  }

  public function findAvailable($start, $end)
  {
    $reservations = 'SELECT _idVehicles FROM Reservations
                     WHERE (:start BETWEEN DepartureDate AND ReturnDueDate)
                     AND (:end BETWEEN DepartureDate AND ReturnDueDate)';
    $maintenance = "SELECT _idVehicle FROM Maintenance WHERE DateReturned IS NULL AND DateReturned > :start";
    $SQL = "SELECT idVehicles FROM Vehicles WHERE idVehicles NOT IN ({reservations}) AND idVehicles NOT IN ({$maintenance})";
    $statement = new Statement($this->connection);
    $statement->setStr("start", $start);
    $statement->setStr("end", $end);

    $data = $statement->select($SQL)->all();
    $available = implode(",", $data);



    return $statement->select($SQL)->all();
  }

  public function insert(Vehicle $vehicle)
  {
    // if reg... this vehicle already exists.

    // get the relation ids.
    $type = (new VehicleTypeGateway)->insert($vehicle->type, $vehicle->seats);
    $make = (new VehicleMakeGateway)->insert($vehicle->manufacturer);
    $model = (new VehicleModelGateway)->insert($make, $type, $vehicle->model);

    $SQL = 'INSERT INTO Vehicles (_idModels, VehicleReg, MileageRate, CurrentMileage)
            VALUES (:model, :reg, :rate, :mileage)'; //, :image)';

    $statement = new Statement($this->connection);
    $statement->setInt("model", $model);
    $statement->setStr("reg", $vehicle->reg);
    $statement->set("rate", $vehicle->mileageRate);
    $statement->set("mileage", $vehicle->currentMileage);
    return $statement->insert($SQL);
  }

  public function update()
  {

  }

  public function deleteByReg($reg)
  {

  }

  public function deleteByID($id)
  {

  }
}