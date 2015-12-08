<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;
use MINI\Util\Clean;

class VehicleMakeGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function find($id)
  {
    $SQL = "SELECT * FROM Manufacturers";
    $statement = new Statement($this->connection);
    $data = $statement->select($SQL)->first();
    return $data;
  }

  public function findByName($name)
  {
    $SQL = "SELECT * FROM Manufacturers WHERE Manufacturer = :name";
    $statement = new Statement($this->connection);
    $statement->setStr("name", Clean::string($name));
    $data = $statement->select($SQL)->first();
    return $data;
  }

  public function insert($name)
  {
    if ( $existsID = $this->findByName($name) ) return $existsID['idManufacturers'];
    $SQL = "INSERT INTO Manufacturers (Manufacturer) VALUES (:name)";
    $statement = new Statement($this->connection);
    $statement->setStr("name", Clean::string($name));
    return $statement->insert($SQL);
  }
}