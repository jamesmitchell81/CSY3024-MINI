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
    $SQL = 'SELECT r.idReservations, v.VehicleReg, v.Manufacturer, v.Model,
                   v.TypeName, v.Seats, r.DepartureDate, r.ReturnDueDate,
                   r.Destination
            FROM Reservations r
            INNER JOIN VehicleView v ON r._idVehicles = v.idVehicles
            WHERE r._idFacultyMembers = :id
            AND idReservations NOT IN (SELECT _idReservations FROM Journey WHERE OdometerEnd IS NULL)
            AND idReservations NOT IN (SELECT _idReservations FROM Billings)';

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

  // move to vehicles.
  public function findVehicle($reservationID)
  {
    $SQL = "SELECT * FROM VehicleView WHERE idVehicles IN (SELECT _idVehicles FROM Reservations WHERE idReservations = :id)";
    $statement = new Statement($this->connection);
    $statement->setInt("id", $reservationID);
    return $statement->select($SQL)->all();
  }

  public function insert(Reservation $reservation)
  {
    $SQL = 'INSERT INTO Reservations (_idVehicles, _idFacultyMembers, DepartureDate, ReturnDueDate, Destination, MileageRate)
            VALUES (:vehicle, :faculty, :datefrom, :dateto, :destination, :rate)';
    $statement = new Statement($this->connection);
    $statement->setInt("vehicle", $reservation->vehicle);
    $statement->setInt("faculty", $reservation->facultyMember);
    $statement->setStr("datefrom", date('Y-m-d', strtotime($reservation->departure)));
    $statement->setStr("dateto", date('Y-m-d', strtotime($reservation->return)));
    $statement->setStr("destination", $reservation->destination);
    $statement->setStr('rate', $reservation->mileageRate);

    $success = $statement->insert($SQL);
    return $success;
  }

  public function update(Reservation $reservation)
  {
    $SQL = 'UPDATE Reservations SET _idVehicles = :vehicle, DepartureDate = :datefrom,
                                    ReturnDueDate = :dateto, Destination = :destination,
                                    MileageRate = :rate
            WHERE idReservations = :id';

    $statement = new Statement($this->connection);
    $statement->setInt("id", $reservation->id);
    $statement->setInt("vehicle", $reservation->vehicle);
    $statement->setStr("datefrom", date('Y-m-d', strtotime($reservation->departure)));
    $statement->setStr("dateto", date('Y-m-d', strtotime($reservation->return)));
    $statement->setStr("destination", $reservation->destination);
    $statement->setStr('rate', $reservation->mileageRate);

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