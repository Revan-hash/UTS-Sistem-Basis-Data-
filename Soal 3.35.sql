CREATE TABLE AIRPORT (
    Airport_code VARCHAR(10) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    CONSTRAINT pk_airport PRIMARY KEY (Airport_code)
);

CREATE TABLE FLIGHT (
    Flight_number VARCHAR(10) NOT NULL,
    Airline VARCHAR(50) NOT NULL,
    Weekdays VARCHAR(50),
    CONSTRAINT pk_flight PRIMARY KEY (Flight_number)
);

CREATE TABLE FLIGHT_LEG (
    Flight_number VARCHAR(10) NOT NULL,
    Leg_number INT NOT NULL,
    Departure_airport_code VARCHAR(10) NOT NULL,
    Arrival_airport_code VARCHAR(10) NOT NULL,
    Scheduled_dep_time TIME,
    Scheduled_arr_time TIME,
    CONSTRAINT pk_flight_leg PRIMARY KEY (Flight_number, Leg_number),
    CONSTRAINT fk_leg_flight FOREIGN KEY (Flight_number) REFERENCES FLIGHT(Flight_number),
    CONSTRAINT fk_leg_dep_airport FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
    CONSTRAINT fk_leg_arr_airport FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code)
);

CREATE TABLE AIRPLANE_TYPE (
    TypeName VARCHAR(50) NOT NULL,
    Company VARCHAR(50) NOT NULL,
    Max_seats INT NOT NULL,
    CONSTRAINT pk_airplane_type PRIMARY KEY (TypeName)
);

CREATE TABLE AIRPLANE (
    Airplane_id INT NOT NULL,
    Total_seats INT NOT NULL,
    TypeName VARCHAR(50) NOT NULL,
    CONSTRAINT pk_airplane PRIMARY KEY (Airplane_id),
    CONSTRAINT fk_airplane_type FOREIGN KEY (TypeName) REFERENCES AIRPLANE_TYPE(TypeName)
);

CREATE TABLE LEG_INSTANCE (
    Flight_number VARCHAR(10) NOT NULL,
    Leg_number INT NOT NULL,
    Leg_date DATE NOT NULL,
    Airplane_id INT NOT NULL,
    Dep_time TIME,
    Arr_time TIME,
    CONSTRAINT pk_leg_instance PRIMARY KEY (Flight_number, Leg_number, Leg_date),
    CONSTRAINT fk_li_flight_leg FOREIGN KEY (Flight_number, Leg_number) REFERENCES FLIGHT_LEG(Flight_number, Leg_number),
    CONSTRAINT fk_li_airplane FOREIGN KEY (Airplane_id) REFERENCES AIRPLANE(Airplane_id)
);

CREATE TABLE SEAT_RESERVATION (
    Flight_number VARCHAR(10) NOT NULL,
    Leg_number INT NOT NULL,
    Leg_date DATE NOT NULL,
    Seat_number VARCHAR(10) NOT NULL,
    Customer_name VARCHAR(100) NOT NULL,
    Customer_phone VARCHAR(20),
    CONSTRAINT pk_seat_res PRIMARY KEY (Flight_number, Leg_number, Leg_date, Seat_number),
    CONSTRAINT fk_sr_leg_instance FOREIGN KEY (Flight_number, Leg_number, Leg_date) REFERENCES LEG_INSTANCE(Flight_number, Leg_number, Leg_date)
);