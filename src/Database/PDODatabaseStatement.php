<?php namespace MINI\Database;

use PDO;

class PDODatabaseStatement
{
  private $connection;
  private $statement;
  public $parameters = [];
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
    if ( !$this->statement )
    {
      $this->prepare($sql); //->bindParams();
    }
    $this->bindParams();
    $this->statement->setFetchMode($this->fetchMode);

    try {
      $a = $this->statement->execute();
      return $a;
    } catch (\PDOException $e) {
      return $e;
    }
  }

  public function execute()
  {
    $this->statement->setFetchMode($this->fetchMode);
    $this->statement->execute();
    return $this;
  }

  public function getMetaData()
  {
    // return $this->statement->getColumnMeta(2);
  }

  public function set($name, $value, $type = PDO::PARAM_STR)
  {
    $this->parameters[$name] = [
      'name'  => $name,
      'value' => $value,
      'type'  => $type
    ];
    return $this;
  }

  public function prepare($sql)
  {
    $this->statement = $this->connection->prepare($sql);
    return $this;
  }

  public function bindParams()
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

  public function lastID()
  {
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

  public function fetchModeArray()
  {
    $this->setFetchMode(PDO::FETCH_NUM);
  }
}