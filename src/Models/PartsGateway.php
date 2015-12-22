<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class PartsGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function generatePartsInventory()
  {
    // get part types
    $SQL = "SELECT * FROM PartType";

    $statement = new Statement($this->connection);
    $data = $statement->select($SQL)->all();

    $mechanic = 11;

    foreach ($data as $d)
    {
      $part = $d['idPartType'];

      for ( $i = 0; $i < 15; $i++ )
      {
        $insert = "INSERT INTO PartsInventory (_idPartType, _MechanicIn, DateIn) VALUES (:type, :mechanic, CURRENT_TIMESTAMP)";
        $statement = new Statement($this->connection);
        $statement->setInt("type", $part);
        $statement->setInt("mechanic", $mechanic);
        $statement->insert($insert);
      }
    }

    $SQL = "SELECT * FROM PartsInventory";
    $statement = new Statement($this->connection);
    $data = $statement->select($SQL)->all();
    var_dump($data);
  }
}