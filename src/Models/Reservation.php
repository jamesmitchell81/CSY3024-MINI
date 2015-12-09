<?php namespace MINI\Models;

class Reservation
{
  public $facultyMember;
  public $vehicle;
  public $status = "Pending";
  public $departure;
  public $return;
}