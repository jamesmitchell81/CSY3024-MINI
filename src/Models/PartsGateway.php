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

  public function partsUsedForItem($item)
  {
    $SQL = 'SELECT v.idPartsInventory, v.PartName, COUNT(v.idPartType) AS Count FROM PartsUsed u
              INNER JOIN PartsInventoryView v ON v.idPartsInventory = u._idPartsInventory
              WHERE u._idMaintenanceItem = :item GROUP BY idPartType';
    $statement = new Statement($this->connection);
    $statement->setInt('item', $item);
    return $statement->select($SQL)->all();
  }

  public function generatePartsInventory()
  {
    // get part types
    $SQL = "SELECT * FROM PartType";

    $statement = new Statement($this->connection);
    $data = $statement->select($SQL)->all();

    $mechanic = 11;

    $loc = "0000000000";

    foreach ($data as $d)
    {
      $part = $d['idPartType'];

      for ( $i = 0; $i < 15; $i++ )
      {
        $insert = 'INSERT INTO PartsInventory (_idPartType, _MechanicIn, DateIn, Location)
                   VALUES (:type, :mechanic, CURRENT_TIMESTAMP, :loc)';
        $statement = new Statement($this->connection);
        $statement->setInt("type", $part);
        $statement->setInt("mechanic", $mechanic);
        $statement->setStr("loc", $loc);
        $statement->insert($insert);
      }
    }

    $SQL = "SELECT * FROM PartsInventory";
    $statement = new Statement($this->connection);
    $data = $statement->select($SQL)->all();
    var_dump($data);
  }
}