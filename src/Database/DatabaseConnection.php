<?php namespace MINI\Database;

interface DatabaseConnection
{
  public function open();
  public function close();
}