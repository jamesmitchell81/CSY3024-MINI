<?php namespace MINI\Database;

use PDO;

class PDODatabaseStatement
{
  private $connection;
  private $statement;
  private $parameters = [];
  private $fetchMode = PDO::FETCH_ASSOC;

  public function __construct(DatabaseConnection $db)
  {
    $this->db = $db;
    $this->connection = $this->db->open();
  }

  public function __destruct()
  {
    $this->db->close();
  }

  public function query($sql, $fetchMode = PDO::FETCH_ASSOC)
  {
    $this->fetchMode = $fetchMode;
    $this->statement = $this->prepare($sql)->bindParams();
    $this->statement->setFetchMode($this->fetchMode);
    return $this->statement->execute();
  }

  public function set($name, $value, $type = PDO::PARAM_STR)
  {
    $this->parameters[] = [
      'name'  => $name,
      'value' => $value,
      'type'  => $type
    ];
    return $this;
  }

  private function prepare($sql)
  {
    $this->statement = $this->connection->prepare($sql);
    return $this;
  }

  private function bindParams()
  {
    foreach ($this->parameters as $parameter) {
      $name = $parameter['name'];
      $value = &$parameter['value'];
      $type = $parameter['type'];

      $this->statement->bindParam($name, $value, $type);
    }
    return $this->statement;
  }

  public function setInt($name, $value)
  {
    $this->set($name, $value, PDO::PARAM_INT);
    return $this;
  }

  public function setStr($name, $value)
  {
    $this->set($name, $value, PDO::PARAM_STR);
    return $this;
  }

  public function setFetchMode($fetchMode)
  {
    $this->fetchMode = $fetchMode;
    return $this;
  }

  public function first()
  {
    return $this->statement->fetch();
  }

  public function all()
  {
    return $this->statement->fetchAll();
  }

  public function select($sql)
  {
    $this->query($sql);
    return $this;
  }

  public function insert($sql)
  {
    $this->query($sql);
    return $this->connection->lastInsertId();
  }

  public function update($sql)
  {
    return $this->query($sql);
  }

  public function delete($sql)
  {
    return $this->query($sql);
  }
}