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

  public function find($id)
  {
    $SQL = "SELECT * FROM Reservations WHERE idReservations = :id";
    $statement = new Statement($this->connection);
    $statement->setInt($id);
    return $statement->select($sql)->first();
  }

  public function findAllByUser($userId)
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
    $statement->setInt("id", $userId);
    return $statement->select($SQL)->all();
  }

  public function findUserReservation($userId, $reservation)
  {
    $SQL = "SELECT * FROM Reservations WHERE _idFacultyMembers = :user AND idReservations = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("user", $userId);
    $statement->setInt("id", $reservation);
    return $statement->select($SQL)->first();
  }

  public function insert(Reservation $reservation)
  {
    $SQL = 'INSERT INTO Reservations (_idVehicles, _idFacultyMembers, DepartureDate, ReturnDueDate, Destination)
            VALUES (:vehicle, :faculty, :datefrom, :dateto, :destination)';

    $statement = new Statement($this->connection);
    $statement->setInt("vehicle", $reservation->vehicle);
    $statement->setInt("faculty", $reservation->facultyMember);
    $statement->setStr("datefrom", date('Y-m-d', strtotime($reservation->departure)));
    $statement->setStr("dateto", date('Y-m-d', strtotime($reservation->return)));
    $statement->setStr("destination", $reservation->destination);

    $success = $statement->insert($SQL);
    return $success;
  }


}