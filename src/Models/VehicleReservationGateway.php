<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class VehicleReservationGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function findVehicles($resID)
  {
    $SQL = "SELECT _idVehicles FROM VehicleReservation WHERE _idReservations = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", $resID);
    return $statement->select($SQL)->all();
  }

  public function findReservation($vehicleID)
  {
    $SQL = "SELECT _idReservations FROM VehicleReservation WHERE _idVehicles = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", $vehicleID);
    return $statement->select($SQL)->first();
  }

  public function insert(VehicleReservations $vr) // $vehicleID, $resID)
  {
    $SQL = 'INSERT INTO VehicleReservation (_idVehicles, _idReservations) VALUES (:vid, :rid)';
    $statement = new Statement($this->connection);
    $statement->setInt("rid", $vr->reservation);

    foreach ($vr->vehicles as $vid)
    {
      $statement->setInt("vid", $vid);
      $statement->insert($SQL);
    }
  }

  public function update($vidOld, $vidNew, $rid)
  {

  }

  public function delete($rid)
  {
    $SQL = "DELETE FROM VehicleReservation WHERE _idReservations = :rid";
    $statement = new Statement($this->connection);
    $statement->setInt("rid", $rid);
    return $statement->delete($SQL);
  }
}