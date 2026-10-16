CREATE TABLE AUTHOR (
    Email VARCHAR(100) NOT NULL,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_author PRIMARY KEY (Email)
);

CREATE TABLE PAPER (
    Paper_id INT NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Abstract TEXT,
    File_name VARCHAR(100) NOT NULL,
    Contact_author_email VARCHAR(100) NOT NULL,
    CONSTRAINT pk_paper PRIMARY KEY (Paper_id),
    CONSTRAINT fk_paper_contact_author FOREIGN KEY (Contact_author_email) REFERENCES AUTHOR(Email)
);

CREATE TABLE PAPER_AUTHOR (
    Paper_id INT NOT NULL,
    Author_email VARCHAR(100) NOT NULL,
    CONSTRAINT pk_paper_author PRIMARY KEY (Paper_id, Author_email),
    CONSTRAINT fk_pa_paper FOREIGN KEY (Paper_id) REFERENCES PAPER(Paper_id),
    CONSTRAINT fk_pa_author FOREIGN KEY (Author_email) REFERENCES AUTHOR(Email)
);

CREATE TABLE REVIEWER (
    Email VARCHAR(100) NOT NULL,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Phone_number VARCHAR(20),
    Affiliation VARCHAR(100),
    CONSTRAINT pk_reviewer PRIMARY KEY (Email)
);

CREATE TABLE REVIEWER_TOPIC (
    Reviewer_email VARCHAR(100) NOT NULL,
    Topic VARCHAR(100) NOT NULL,
    CONSTRAINT pk_reviewer_topic PRIMARY KEY (Reviewer_email, Topic),
    CONSTRAINT fk_rt_reviewer FOREIGN KEY (Reviewer_email) REFERENCES REVIEWER(Email)
);

CREATE TABLE REVIEW (
    Review_id INT NOT NULL,
    Paper_id INT NOT NULL,
    Reviewer_email VARCHAR(100) NOT NULL,
    Technical_merit INT CHECK (Technical_merit BETWEEN 1 AND 10),
    Readability INT CHECK (Readability BETWEEN 1 AND 10),
    Originality INT CHECK (Originality BETWEEN 1 AND 10),
    Relevance INT CHECK (Relevance BETWEEN 1 AND 10),
    Overall_recommendation VARCHAR(50),
    Committee_comment TEXT,
    Author_feedback TEXT,
    CONSTRAINT pk_review PRIMARY KEY (Review_id),
    CONSTRAINT fk_rev_paper FOREIGN KEY (Paper_id) REFERENCES PAPER(Paper_id),
    CONSTRAINT fk_rev_reviewer FOREIGN KEY (Reviewer_email) REFERENCES REVIEWER(Email)
);