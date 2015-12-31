<?php namespace MINI\Controllers;

use MINI\Models\PartsGateway;

class InsertParts extends Controller
{

  public function insert()
  {
    $parts = (new PartsGateway)->generatePartsInventory();

  }
}