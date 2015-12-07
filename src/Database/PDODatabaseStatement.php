<?php namespace MINI\Database;

class PDODatabaseStatement implements DatabaseStatement
{
  private $connection;
  private $statement;
  private $parameters = [];
  private $fetchMode = PDO::FETCH_ASSOC;

  public function __construct()
  {
    $this->db = new DatabaseConnection();
    $this->connection = $this->db->connect();
  }

  public function __destruct()
  {
    $this->db->disconnect();
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
}