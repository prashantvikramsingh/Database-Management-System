CREATE TABLE Train
(
  TrainID Int NOT NULL AUTO_INCREMENT,
  TrainName Char(50) NOT NULL,
  TrainType Char(20) NOT NULL,
  PRIMARY KEY (TrainID)
)
;

-- Table TrainStatus

CREATE TABLE TrainStatus
(
  TrainStatusID Int NOT NULL AUTO_INCREMENT,
  TrainID Int NOT NULL,
  DaysName Char(20) NOT NULL,
  RunDate Date NOT NULL,
  PRIMARY KEY (TrainStatusID,TrainID)
)
;

-- Table Passenger

CREATE TABLE Passenger
(
  PassengerID Int NOT NULL AUTO_INCREMENT,
  StaffID Int NOT NULL,
  PassengerName Char(50) NOT NULL,
  DateOfBirth Date NOT NULL,
  Gender Char(1) NOT NULL,
  EmailID Char(50) NOT NULL,
  UserName Char(30) NOT NULL,
  Password Char(50) NOT NULL,
  PRIMARY KEY (PassengerID)
)
;

CREATE INDEX AdminPassenger_IDX ON Passenger (StaffID)
;

-- Table PassengerBooking

CREATE TABLE PassengerBooking
(
  PassengerBookingID Int NOT NULL AUTO_INCREMENT,
  PassengerID Int NOT NULL,
  TrainID Int NOT NULL,
  ClassType Char(20) NOT NULL,
  TravelDate Date NOT NULL,
  PRIMARY KEY (PassengerBookingID)
)
;

CREATE INDEX PassengerTicket_IDX ON PassengerBooking (PassengerID)
;

CREATE INDEX TrainTicket_IDX ON PassengerBooking (TrainID)
;

-- Table Station

CREATE TABLE Station
(
  StationID Int NOT NULL AUTO_INCREMENT,
  StationName Char(50) NOT NULL,
  PRIMARY KEY (StationID)
)
;

-- Table TrainStationType

CREATE TABLE TrainStationType
(
  TrainID Int NOT NULL,
  StationID Int NOT NULL,
  Type Char(50) NOT NULL,
  ArrivalTime Time,
  DepartureTime Time,
  Distance Int NOT NULL
)
;

ALTER TABLE TrainStationType ADD  PRIMARY KEY (TrainID,StationID)
;

-- Table PassengerStationType

CREATE TABLE PassengerStationType
(
  StationID Int NOT NULL,
  PassengerBookingID Int NOT NULL,
  Type Char(50) NOT NULL
)
;

ALTER TABLE PassengerStationType ADD  PRIMARY KEY (StationID,PassengerBookingID)
;

-- Table Staff

CREATE TABLE Staff
(
  StaffID Int NOT NULL AUTO_INCREMENT,
  Role Char(20) NOT NULL,
  UserName Char(30) NOT NULL,
  Password Char(40) NOT NULL,
  EmailID Char(60) NOT NULL,
  StaffName Char(50) NOT NULL,
  StaffSalary Int NOT NULL,
  PRIMARY KEY (StaffID)
)
;

-- Table ClassCategory

CREATE TABLE ClassCategory
(
  ClassCategoryID Int NOT NULL AUTO_INCREMENT,
  TrainStatusID Int NOT NULL,
  TrainID Int NOT NULL,
  Category Char(30) NOT NULL,
  SeatsBooked Int NOT NULL,
  SeatsRemaining Int NOT NULL,
  SeatsWaiting Int NOT NULL,
  PRIMARY KEY (ClassCategoryID,TrainStatusID,TrainID)
)
;

-- Table StaffTrain

CREATE TABLE StaffTrain
(
  TrainID Int NOT NULL,
  StaffID Int NOT NULL
)
;

ALTER TABLE StaffTrain ADD  PRIMARY KEY (TrainID,StaffID)
;

-- Table Payment

CREATE TABLE Payment
(
  PaymentID Int NOT NULL AUTO_INCREMENT,
  PassengerBookingID Int NOT NULL,
  PaymentAmount Decimal(10,2) NOT NULL,
  CardType Char(20) NOT NULL,
  PRIMARY KEY (PaymentID,PassengerBookingID)
)
;

-- Table PassengerTicket

CREATE TABLE PassengerTicket
(
  PNR Int NOT NULL AUTO_INCREMENT,
  PassengerBookingID Int NOT NULL,
  SeatNumber Char(20) NOT NULL,
  BookingDate Date NOT NULL,
  TicketStatus Char(20) NOT NULL,
  PRIMARY KEY (PNR,PassengerBookingID)
)
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE TrainStatus ADD CONSTRAINT Train_TrainStatus FOREIGN KEY (TrainID) REFERENCES Train (TrainID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE PassengerBooking ADD CONSTRAINT PasngrBooking_Ticket FOREIGN KEY (PassengerID) REFERENCES Passenger (PassengerID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE PassengerBooking ADD CONSTRAINT Train_Passenger FOREIGN KEY (TrainID) REFERENCES Train (TrainID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE TrainStationType ADD CONSTRAINT TrainStationStatus FOREIGN KEY (TrainID) REFERENCES Train (TrainID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE TrainStationType ADD CONSTRAINT StationTrainStatus FOREIGN KEY (StationID) REFERENCES Station (StationID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE PassengerStationType ADD CONSTRAINT StationPassengerStation FOREIGN KEY (StationID) REFERENCES Station (StationID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE PassengerStationType ADD CONSTRAINT PassengerStationBooking FOREIGN KEY (PassengerBookingID) REFERENCES PassengerBooking (PassengerBookingID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Passenger ADD CONSTRAINT AdminPassenger FOREIGN KEY (StaffID) REFERENCES Staff (StaffID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE ClassCategory ADD CONSTRAINT TrainCategory FOREIGN KEY (TrainStatusID, TrainID) REFERENCES TrainStatus (TrainStatusID, TrainID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE StaffTrain ADD CONSTRAINT TrainStaff FOREIGN KEY (TrainID) REFERENCES Train (TrainID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE StaffTrain ADD CONSTRAINT StaffTrain FOREIGN KEY (StaffID) REFERENCES Staff (StaffID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Payment ADD CONSTRAINT BookingPayment FOREIGN KEY (PassengerBookingID) REFERENCES PassengerBooking (PassengerBookingID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE PassengerTicket ADD CONSTRAINT BookingTicket FOREIGN KEY (PassengerBookingID) REFERENCES PassengerBooking (PassengerBookingID) ON DELETE RESTRICT ON UPDATE RESTRICT
;

