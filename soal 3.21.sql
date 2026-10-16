CREATE TABLE STATE (
    State_name VARCHAR(50) NOT NULL,
    Region VARCHAR(20) NOT NULL,
    CONSTRAINT pk_state PRIMARY KEY (State_name),
    CONSTRAINT chk_region CHECK (Region IN ('Northeast', 'Midwest', 'Southeast', 'Southwest', 'West'))
);

CREATE TABLE CONGRESS_PERSON (
    Congress_id INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    District VARCHAR(50) NOT NULL,
    Start_date DATE NOT NULL,
    Party VARCHAR(20) NOT NULL,
    State_name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_congress_person PRIMARY KEY (Congress_id),
    CONSTRAINT fk_cp_state FOREIGN KEY (State_name) REFERENCES STATE(State_name),
    CONSTRAINT chk_party CHECK (Party IN ('Republican', 'Democrat', 'Independent', 'Other'))
);

CREATE TABLE BILL (
    Bill_id INT NOT NULL,
    Bill_name VARCHAR(200) NOT NULL,
    Date_of_vote DATE NOT NULL,
    Passed_or_failed VARCHAR(5) NOT NULL,
    Sponsor_id INT NOT NULL,
    CONSTRAINT pk_bill PRIMARY KEY (Bill_id),
    CONSTRAINT fk_bill_sponsor FOREIGN KEY (Sponsor_id) REFERENCES CONGRESS_PERSON(Congress_id),
    CONSTRAINT chk_passed CHECK (Passed_or_failed IN ('Yes', 'No'))
);

CREATE TABLE VOTE (
    Congress_id INT NOT NULL,
    Bill_id INT NOT NULL,
    Vote VARCHAR(10) NOT NULL,
    CONSTRAINT pk_vote PRIMARY KEY (Congress_id, Bill_id),
    CONSTRAINT fk_vote_cp FOREIGN KEY (Congress_id) REFERENCES CONGRESS_PERSON(Congress_id),
    CONSTRAINT fk_vote_bill FOREIGN KEY (Bill_id) REFERENCES BILL(Bill_id),
    CONSTRAINT chk_vote_val CHECK (Vote IN ('Yes', 'No', 'Abstain', 'Absent'))
);