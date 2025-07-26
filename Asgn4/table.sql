CREATE TABLE accounts_db_admin (
    Username varchar(255) primary key,
    Password varchar(512) not null
);

CREATE TABLE  accounts_physician (
   Email_ID varchar(255) primary key,
    Employee_ID int UNIQUE not null,
    First_Name varchar(255) not null,
    Last_Name varchar(255) not null,
    Department varchar(255) not null,
    Position varchar(255) not null,
    Password varchar(512) not null
);

CREATE TABLE  accounts_front_desk (
   Email_ID varchar(255) primary key,
     First_Name varchar(255) not null,
    Last_Name varchar(255) not null,
    Employee_ID int UNIQUE not null,
    Password varchar(512) not null
);

CREATE TABLE  accounts_data_entry (
   Email_ID varchar(255) primary key,
     First_Name varchar(255) not null,
    Last_Name varchar(255) not null,
    Employee_ID int UNIQUE not null,
    Password varchar(512) not null
);


CREATE TABLE accounts_patient (
   Email_ID varchar(255) primary key,
    SSN int UNIQUE not null,
     First_Name varchar(255) not null,
    Last_Name varchar(255) not null,
    Address varchar(255) not null,
    Insurance_ID int,
    Phone varchar(15) not null,
    Age int not null,
    Blood_Group varchar(8),
    Gender varchar(255) not null,
    Status int not null
);

CREATE TABLE accounts_tests (
    Test_ID int AUTO_INCREMENT primary key,
    Test_Name varchar(255) not null,
    Cost int not null  
);


CREATE TABLE accounts_treatment (
    Treatment_ID int AUTO_INCREMENT primary key,
    Treatment_Name varchar(255) not null,
    Cost int not null
);

CREATE TABLE accounts_undergoes (
    Undergoes_ID int AUTO_INCREMENT primary key,
    Patient_Email varchar(255) not null,
    Treatment_ID int not null,
    Physician_Email varchar(255) not null,
    Date DATETIME not null,
    Remarks text
);


CREATE TABLE accounts_room (
    Room_ID int AUTO_INCREMENT PRIMARY KEY,
    Type varchar(255) not null,
    Room_Name varchar(255) not null,
    Capacity int not null,
    Cost int not null
);

CREATE TABLE accounts_admission (
    Admission_ID int not null AUTO_INCREMENT PRIMARY KEY,
    Patient_Email varchar(255) not null,
    Room_ID int not null,
    Start DATETIME not null,
    End DATETIME not null,
    PCP_Email varchar(255) not null,
    Total_Cost int
);

CREATE TABLE accounts_prescribes (
    Prescribe_ID int AUTO_INCREMENT PRIMARY KEY,
    Physician_Email varchar(255) not null,
    Patient_Email varchar(255) not null,
    Date DATETIME not null,
    Prescription text not null
);

CREATE TABLE accounts_appointment (
    Appointment_ID int not null AUTO_INCREMENT PRIMARY KEY,
    Patient_Email varchar(255) not null,
    Physician_Email varchar(255) not null,
    Start DATETIME not null,
    Appointment_Fee int,
    is_scheduled int not null
);

CREATE TABLE accounts_health_record (
    Record_ID int not null AUTO_INCREMENT PRIMARY KEY,
    Admission_ID int not null,
    Date DATETIME not null,
    Vitals text,
    Remarks text
);

CREATE TABLE accounts_tested (
    Tested_ID int primary key not null AUTO_INCREMENT,
    Patient_Email varchar(255) not null,
    Test_ID int not null,
    Date DATETIME not null,
    Test_Result text,
    Test_Image mediumblob
);



-- foreign key setting
ALTER TABLE accounts_admission 
ADD FOREIGN KEY (Patient_Email) REFERENCES accounts_patient(Email_ID);


ALTER TABLE accounts_admission 
ADD FOREIGN KEY (PCP_Email) REFERENCES accounts_physician(Email_ID);

ALTER TABLE accounts_admission 
ADD FOREIGN KEY (Room_ID) REFERENCES accounts_room(Room_ID);


ALTER TABLE accounts_prescribes 
ADD FOREIGN KEY (Patient_Email) REFERENCES accounts_patient(Email_ID);


ALTER TABLE accounts_prescribes 
ADD FOREIGN KEY (Physician_Email) REFERENCES accounts_physician(Email_ID);


ALTER TABLE accounts_appointment 
ADD FOREIGN KEY (Patient_Email) REFERENCES accounts_patient(Email_ID);


ALTER TABLE accounts_appointment 
ADD FOREIGN KEY (Physician_Email) REFERENCES accounts_physician(Email_ID);


ALTER TABLE accounts_tested 
ADD FOREIGN KEY (Patient_Email) REFERENCES accounts_patient(Email_ID);

ALTER TABLE accounts_tested 
ADD FOREIGN KEY (Test_ID) REFERENCES accounts_tests(Test_ID);

ALTER TABLE accounts_undergoes 
ADD FOREIGN KEY (Treatment_ID) REFERENCES accounts_treatment(Treatment_ID);

ALTER TABLE accounts_undergoes 
ADD FOREIGN KEY (Patient_Email) REFERENCES accounts_patient(Email_ID);

ALTER TABLE accounts_undergoes 
ADD FOREIGN KEY (Physician_Email) REFERENCES accounts_physician(Email_ID);

ALTER TABLE accounts_health_record 
ADD FOREIGN KEY (Admission_ID) REFERENCES accounts_admission(Admission_ID);





DROP TABLE accounts_tested;
DROP TABLE accounts_health_record;
DROP TABLE accounts_admission;
DROP TABLE accounts_prescribes;
DROP TABLE accounts_appointment;
DROP TABLE accounts_front_desk;
DROP TABLE accounts_data_entry;
DROP TABLE accounts_room;
DROP TABLE accounts_undergoes;
DROP TABLE accounts_patient;
DROP TABLE accounts_physician;
DROP TABLE accounts_tests;
DROP TABLE accounts_treatment;
DROP TABLE accounts_db_admin;


