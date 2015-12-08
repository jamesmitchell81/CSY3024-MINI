<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;
use MINI\Util\Clean;

class VehicleTypeGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function find($id)
  {
    $SQL = "SELECT * FROM VehicleType WHERE idVehicleType = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", Clean::int($id));
    $data = $statement->select($SQL)->first();
    return $data;
  }

  public function findByTypeAndSeats($typeName, $seats)
  {
    $SQL = "SELECT * FROM VehicleType WHERE TypeName = :name AND Seats = :seats";
    $statement = new Statement($this->connection);
    $statement->setStr("name", Clean::string($typeName));
    $statement->setInt("seats", Clean::int($seats));
    $data = $statement->select($SQL)->first();
    return $data;
  }

  public function findAll()
  {
    $SQL = "SELECT * FROM VehicleType";
    $statement = new Statement($this->connection);
    $data = $statement->select($SQL)->all();
    return $data;
  }

  public function findByTypeName($typeName)
  {
    $SQL = "SELECT * FROM VehicleType WHERE TypeName = :name";
    $statement = new Statement($this->connection);
    $statement->setStr("name", Clean::string($typeName));
    $data = $statement->select($SQL)->all();
    return $data;
  }

  public function insert($typeName, $seats)
  {
    if ( $existsID = $this->findByTypeAndSeats($typeName, $seats)) return $existsID['idVehicleType'];

    $SQL = "INSERT INTO VehicleType (TypeName, Seats) VALUES (:name, :seats)";
    $statement = new Statement($this->connection);
    $statement->setStr("name", Clean::string($typeName));
    $statement->setInt("seats", Clean::int($seats));
    return $statement->insert($SQL);
  }

  public function update($id, $typeName, $seats)
  {
    $SQL = "UPDATE VehicleType SET TypeName = :name, Seats = :seats WHERE idVehicleType = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", Clean::int($id));
    $statement->setStr("name", Clean::string($typeName));
    $statement->setInt("seats", Clean::int($seats));
    $success = $statement->insert($SQL);
    return $success;
  }

  public function delete($id)
  {
    // if related dont delete.
    $SQL = "DELETE FROM VehicleType WHERE idVehicleType = :id";

  }
}