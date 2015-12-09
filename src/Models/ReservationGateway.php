<?php namespace MINI\Models;

use MINI\Database\MySQLDatabaseConnection as Connection;
use MINI\Database\PDODatabaseStatement as Statement;
use MINI\Util\Clean;

class ReservationGateway
{
  private $connection;

  public function __construct()
  {
    $this->connection = new Connection;
  }

  public function findByUser($id)
  {
    $SQL = 'SELECT r.idReservations, v.VehicleReg, v.Manufacturer, v.Model,
                   v.TypeName, v.Seats,
                   DATE_FORMAT(r.DepartureDate, "%W %D %M %Y at %H:%i") AS DepartureDate,
                   DATE_FORMAT(r.ReturnDueDate, "%W %D %M %Y at %H:%i") AS ReturnDueDate,
                   r.Destination,
                   DATEDIFF(r.ReturnDueDate, r.DepartureDate) AS Duration
            FROM Reservations r
            INNER JOIN VehicleView v ON r._idVehicles = v.idVehicles
            WHERE r._idFacultyMembers = :id';

    $statement = new Statement($this->connection);
    $statement->setInt("id", $id);
    return $statement->select($SQL)->all();
  }

  public function insert(Reservation $reservation)
  {

  }


}