#Creating a Database named HotelManagement
CREATE DATABASE HotelManagement;
SHOW DATABASES;

#Using the created database HotelManagement
use HotelManagement;

#Creating Tables in HotelManagement Database

#Guests Table
CREATE TABLE Guests (
    GuestID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Contact VARCHAR(15),
    Address VARCHAR(255)
);

#Hotels Table
CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Contact VARCHAR(15)
);

#Rooms Table
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    RoomNumber INT NOT NULL,
    RoomType VARCHAR(50) NOT NULL,
    Tariff DECIMAL(10,2)
);

#Reservations Table
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    GuestID INT,
    HotelID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    NumberOfGuests INT,
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

#Room_Reservations Junction Table
CREATE TABLE Room_Reservations (
    RoomID INT,
    ReservationID INT,
    PRIMARY KEY (RoomID, ReservationID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);

DROP table Reservations;
DROP table Room_Reservations;
DROP table Rooms;
DROP table Hotels;
DROP table Guests;

#Insert Data into Tables

#Insert into Guest Table
INSERT INTO Guests (GuestID, FirstName, LastName, Contact, Address) VALUES
(1, 'John', 'Doe', '4632567756', '123 Elm St.'),
(2, 'Allison', 'Allphin', '5202566758', '456 Oak St.'),
(3, 'Drake', 'Morrison', '5205996980', '789 Pine St.'),
(4, 'Ben', 'Murray', '2565207766', '321 Maple St.'),
(5, 'Robin', 'Wong', '5205994632', '654 Cedar St.'),
(6, 'Jennifer', 'Smith', '5995344632', '109 Seneca St.'),
(7, 'Alan', 'Turner', '5206706955', '777 Birch St.'),
(8, 'David', 'Frith', '5203437898', '888 Spruce St.'),
(9, 'Mike', 'Mckannon', '4637734653', '999 Maple Ave.'),
(10, 'Roy', 'Harper', '5201126979', '111 Oak Blvd.');


#Insert into Hotel Table
INSERT INTO Hotels (HotelID, HotelName, Location, Contact) VALUES
(1, 'Ivory Stays Chicago', 'Chicago, IL', '3121234567'),
(2, 'Ivory Stays Manhattan', 'Manhattan, NY', '2121234567'),
(3, 'Ivory Stays Seattle', 'Seattle, WA', '2061234567'),
(4, 'Ivory Stays Phoenix', 'Phoenix, AZ', '4801234567'),
(5, 'Ivory Stays Los Angeles', 'Los Angeles, CA', '2131234567'),
(6, 'Ivory Stays Boston', 'Boston, MA', '2131234567'),
(7, 'Ivory Stays Las Vegas', 'Las Vegas, NV', '2251234899'),
(8, 'Ivory Stays California', 'California, CA', '2167426789'),
(9, 'Ivory Stays San Diego', 'San Diego Angeles, CA', '2092910108'),
(10, 'Ivory Stays Sedona', 'Sedona, AZ', '2354678819');

#Insert into Rooms Table
INSERT INTO Rooms (RoomID, RoomNumber, RoomType, Tariff) VALUES
(1, 101, 'Suite', 300.00),
(2, 102, 'Deluxe Room', 200.00),
(3, 103, 'Villa', 500.00),
(4, 104, 'Penthouse', 1000.00),
(5, 105, 'Standard Room', 150.00),
(6, 106, 'Presidential Suite', 400.00);

#Insert into Reservations Table
INSERT INTO Reservations (ReservationID, GuestID, HotelID, CheckInDate, CheckOutDate, NumberOfGuests) VALUES
(1, 1, 3, '2023-05-05', '2023-05-09', 2),
(2, 2, 4, '2022-10-09', '2022-10-11', 3),
(3, 3, 2, '2023-01-22', '2023-01-27', 1),
(4, 4, 1, '2022-08-20', '2022-08-24', 2),
(5, 5, 6, '2023-10-10', '2023-10-15', 3),
(6, 6, 5, '2022-12-21', '2022-12-26', 1);


#Insert into Room_Reservations Table
INSERT INTO Room_Reservations (RoomID, ReservationID) VALUES
(3, 1), -- Reservation 1 books Room 3
(4, 2), -- Reservation 2 books Room 4
(1, 3), -- Reservation 3 books Room 1
(2, 3), -- Reservation 3 also books Room 2
(2, 4), -- Reservation 4 books Room 2
(5, 4), -- Reservation 4 also books Room 5
(3, 5), -- Reservation 5 books Room 3
(5, 6); -- Reservation 6 books Room 5

#Displaying the Data in the Tables created
SELECT * FROM Guests ORDER BY GuestID;

SELECT * FROM Hotels ORDER BY HotelID;

SELECT * FROM Rooms ORDER BY RoomID;

SELECT * FROM Reservations ORDER BY ReservationID;

SELECT * FROM Room_Reservations ORDER BY RoomID, ReservationID;

#INNER JOIN Query
SELECT
    Res.ReservationID,
    Res.GuestID,
    Res.HotelID,
    Rm.RoomID,
    Rm.RoomType,
    Rm.Tariff,
    Res.CheckInDate,
    Res.CheckOutDate,
    Res.NumberOfGuests
FROM
    HotelManagement.Room_Reservations AS RmRes
INNER JOIN HotelManagement.Reservations AS Res ON RmRes.ReservationID = Res.ReservationID
INNER JOIN HotelManagement.Rooms AS Rm ON RmRes.RoomID = Rm.RoomID
ORDER BY Res.ReservationID, Rm.RoomID;

    

#LEFT OUTER JOIN
SELECT
    Res.ReservationID,
    Res.GuestID,
    G.FirstName,
    G.LastName,
    Res.HotelID,
    Rm.RoomID,
    Rm.RoomType,
    Rm.Tariff,
    Res.CheckInDate,
    Res.CheckOutDate,
    Res.NumberOfGuests
FROM
    HotelManagement.Reservations AS Res
LEFT OUTER JOIN HotelManagement.Guests AS G ON Res.GuestID = G.GuestID
LEFT OUTER JOIN HotelManagement.Room_Reservations AS RmRes ON Res.ReservationID = RmRes.ReservationID
LEFT OUTER JOIN HotelManagement.Rooms AS Rm ON RmRes.RoomID = Rm.RoomID
ORDER BY Res.ReservationID;


#SubQuery
SELECT
    Res.ReservationID,
    Res.GuestID,
    Res.HotelID,
    Res.CheckInDate,
    Res.CheckOutDate,
    Res.NumberOfGuests
FROM
    HotelManagement.Reservations AS Res
WHERE
    Res.NumberOfGuests = (
        SELECT MAX(NumberOfGuests)
        FROM HotelManagement.Reservations
    )
ORDER BY Res.ReservationID;


#Mutli-Row Subquery
SELECT
    Res.ReservationID,
    Res.GuestID,
    Res.HotelID,
    Res.CheckInDate,
    Res.CheckOutDate,
    Res.NumberOfGuests
FROM
    HotelManagement.Reservations AS Res
WHERE
    Res.GuestID IN (
        SELECT GuestID
        FROM HotelManagement.Guests
        WHERE Address LIKE '%Maple%'
    )
ORDER BY Res.ReservationID;


#Aggregating results
USE HotelManagement;

SELECT
    Res.HotelID,
    H.HotelName,
    COUNT(Res.ReservationID) AS TotalReservations,
    SUM(Res.NumberOfGuests) AS TotalGuests,
    AVG(Res.NumberOfGuests) AS AverageGuestsPerReservation
FROM
    HotelManagement.Reservations AS Res
INNER JOIN HotelManagement.Hotels AS H ON Res.HotelID = H.HotelID
GROUP BY
    Res.HotelID,
    H.HotelName
ORDER BY
    Res.HotelID;


#NOT in Subquery
SELECT
    GuestID,
    FirstName,
    LastName,
    Contact,
    Address
FROM
    HotelManagement.Guests
WHERE
    GuestID NOT IN (
        SELECT DISTINCT GuestID
        FROM HotelManagement.Reservations
    )
ORDER BY
    GuestID;


#CASE Statement
SELECT
    G.GuestID,
    G.FirstName,
    G.LastName,
    G.Contact,
    G.Address,
    COUNT(Res.ReservationID) AS TotalReservations,
    CASE
        WHEN COUNT(Res.ReservationID) = 0 THEN 'No Reservations'
        WHEN COUNT(Res.ReservationID) = 1 THEN 'New Guest'
        WHEN COUNT(Res.ReservationID) BETWEEN 2 AND 4 THEN 'Returning Guest'
        ELSE 'Frequent Guest'
    END AS GuestCategory
FROM
    HotelManagement.Guests AS G
LEFT JOIN HotelManagement.Reservations AS Res ON G.GuestID = Res.GuestID
GROUP BY
    G.GuestID,G.FirstName,G.LastName,G.Contact,G.Address
ORDER BY
    G.GuestID;



#NOT EXISTS
USE HotelManagement;

SELECT
    G.GuestID,
    G.FirstName,
    G.LastName,
    G.Contact,
    G.Address
FROM
    HotelManagement.Guests AS G
WHERE
    NOT EXISTS (
        SELECT 1
        FROM HotelManagement.Reservations AS Res
        WHERE Res.GuestID = G.GuestID
    )
ORDER BY
    G.GuestID;


#NOT NULL Subquery
SELECT
    Res.ReservationID,
    Res.GuestID,
    Res.HotelID,
    Res.CheckInDate,
    Res.CheckOutDate,
    Res.NumberOfGuests
FROM
    HotelManagement.Reservations AS Res
WHERE
    Res.ReservationID IN (
        SELECT DISTINCT RmRes.ReservationID
        FROM HotelManagement.Room_Reservations AS RmRes
        JOIN HotelManagement.Rooms AS Rm ON RmRes.RoomID = Rm.RoomID
        WHERE Rm.Tariff IS NOT NULL
    )
ORDER BY
    Res.ReservationID;


