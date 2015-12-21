<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;
use MINI\Util\Clean;

class FacultyGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function find($id)
  {
    $SQL = "SELECT * FROM FacultyMembersView WHERE idFacultyMembers = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", $id);
    $data = $statement->select($SQL)->first();
    var_dump($statement->getMetaData());
    return;
  }


}