

#### Index.php

```php

<?php

require __DIR__ . '/../src/bootstrap.php';

?>

```


#### bootstrap.php


```php

<?php
// following example from:
// https://github.com/PatrickLouys/no-framework-tutorial
namespace MINI;

use PDO;
use MINI\Util\Session as Session;

require __DIR__ . '/../vendor/autoload.php';

date_default_timezone_set('Europe/London');
error_reporting(E_ALL);

$env = 'dev';

// https://github.com/PatrickLouys/no-framework-tutorial
$whoops = new \Whoops\Run;
if ( $env === 'dev' ) {
  $whoops->pushHandler(new \Whoops\Handler\PrettyPageHandler);
} else {
  $whoops->pushHandler(function($e) {
    echo 'error!';
  });
}
$whoops->register();

// https://github.com/PatrickLouys/no-framework-tutorial
$injector = include('Dependencies.php');
$request = $injector->make('Http\HttpRequest');
$response = $injector->make('Http\HttpResponse');

Session::set('id', 10);

// https://github.com/PatrickLouys/no-framework-tutorial
foreach ($response->getHeaders() as $header) {
    header($header, false);
}

// https://github.com/PatrickLouys/no-framework-tutorial
$routeDefinitionCallback = function (\FastRoute\RouteCollector $r) {
    $routes = include('Routes.php');
    foreach ($routes as $route) {
        $r->addRoute($route[0], $route[1], $route[2]);
    }
};

// https://github.com/PatrickLouys/no-framework-tutorial
$dispatcher = \FastRoute\simpleDispatcher($routeDefinitionCallback);
$routeInfo = $dispatcher->dispatch($request->getMethod(), $request->getPath());

// https://github.com/PatrickLouys/no-framework-tutorial
switch ($routeInfo[0]) {
    case \FastRoute\Dispatcher::NOT_FOUND:
        $response->setContent('404 - Page not found');
        $response->setStatusCode(404);
        break;
    case \FastRoute\Dispatcher::METHOD_NOT_ALLOWED:
        $response->setContent('405 - Method not allowed');
        $response->setStatusCode(405);
        break;
    case \FastRoute\Dispatcher::FOUND:
        $className = $routeInfo[1][0];
        $method = $routeInfo[1][1];
        $vars = $routeInfo[2];

        $class = $injector->make($className);
        $class->$method($vars);
        break;
}

// https://github.com/PatrickLouys/no-framework-tutorial
echo $response->getContent();


?>

```

#### Routes.php

```php

<?php

return [
    // Global.
    ['GET',  '/insertParts',                 ['MINI\Controllers\InsertParts', 'insert']],
    // Mechanics.
    ['GET',   '/mechanic', ['MINI\Controllers\MechanicHome', 'display']],
    ['GET',   '/maintenance/checkout/general/issue/{issue:\d+}', ['MINI\Controllers\MaintenanceCheckout', 'display']],
    ['POST',  '/maintenance/checkout/general/issue/{issue:\d+}',      ['MINI\Controllers\MaintenanceCheckout', 'checkout']],
    ['GET',  '/maintenance/log/{log:\d+}', ['MINI\Controllers\MaintenanceDetail', 'display']],

    ['GET',  '/maintenance/log/{log:\d+}/complete', ['MINI\Controllers\MaintenanceDetail', 'complete']],

    ['GET',  '/maintenance/log/{log:\d+}/additem', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST',  '/maintenance/log/{log:\d+}/additem', ['MINI\Controllers\MaintenanceDetailItem', 'add']],
    ['GET',  '/maintenance/log/{log:\d+}/complete/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'complete']],
    ['GET',  '/maintenance/log/{log:\d+}/reopen/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'reopen']],
    ['GET',  '/maintenance/log/{log:\d+}/delete/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'delete']],
    ['GET',   '/maintenance/log/{log:\d+}/update/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'display']],
    ['POST',  '/maintenance/log/{log:\d+}/update/{item:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'update']],
    ['GET',   '/maintenance/log/{log:\d+}/update/{item:\d+}/parts/remove/{id:\d+}', ['MINI\Controllers\MaintenanceDetailItem', 'removePart']],

    // Vehicle Maintenance.
    ['GET',  '/vehicles',             ['MINI\Controllers\VehicleList',   'display']],
    // Parts.
    ['GET', '/parts', ['MINI\Controllers\PartsList', 'display']],
    // Department.
];

?>

```

#### Dependancies.php

```php

<?php
// https://github.com/PatrickLouys/no-framework-tutorial
$injector = new \Auryn\Injector;

$injector->alias('Http\Response', 'Http\HttpResponse');

$injector->share('Http\HttpRequest');
$injector->define('Http\HttpRequest', [
    ':get' => $_GET,
    ':post' => $_POST,
    ':cookies' => $_COOKIE,
    ':files' => $_FILES,
    ':server' => $_SERVER,
]);

$injector->alias('Http\Request', 'Http\HttpRequest');
$injector->share('Http\HttpResponse');

$injector->delegate('Twig_Environment', function() use ($injector) {
    $loader = new Twig_Loader_Filesystem(dirname(__DIR__) . '/templates');
    $twig = new Twig_Environment($loader, ['debug' => true]);
    $twig->addExtension(new Twig_Extension_Debug());
    return $twig;
});

$injector->alias('MINI\Template\View', 'MINI\Template\TwigRenderer');

return $injector;
// https://github.com/PatrickLouys/no-framework-tutorial

?>

```



```php

<?php

// Reference
// https://github.com/PatrickLouys/no-framework-tutorial

namespace MINI\Template;

interface FrontendRenderer extends View {}

?>

```

```php

<?php

namespace MINI\Template;

// Reference
// https://github.com/PatrickLouys/no-framework-tutorial

class FrontendTwigRenderer implements FrontendRenderer
{
  private $renderer;

  public function __construct(Renderer $renderer)
  {
    $this->renderer = $renderer;
  }

  public function render($template, $data = [])
  {
    $data = array_merge($data, [
      'menuItems' => [['href' => '/', 'text' => 'Home']],
      ]);
    return $this->renderer->renderer($template, $data);
  }
}
?>

```

```php

<?php

namespace MINI\Template;

// Reference
// https://github.com/PatrickLouys/no-framework-tutorial

use Twig_Environment;

class TwigRenderer implements View
{
  private $engine;

  public function __construct(Twig_Environment $engine)
  {
    $this->engine = $engine;
  }

  public function render($template, $data = [])
  {
    return $this->engine->render("$template.html", $data);
  }

}

?>

```

```php

<?php

namespace MINI\Template;

// Reference
// https://github.com/PatrickLouys/no-framework-tutorial

interface View
{
  public function render($template, $data = []);
}

?>

```

#### Controllers.

```php

<?php

namespace MINI\Controllers;

use Http\Request;
use Http\Response;
use MINI\Template\View;

abstract class Controller
{
  protected $request;
  protected $response;
  protected $view;

  public function __construct(Request $request, Response $response, View $view)
  {
    $this->request = $request;
    $this->response = $response;
    $this->view = $view;
  }
}

?>

```

```php

<?php namespace MINI\Controllers;

use MINI\Util\Session as Session;
use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class MechanicHome extends Controller
{

  public function display()
  {
    $connection = new Connection;
    $statement = new Statement($connection);

    //get mechanic view
    $SQL = "SELECT * FROM MechanicView WHERE idMINIEmployee = :id";
    $statement->setInt('id', Session::get('id'));
    $mechanic = $statement->select($SQL)->first();

    // get vehicles with issues that have not yet been added to maintenance.
    $SQL = 'SELECT * FROM VehicleReportedIssues';
    $statement = new Statement($connection);
    $issues = $statement->select($SQL)->all();

    // get vehicles in under maintenance.
    $SQL = 'SELECT * FROM Maintenance m
            INNER JOIN VehicleView v ON m._idVehicle = v.idVehicle
            WHERE _ReturnedBy IS NULL';
    $statement = new Statement($connection);
    $maintenance = $statement->select($SQL)->all();

    // display completed maintenance.
    $SQL = 'SELECT * FROM Maintenance m
            INNER JOIN VehicleView v ON m._idVehicle = v.idVehicle
            WHERE _ReturnedBy IS NOT NULL
            ORDER BY DateReturned DESC';
    $statement = new Statement($connection);
    $completed = $statement->select($SQL)->all();

    $data = [
      'mechanic'    => $mechanic,
      'issues'      => $issues,
      'maintenance' => $maintenance,
      'completed'   => $completed
    ];

    $html = $this->view->render('MechanicHome', $data);
    $this->response->setContent($html);
  }


}

?>

```

```php

<?php namespace MINI\Controllers;

use MINI\Util\Session as Session;
use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

use MINI\Models\PartsGateway;

class MaintenanceDetailItem extends Controller
{

  public function display($params)
  {
    $log = $params['log'];
    $description = '';
    $parts = [];
    $item = 0;
    $action = "/maintenance/log/$log/additem";

    // if the form is required for update
    if ( array_key_exists('item', $params) )
    {
      // get the description
      $item = $params['item'];
      $SQL = "SELECT ItemDescription FROM MaintenanceItem WHERE idMaintenanceItem = :item";
      $statement = new Statement(new Connection);
      $statement->setInt('item', $item);
      $description = $statement->select($SQL)->first()['ItemDescription'];

      // get the parts used
      $parts = (new PartsGateway)->partsUsedForItem($item);

      $action = "/maintenance/log/$log/update/$item";
    }

    // select part categories
    $SQL = "SELECT DISTINCT idPartCategory, PartCategoryName FROM PartCategory";
    $statement = new Statement(new Connection);
    $partCategories = $statement->select($SQL)->all();

    // select count of parts in stock
    $cid = 0;
    $SQL = "SELECT InStock, idPartType, PartName FROM PartsStockView WHERE idPartCategory = :cid";
    $statement = new Statement(new Connection);
    $statement->setInt('cid', $cid);
    $statement->prepare($SQL);
    $statement->bindParams();

    // add the stock parts to categories
    $length = count($partCategories);
    for ($i = 0; $i < $length; $i++ )
    {
      $statement->setInt('cid', (int)$partCategories[$i]['idPartCategory']);
      $statement->bindParams();
      $partCategories[$i]['parts'] = $statement->execute()->all();
    }

    $data = [
      'partCategories' => $partCategories,
      'log' => $log,
      'description' => $description,
      'item' => $item,
      'partsUsed' => $parts,
      'action' => $action
    ];

    $html = $this->view->render('MaintenanceDetailItem', $data);
    $this->response->setContent($html);
  }

  /**
  * Add new Maintenance Item
  *
  */
  public function add($params)
  {
    $errors = [];
    $log = $params['log'];
    $mechanic = Session::get('id');
    $input = $this->request->getParameters();
    $description = array_shift($input);

    $parts = [];

    foreach ($input as $key => $value) {
      if ( (int)$value > 0 )
      {
        $part = [
          'id' => (int)preg_replace('/^part-/', '', $key),
          'count' => (int)$value
        ];

        $parts[] = $part;
      }
    }

    // insert
    $SQL = 'INSERT INTO MaintenanceItem (_MaintenanceLogNumber, ItemDescription) VALUES  (:log, :description)';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $statement->setStr('description', $description);
    $item = $statement->insert($SQL);

    // $SQL = 'Call UsePart(:mechanic, :item, :part)';
    $SQL = 'INSERT INTO PartsUsed (_idPartsInventory, _MechanicOut, _idMaintenanceItem, DateOut)
            SELECT idPartsInventory, :mechanic, :item, CURRENT_TIMESTAMP FROM PartsInventory i
            WHERE i.idPartsInventory NOT IN (SELECT _idPartsInventory FROM PartsUsed)
            AND i._idPartType IN (SELECT idPartType FROM PartType WHERE idPartType = :part)
            ORDER BY DateIn DESC
            LIMIT 1';

    $statement = new Statement(new Connection);
    $statement->prepare($SQL);
    $statement->setInt('mechanic', $mechanic);
    $statement->setInt('item', $item);

    foreach ($parts as $part)
    {
      $statement->setInt('part', $part['id']);
      $statement->bindParams();
      for ( $i = 0; $i < $part['count']; $i++ )
      {
        $id = $statement->execute()->lastID();
        // to do
        // error needs to be displayed when insert fails.
      }
    }

    if ( $errors )
    {
      $params = [
        'log' => $log,
        'errors' => $errors
      ];
      $this->display($params);
    }

    header("Location: /maintenance/log/$log");
  }

  public function delete($params)
  {
    $log = $params['log'];
    $item = $params['item'];

    $SQL = "DELETE FROM MaintenanceItem WHERE idMaintenanceItem = :id";
    $statement = new Statement(new Connection);
    $statement->setInt('id', $item);
    $statement->delete($SQL);

    header("Location: /maintenance/log/$log");
  }

  public function complete($params)
  {
    $log = $params['log'];
    $item = $params['item'];
    $mechanic = Session::get('id');

    $SQL = 'UPDATE MaintenanceItem
            SET _CompletedBy = :mechanic, CompletionDate = CURRENT_TIMESTAMP
            WHERE idMaintenanceItem = :item';

    $statement = new Statement(new Connection);
    $statement->setInt('mechanic', $mechanic);
    $statement->setInt('item', $item);
    $statement->update($SQL);

    header("Location: /maintenance/log/$log");
  }

  public function reopen($params)
  {
    $log = $params['log'];
    $item = $params['item'];

    $SQL = 'UPDATE MaintenanceItem
            SET _CompletedBy = NULL, CompletionDate = NULL
            WHERE idMaintenanceItem = :item';

    $statement = new Statement(new Connection);
    $statement->setInt('item', $item);
    $statement->update($SQL);

    header("Location: /maintenance/log/$log");
  }

  public function update($params)
  {
    $log = $params['log'];
    $item = $params['item'];
    $mechanic = Session::get('id');
    $description = $this->request->getParameter('description');

    $SQL = 'UPDATE MaintenanceItem
            SET ItemDescription = :description
            WHERE idMaintenanceItem = :item';

    $statement = new Statement(new Connection);
    // $statement->setInt('mechanic', $mechanic);
    $statement->setInt('item', $item);
    $statement->setInt('description', $description);
    $statement->update($SQL);

    header("Location: /maintenance/log/$log");
  }

  public function removePart($params)
  {
    extract($params);

    $SQL = "DELETE FROM PartsUsed WHERE _idPartsInventory = :part";
    $statement = new Statement(new Connection);
    $statement->setInt('part', $id);
    $statement->delete($SQL);

    header("Location: /maintenance/log/$log/update/$item");
  }

}



?>

```

```php
<?php namespace MINI\Controllers;

use MINI\Models\PartsGateway;
use MINI\Util\Session;
use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class MaintenanceDetail extends Controller
{

  public function display($params)
  {
    $log = $params['log'];

    $SQL = 'SELECT * FROM  Maintenance l
            INNER JOIN VehicleView v ON v.idVehicle = l._idVehicle
            WHERE l.MaintenanceLogNumber = :log';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $details = $statement->select($SQL)->first();

    $SQL = 'SELECT * FROM MaintenanceItem i
            WHERE i._MaintenanceLogNumber = :log AND i._CompletedBy IS NULL';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $open = $statement->select($SQL)->all();

    $this->addParts($open);

    $SQL = 'SELECT * FROM MaintenanceItem i INNER JOIN MechanicView m ON i._CompletedBy = m.idMINIEmployee
            WHERE i._MaintenanceLogNumber = :log AND i._CompletedBy IS NOT NULL';
    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $completed = $statement->select($SQL)->all();

    // get parts used
    $this->addParts($completed);

    $data = [
      'details'   => $details,
      'open'      => $open,
      'completed' => $completed,
      'log'       => $log
    ];

    $html = $this->view->render('MaintenanceDetail', $data);
    $this->response->setContent($html);
  }

  public function complete($params)
  {
    $log = $params['log'];
    $mechanic = Session::get('id');

    $SQL = 'UPDATE Maintenance
            SET _ReturnedBy = :mechanic, DateReturned = CURRENT_TIMESTAMP
            WHERE MaintenanceLogNumber = :log';

    $statement = new Statement(new Connection);
    $statement->setInt('log', $log);
    $statement->setInt('mechanic', $mechanic);
    $complete = $statement->update($SQL);

    if ( !is_a($complete, "PDOException") )
    {
      header('Location:/mechanic');
    } else {
      $data = [
        'error'  => $complete->errorInfo[2],
        'return' => "/maintenance/log/$log"
      ];

      $html = $this->view->render('Error', $data);
      $this->response->setContent($html);
    }

  }

  private function addParts(&$arr)
  {
    $length = count($arr);
    for ( $i = 0; $i < $length; $i++ )
    {
       $parts = (new PartsGateway)->partsUsedForItem($arr[$i]['idMaintenanceItem']);
       $arr[$i]['parts'] = $parts;
    }
  }

}
?>

```

```php

<?php namespace MINI\Controllers;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;

class MaintenanceCheckout extends Controller
{

  public function display($params)
  {
    $issue = $params['issue'];

    // select from vehiclereported issues where idVehicle =
    $SQL = 'SELECT * FROM VehicleReportedIssues WHERE idReportedIssues = :issue';
    $statement = new Statement(new Connection);
    $statement->setInt('issue', $issue);
    $details = $statement->select($SQL)->first();

    $data = [
      'details' => $details
    ];

    $html = $this->view->render('MaintenanceCheckOut', $data);
    $this->response->setContent($html);
  }

  public function checkout($params)
  {
    $issue = $params['issue'];
    $description = $this->request->getParameter('description');

    $connection = new Connection();

    // get the vehicle form the issue number
    $SQL = "SELECT idVehicle FROM VehicleReportedIssues WHERE idReportedIssues = :issue";
    $statement = new Statement($connection);
    $statement->setInt('issue', $issue);
    $vehicle = $statement->select($SQL)->first()['idVehicle'];

    // insert the vehicle to maintenance
    $SQL = 'INSERT INTO Maintenance (_idVehicle, BriefDescription, MaintenanceEntryDate)
            VALUES (:vehicle, :description, CURRENT_TIMESTAMP)';
    $statement = new Statement($connection);
    $statement->setInt('vehicle', $vehicle);
    $statement->setInt('description', $description);
    $log = $statement->insert($SQL);

    // update the reported issues table
    $SQL = 'UPDATE ReportedIssues SET _MaintenanceLogNumber = :log WHERE idReportedIssues = :issue';
    $statement = new Statement($connection);
    $statement->setInt('log', $log);
    $statement->setInt('issue', $issue);
    $statement->update($SQL);

    header('Location:/mechanic');
  }
}
?>

```

#### Database.

```php

<?php namespace MINI\Database;

interface DatabaseConnection
{
  public function open();
  public function close();
}

?>

```

```php

<?php namespace MINI\Database;

use PDO;

class MySQLDatabaseConnection implements DatabaseConnection
{
  private $host;
  private $db_name;
  private $connection_str;
  private $user;
  private $password;
  private $db;

  public function __construct()
  {
    // need to get this from config file.
    $this->host = "localhost:3306";
    $this->db_name = "MINI";
    $this->connection_str = "mysql:host={$this->host};dbname={$this->db_name}";
    $this->user = "root";
    $this->password = "donkey";
  }

  public function open()
  {
    try {
      $this->db = new PDO($this->connection_str, $this->user, $this->password);
      $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
      echo "Err!!!: {$e->getMessage()}";
    }
    return $this->db;
  }

  public function close()
  {
    $this->db = null;
  }
}

?>

```

```php
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
?>

```

```php
<?php namespace MINI\Util;

class Session
{
  public function __construct()
  {
    if ( session_status() != PHP_SESSION_ACTIVE)
    {
        session_start();
    }
  }

  public function redirect_on_failed_validation($key, $value, $redirect = "index.php")
  {
    if ( isset($_SESSION[$key]) )
    {
      if ( !($_SESSION[$key] === $value) ) {
        $this->clear();
        if ( strlen($redirect) > 0 ) header("Location: {$redirect}");
      }
    } else {
      if ( strlen($redirect) > 0 ) header("Location: {$redirect}");
    }
  }

  public static function set($key, $value)
  {
    $_SESSION[$key] = $value;
  }

  public static function get($key)
  {
    return isset($_SESSION[$key]) ? $_SESSION[$key] : "";
  }

  public static function is_set($key)
  {
    return isset($_SESSION[$key]);
  }

  public static function clear()
  {
    session_destroy();
    $_SESSION = [];
  }
}

?>

```

#### Models.

```php
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
?>

```

#### Templates

##### Error.html

```twig

{% extends "Layout.html" %}
{% block content %}

<p class="info info-error">{{ error }}</p>

<a href="{{ return }}">Go back</a>

{% endblock %}
?>

```

##### Layout.html

```twig

<!DOCTYPE html>
<html>
<head>
  <title>{{ pagetitle }}</title>
  <link rel="stylesheet" href="/css/reset.css">
  <link rel="stylesheet" href="/css/table.css">
  <link rel="stylesheet" href="/css/typography.css">
  <link rel="stylesheet" href="/css/buttons.css">
  <link rel="stylesheet" href="/css/cards.css">
  <link rel="stylesheet" href="/css/forms.css">
</head>
<body>
  <div class="wrap">

{% block content %}
{% endblock %}
  </div>

</body>
</html>

```

##### MaintenanceCheckOut.html

```twig

{% extends "Layout.html" %}
{% block content %}

    <h1>Check out vehicle for general maintenance</h1>

    <h2>Issue Raised</h2>

    <table class="table-vert">
      <tr>
        <th>Vehicle</th>
        <td>{{ details.VehicleReg }} - {{ details.Vehicle }}</td>
      </tr>
      <tr>
        <th>Description</th>
        <td>{{ details.MaintenanceIssues }}</td>
      </tr>
      <tr>
        <th>Maintenance Entry Date</th>
        <td>{{ details.ReportedDate|date('l jS F Y H:i') }}</td>
      </tr>
    </table>


    <form action="/maintenance/checkout/general/issue/{{details.idReportedIssues}}"
          method="post"
          class="form form-50">
      <fieldset class="form__fieldset">
        <label class="form__label" for="description">Add a Brief Description</label>
        <textarea class="form__input" name="description" id="description" cols="30" rows="10"></textarea>
      </fieldset>
      <input class="form__button" type="submit" value="Checkout Vehicle">
    </form>

{% endblock %}


```

##### MaintenanceDetail.html

```twig

{% extends "Layout.html" %}
{% block content %}

    <a href="/mechanic">Home</a>

    <h1>Maintenance Detail</h1>

    <h2>Issue Raised</h2>

    <table class="table-vert">
      <tr>
        <th>Vehicle</th>
        <td>{{ details.VehicleReg }} - {{ details.Manufacturer }} {{ details.Model }}</td>
      </tr>
      <tr>
        <th>Description</th>
        <td>{{ details.BriefDescription }}</td>
      </tr>
      <tr>
        <th>Maintenance Entry Date</th>
        <td>{{ details.MaintenanceEntryDate|date('l jS F Y H:i') }}</td>
      </tr>
    </table>

    <a href="/maintenance/log/{{log}}/complete">Return Vehicle to service</a>

    {% if completed %}
    <h2>Completed items</h2>

    <table>
      <thead>
        <tr>
          <th>Item Description</th>
          <th>Parts Used</th>
          <th>Completed By</th>
          <th>Completion Date</th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {% for c in completed %}
        <tr>
          <td>
            <p>{{ c.ItemDescription }}</p>
          </td>
          <td>
            <ul>
            {% for part in c.parts %}
              <li>{{ part.PartName }}: {{ part.Count }}</li>
            {% endfor %}
            </ul>
          </td>
          <td>{{ c.FullName }}</td>
          <td>{{ c.CompletionDate|date('l jS F Y H:i') }}</td>
          <td><a href="/maintenance/log/{{log}}/reopen/{{c.idMaintenanceItem}}">Reopen</a></td>
          <td><a href="">Delete</a></td>
        </tr>
        {% endfor %}
      </tbody>
    </table>
    {% else %}
      <p class="info info-neutual">There are no completed items</p>
    {% endif %}

    <h2>Open Items</h2>

    {% if open %}
    <table>
      <thead>
        <tr>
          <th>Item Description</th>
          <th>Parts Used</th>
          <th></th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {% for o in open %}
        <tr>
          <td>
            <p>{{ o.ItemDescription }}</p>
          </td>
          <td>
            <ul>
            {% for part in o.parts %}
              <li>{{ part.PartName }}: {{ part.Count }}</li>
            {% endfor %}
            </ul>
          </td>
          <td><a href="/maintenance/log/{{log}}/complete/{{o.idMaintenanceItem}}">Mark Complete</a></td>
          <td><a href="/maintenance/log/{{log}}/update/{{o.idMaintenanceItem}}">Update</a></td>
          <td><a href="/maintenance/log/{{log}}/delete/{{o.idMaintenanceItem}}">Delete</a></td>
        </tr>
        {% endfor %}
      </tbody>
    </table>
    {% else %}
    <p class="info info-neutual">The are not open items</p>
    {% endif %}

    <a href="/maintenance/log/{{log}}/additem">Add Item</a>

{% endblock %}

```

##### MaintenanceDetailItem.html

```twig

{% extends "Layout.html" %}
{% block content %}

    <h1>Add Maintenance Item</h1>

    <form action="{{ action }}"
          method="post"
          class="form form-50">
      <input class="form__button" type="submit" value="Complete Item">

      <a href="/maintenance/log/{{log}}">Cancel and return</a>

      <fieldset class="form__fieldset">
        <label class="form__label" for="description">Add an item description</label>
        <textarea class="form__input" name="description" id="description" cols="30" rows="10" required>{{ description }}</textarea>
      </fieldset>

      {% if not partsUsed is empty %}
      <fieldset class='form__fieldset'>
        <legend class='form__legend'>Parts Used</legend>
        <table>
          <tbody>
            {% for part in partsUsed %}
            <tr>
              <td>{{ part.PartName }}</td>
              <td>{{ part.Count }}</td>
              <td>
                <a href="/maintenance/log/{{log}}/update/{{item}}/parts/remove/{{part.idPartsInventory}}">Delete one</a>
              </td>
            </tr>
            {% endfor %}
          </tbody>
        </table>

      </fieldset>
      {% endif %}

      <fieldset class='form__fieldset'>
        <legend class='form__legend'>Select parts</legend>
        {% for category in partCategories %}
          <table class="form__table">
            <thead>
              <tr>
                <th colspan="2">{{ category.PartCategoryName }}</th>
              </tr>
            </thead>
            <tbody>
              {% for part in category.parts %}
              <tr>
                <td>
                  {{ part.PartName }}
                </td>
                <td>
                  {% if part.InStock == 0 %}
                  <span class="form__error">
                    Item out of stock!
                  </span>
                  {% else %}
                  <input name="part-{{ part.idPartType }}"
                         id="part-{{ part.idPartType }}"
                         class="form__input"
                         type="number"
                         max="{{ part.InStock }}"
                         min="0"
                         value="0">
                  {% endif %}
                </td>
              </tr>
              {% endfor %}
            </tbody>
          </table>

        {% endfor %}
      </fieldset>
      <input class="form__button" type="submit" value="Complete Item">
    </form>

{% endblock %}

```

##### MechanicHome.html

```twig

{% extends "Layout.html" %}
{% block content %}
    <h1>Mechanic Home</h1>

    {{ mechanic.FullName }}

    <h2>Reported Issues</h2>

    {% if issues %}
    <table>
      <thead>
        <th>Vehicle Reg</th>
        <th>Vehicle</th>
        <th>Reported Issue</th>
        <th>Reported</th>
        <th></th>
      </thead>
      <tbody>
        {% for issue in issues %}
        <tr>
          <td>{{ issue.VehicleReg }}</td>
          <td>{{ issue.Vehicle }}</td>
          <td>{{ issue.MaintenanceIssues }}</td>
          <td>{{ issue.ReportedDate }}</td>
          <td><a href="/maintenance/checkout/general/issue/{{issue.idReportedIssues}}">Checkout</a></td>
        </tr>
        {% endfor %}
      </tbody>
    </table>
    {% else %}
      <p class="info info-success">The are currently no reported issues.</p>
    {% endif %}

    <h2>Under Maintenance</h2>

    {% if maintenance %}
    <table>
      <thead>
        <th>Vehicle Reg</th>
        <th>Vehicle</th>
        <th>Description</th>
        <th>Reported</th>
        <th></th>
      </thead>
      <tbody>
        {% for vehicle in maintenance %}
        <tr>
          <td>{{ vehicle.VehicleReg }}</td>
          <td>{{ vehicle.Manufacturer }} {{ vehicle.Model }}</td>
          <td>{{ vehicle.BriefDescription }}</td>
          <td>{{ vehicle.MaintenanceEntryDate }}</td>
          <td><a href="/maintenance/log/{{vehicle.MaintenanceLogNumber}}">View Details</a></td>
        </tr>
        {% endfor %}
      </tbody>
    </table>
    {% else %}
      <p class="info info-neutral">There are no vehicles undergoing maintenance</p>
    {% endif %}


    <h2>Completed Maintenance</h2>

    {% if completed %}
    <table>
      <thead>
        <th>Vehicle Reg</th>
        <th>Vehicle</th>
        <th>Description</th>
        <th>Reported</th>
      </thead>
      <tbody>
        {% for complete in completed %}
        <tr>
          <td>{{ complete.VehicleReg }}</td>
          <td>{{ complete.Manufacturer }} {{ complete.Model }}</td>
          <td>{{ complete.BriefDescription }}</td>
          <td>{{ complete.DateReturned }}</td>
        </tr>
        {% endfor %}
      </tbody>
    </table>
    {% else %}
      <p class="info info-neutral">There are no completed maintenance items</p>
    {% endif %}

{% endblock %}

```


