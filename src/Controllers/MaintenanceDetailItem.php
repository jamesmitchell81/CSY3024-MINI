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


