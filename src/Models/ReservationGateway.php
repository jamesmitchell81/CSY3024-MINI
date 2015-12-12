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
    $statement->setInt("id", $id);
    return $statement->select($SQL)->first();
  }

  public function findUserPending($userId)
  {
    $SQL = 'SELECT r.idReservations, r.DepartureDate, r.ReturnDueDate, r.Destination
            FROM Reservations r
            WHERE r._idFacultyMembers = :id
            AND idReservations IN (SELECT j._idReservations FROM Journeys j WHERE j.OdometerEnd IS NULL AND j._idReservations = r.idReservations)
            AND idReservations NOT IN (SELECT _idReservations FROM Billings)';

    $statement = new Statement($this->connection);
    $statement->setInt("id", $userId);
    return $statement->select($SQL)->all();
  }

  public function findPendingVehicles($rid)
  {
    $vid = 'SELECT _idVehicles FROM VehicleReservation
            WHERE _idVehicles NOT IN (SELECT _idVehicles FROM Journeys WHERE _idReservations = :rid)
            AND _idReservations = :rid';
    $SQL = 'SELECT * FROM VehicleView WHERE idVehicles IN (' . $vid . ')';

    $statement = new Statement($this->connection);
    $statement->setInt("rid", $rid);
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

  // move to vehicles.
  public function findVehicle($reservationID)
  {
    $SQL = 'SELECT * FROM VehicleView
            WHERE idVehicles IN (SELECT _idVehicles FROM VehicleReservation WHERE _idReservations = :id)';
    $statement = new Statement($this->connection);
    $statement->setInt("id", $reservationID);
    return $statement->select($SQL)->all();
  }

  public function insert($uid, $departure, $return, $destination)
  {
    $SQL = 'INSERT INTO Reservations (_idFacultyMembers, DepartureDate, ReturnDueDate, Destination)
            VALUES (:faculty, :datefrom, :dateto, :destination)';
    $statement = new Statement($this->connection);
    $statement->setInt("faculty", $uid);
    $statement->setStr("datefrom", date('Y-m-d', strtotime($departure)));
    $statement->setStr("dateto", date('Y-m-d', strtotime($return)));
    $statement->setStr("destination", $destination);
    $success = $statement->insert($SQL);
    return $success;
  }

  public function update($rid, $departure, $return, $destination)
  {
    $SQL = 'UPDATE Reservations SET DepartureDate = :datefrom,
                                    ReturnDueDate = :dateto, Destination = :destination
            WHERE idReservations = :id';

    $statement = new Statement($this->connection);
    $statement->setInt("id", $rid);
    $statement->setStr("datefrom", date('Y-m-d', strtotime($departure)));
    $statement->setStr("dateto", date('Y-m-d', strtotime($return)));
    $statement->setStr("destination", $destination);

    $success = $statement->update($SQL);
    return $success;
  }

  public function delete($reservation)
  {
    $SQL = "DELETE FROM Reservations WHERE idReservations = :id";
    $statement = new Statement($this->connection);
    $statement->setInt("id", $reservation);
    return $statement->delete($SQL);
  }
}