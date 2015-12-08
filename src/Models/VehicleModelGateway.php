<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;
use MINI\Util\Clean;

class VehicleModelGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function findModel($makeID, $typeID, $name)
  {
    $SQL = "SELECT * FROM Models WHERE _idManufacturers = :make AND _idVehicleType = :type AND Model = :name";
    $statement = new Statement($this->connection);
    $statement->setInt("make", $makeID);
    $statement->setInt("type", $typeID);
    $statement->setStr("name", $name);
    return $statement->select($SQL)->first();
  }

  public function insert($makeID, $typeID, $name)
  {
    if ( $existsID = $this->findModel($makeID, $typeID, $name) ) return $existsID['idModels'];

    $SQL = "INSERT INTO Models (_idManufacturers, _idVehicleType, Model) VALUES (:make, :type, :name)";
    $statement = new Statement($this->connection);
    $statement->setInt("make", $makeID);
    $statement->setInt("type", $typeID);
    $statement->setStr("name", $name);
    return $statement->insert($SQL);
  }

}