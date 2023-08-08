-- Creating the AirportDestination table
CREATE TABLE AirportDestination (
    DestinationID serial PRIMARY KEY,
    Destination VARCHAR(255) NOT NULL
);

-- CarRental
CREATE TABLE Vehicle (
    vehicle_id serial PRIMARY KEY,
    make VARCHAR(255),
    model VARCHAR(255),
    vehicle_type VARCHAR(255),
    vehicle_year INT
);

CREATE TABLE Fuel (
    fuel_id serial PRIMARY KEY,
    fuel_type VARCHAR(255)
);

CREATE TABLE Location_Car (
    location_id serial PRIMARY KEY,
    city VARCHAR(255),
    country VARCHAR(255),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    state CHAR(2)
);

CREATE TABLE Booking (
    BookingID SERIAL PRIMARY KEY,
    CustomerID INT,
    BookingDate TIMESTAMP,
    TotalCost DECIMAL(7,2)
);

CREATE TABLE CarRental (
    rental_id serial PRIMARY KEY,
    renterTripsTaken DECIMAL(5,1),
    reviewCount INT,
    rate_daily DECIMAL(7,2),
    rating DECIMAL(3,2),
    vehicle_id INT,
    location_id INT,
    fuel_id INT,
    Airport_cityID INT,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id),
    FOREIGN KEY (location_id) REFERENCES Location_Car(location_id),
    FOREIGN KEY (fuel_id) REFERENCES Fuel(fuel_id),
    FOREIGN KEY (Airport_cityID) REFERENCES AirportDestination(DestinationID)
);

CREATE TABLE CarRentalBooking (
    BookingID INT,
    rental_id INT,
    PRIMARY KEY (BookingID, rental_id),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (rental_id) REFERENCES CarRental(rental_id)
);


-- Flights
-- Creating the Airline table
CREATE TABLE Airline (
    AirlineID serial PRIMARY KEY,
    AirlineName VARCHAR(255) NOT NULL Unique
);


-- Creating the Route table
CREATE TABLE Route (
    RouteID serial PRIMARY KEY,
    destinationID INT,
    Dep_Time TIME,
    Arrival_Time TIME,
    Duration VARCHAR(255),
    FOREIGN KEY (destinationID) REFERENCES AirportDestination(DestinationID)
);

-- Creating the FlightBooking table
CREATE TABLE FlightBooking (
    BookingID serial PRIMARY KEY,
    AirlineID INT,
    RouteID INT,
    Date_of_Journey DATE,
    Price DECIMAL(10,2),
    FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);


-- Hotels
CREATE TABLE hotels (
  hotelcode serial PRIMARY KEY,
  hotelname VARCHAR(100) NOT NULL,
  cityID INT NOT NULL,
  propertytype VARCHAR(100) NOT NULL,
  starrating INT NOT NULL,
  url TEXT NOT NULL,
  FOREIGN KEY (cityID) REFERENCES AirportDestination(DestinationID)
);

CREATE TABLE hotel_room_amenities (
  id SERIAL PRIMARY KEY,
  hotelcode INT NOT NULL,
  roomamenities TEXT NOT NULL,
  FOREIGN KEY (hotelcode) REFERENCES hotels (hotelcode)
);

CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  hotelcode INT NOT NULL,
  hotel_room_amenities_id INT NOT NULL,
  roomtype VARCHAR(255) NOT NULL,
  ratedescription TEXT,
  FOREIGN KEY (hotelcode) REFERENCES hotels (hotelcode),
  FOREIGN KEY (hotel_room_amenities_id) REFERENCES hotel_room_amenities (id)
);

CREATE TABLE hotelprices (
  hotelcode INT PRIMARY KEY,
  min INT NOT NULL,
  max INT NOT NULL,
  SCORE INT NOT NULL,
  FOREIGN KEY (hotelcode) REFERENCES hotels (hotelcode)
);

CREATE TABLE reviews (
  id INT PRIMARY KEY,
  hotelcode INT NOT NULL,
  dtcollected DATE NOT NULL,
  ratedate DATE NOT NULL,
  guests INT NOT NULL,
  onsiterate INT NOT NULL,
  ratedescription TEXT,
  ratetype TEXT,
  FOREIGN KEY (hotelcode) REFERENCES hotels (hotelcode)
);

ALTER TABLE AirportDestination ADD CONSTRAINT unique_destination UNIQUE (Destination);
ALTER TABLE Route ADD CONSTRAINT unique_route UNIQUE(destinationID, Dep_Time, Arrival_Time, Duration);
ALTER TABLE Vehicle ADD CONSTRAINT unique_vehicle UNIQUE(make, model, vehicle_type, vehicle_year);
ALTER TABLE Location_Car ADD CONSTRAINT unique_location UNIQUE(city, country, state);
ALTER TABLE Fuel ADD CONSTRAINT unique_fuel_type UNIQUE(fuel_type);
