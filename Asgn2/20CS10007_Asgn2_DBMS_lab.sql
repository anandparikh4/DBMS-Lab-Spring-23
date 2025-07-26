CREATE TABLE _affiliated_with(
    _physician INT NOT NULL,
    _department INT NOT NULL,
    _primary_affiliation BOOLEAN NOT NULL,
    PRIMARY KEY (_physician , _department)
);

CREATE TABLE _trained_in(
    _physician INT NOT NULL,
    _treatment INT NOT NULL,
    _certification_date DATETIME NOT NULL,
    _certification_expires DATETIME NOT NULL,
    PRIMARY KEY (_physician , _treatment)
);

CREATE TABLE _procedure(
    _code INT NOT NULL,
    _name VARCHAR(255) NOT NULL,
    _cost INT NOT NULL,
    PRIMARY KEY (_code)
);

CREATE TABLE _undergoes(
    _patient INT NOT NULL,
    _procedure INT NOT NULL,
    _stay INT NOT NULL,
    _date DATETIME NOT NULL,
    _physician INTEGER NOT NULL,
    _assisting_nurse INTEGER,        -- nullable
    PRIMARY KEY (_patient , _procedure , _stay , _date)
);

CREATE TABLE _department(
    _department_id INT NOT NULL,
    _name VARCHAR(255) NOT NULL,
    _head INT NOT NULL,
    PRIMARY KEY (_department_id)
);

CREATE TABLE _physician(
    _employee_id INT NOT NULL,
    _name VARCHAR(255) NOT NULL,
    _position VARCHAR(255) NOT NULL,
    _ssn INT NOT NULL,
    PRIMARY KEY (_employee_id)
);

CREATE TABLE _patient(
    _ssn INT NOT NULL,
    _name VARCHAR(255) NOT NULL,
    _address VARCHAR(1023) NOT NULL,
    _phone VARCHAR(255) NOT NULL,
    _insurance_id INT NOT NULL,
    _pcp int NOT NULL,
    PRIMARY KEY (_ssn)
);

CREATE TABLE _prescribes(
    _physician INT NOT NULL,
    _patient INT NOT NULL,
    _medication INT NOT NULL,
    _date DATETIME NOT NULL,
    _appointment INT,           -- nullable
    _dose VARCHAR(255) NOT NULL,
    PRIMARY KEY (_physician , _patient , _medication , _date)
);

CREATE TABLE _room(
    _number INT NOT NULL,
    _type VARCHAR(255) NOT NULL,
    _block_floor INT NOT NULL,
    _block_code INT NOT NULL,
    _unavailable BOOLEAN NOT NULL,
    PRIMARY KEY (_number)
);

CREATE TABLE _stay(
    _stay_id INT NOT NULL,
    _patient INT NOT NULL,
    _room INT NOT NULL,
    _start DATETIME NOT NULL,
    _end DATETIME NOT NULL,
    PRIMARY KEY (_stay_id)
);

CREATE TABLE _appointment(
    _appointment_id INT NOT NULL,
    _patient INT NOT NULL,
    _prep_nurse INT,            -- nullable
    _physician INT NOT NULL,
    _start DATETIME NOT NULL,
    _end DATETIME NOT NULL,
    _examination_room VARCHAR(255) NOT NULL,
    PRIMARY KEY (_appointment_id)
);

CREATE TABLE _medication(
    _code INT NOT NULL,
    _name VARCHAR(255) NOT NULL,
    _brand VARCHAR(255) NOT NULL,
    _description VARCHAR(1023) NOT NULL,
    PRIMARY KEY (_code)
);

CREATE TABLE _block(
    _floor INT NOT NULL,
    _code INT NOT NULL,
    PRIMARY KEY (_floor , _code)
);

CREATE TABLE _on_call(
    _nurse INT NOT NULL,
    _block_floor INT NOT NULL,
    _block_code INT NOT NULL,
    _start DATETIME NOT NULL,
    _end DATETIME NOT NULL,
    PRIMARY KEY (_nurse , _block_floor , _block_code , _start , _end)
);

CREATE TABLE _nurse(
    _employee_id INT NOT NULL,
    _name VARCHAR(255) NOT NULL,
    _position VARCHAR(255) NOT NULL,
    _registered BOOLEAN NOT NULL,
    _ssn INTEGER NOT NULL,
    PRIMARY KEY (_employee_id)
);


ALTER TABLE _affiliated_with
ADD FOREIGN KEY (_physician) REFERENCES _physician(_employee_id),
ADD FOREIGN KEY (_department) REFERENCES _department(_department_id);


ALTER TABLE _trained_in
ADD FOREIGN KEY (_physician) REFERENCES _physician(_employee_id),
ADD FOREIGN KEY (_treatment) REFERENCES _procedure(_code);


ALTER TABLE _undergoes
ADD FOREIGN KEY (_patient) REFERENCES _patient(_ssn),
ADD FOREIGN KEY (_procedure) REFERENCES _procedure(_code),
ADD FOREIGN KEY (_stay) REFERENCES _stay(_stay_id),
ADD FOREIGN KEY (_physician) REFERENCES _physician(_employee_id),
ADD FOREIGN KEY (_assisting_nurse) REFERENCES _nurse(_employee_id);


ALTER TABLE _department
ADD FOREIGN KEY (_head) REFERENCES _physician(_employee_id);


ALTER TABLE _patient
ADD FOREIGN KEY (_pcp) REFERENCES _physician(_employee_id);


ALTER TABLE _prescribes
ADD FOREIGN KEY (_physician) REFERENCES _physician(_employee_id),
ADD FOREIGN KEY (_patient) REFERENCES _patient(_ssn),
ADD FOREIGN KEY (_medication) REFERENCES _medication(_code),
ADD FOREIGN KEY (_appointment) REFERENCES _appointment(_appointment_id);


ALTER TABLE _room
ADD FOREIGN KEY (_block_floor , _block_code) REFERENCES _block(_floor , _code);


ALTER TABLE _stay
ADD FOREIGN KEY (_patient) REFERENCES _patient(_ssn),
ADD FOREIGN KEY (_room) REFERENCES _room(_number);


ALTER TABLE _appointment
ADD FOREIGN KEY (_patient) REFERENCES _patient(_ssn),
ADD FOREIGN KEY (_prep_nurse) REFERENCES _nurse(_employee_id),
ADD FOREIGN KEY (_physician) REFERENCES _physician(_employee_id);


ALTER TABLE _on_call
ADD FOREIGN KEY (_nurse) REFERENCES _nurse(_employee_id),
ADD FOREIGN KEY (_block_floor , _block_code) REFERENCES _block(_floor , _code);

SHOW TABLES;

INSERT INTO _physician(_employee_id , _name , _position , _ssn)
VALUES
    (100 , "Manish Das" , "Surgeon" , 5005),
    (101 , "Richa Patel" , "Surgeon" , 5004),
    (102 , "Mohan Kumar" , "Director" , 5007),
    (103 , "Nidhi Dalal" , "General" , 5032),
    (104 , "Venkatesh Kishore" , "Surgeon" , 5051);

SELECT * FROM _physician;


INSERT INTO _patient(_ssn , _name , _address , _phone , _insurance_id , _pcp)
VALUES 
    (5001 , "Anand Parikh" , "5 Piplod, Surat, GJ" , 121212 , 1234 , 100),
    (5052 , "Manoj Parikh" , "5 Piplod, Surat, GJ" , 676767 , 4567 , 101),
    (5003 , "Mita Parikh" , "5 Piplod, Surat, GJ" , 343434 , 6789 , 104),
    (5025 , "Meena Kinariwala" , "7 Piplod, Surat, GJ" , 565656 , 3456 , 101),
    (5002 , "Kaushik Dalal" , "7 Piplod, Surat, GJ" , 898989 , 7890 , 103),
    (5034 , "Aditya Soni" , "6A MG Road, Ahmedabad, GJ" , 454545 , 5678 , 104),
    (5006 , "Divyat Gaikwad" , "8 Borivali , Mumbai, MH" , 232323 , 2345 , 103),
    (5066 , "Rahul Mandal" , "2C Govind Pura , Bhopal, MP" , 111100 , 1102 , 101),
    (5068, "Saransh Sharma" , "C 118 LBS Hall, Kharagpur, WB" , 222225 , 2216 , 100);

SELECT * FROM _patient;


INSERT INTO _department(_department_id , _name , _head)
VALUES
    (601 , "cardiology" , 100),
    (602 , "opthalmology" , 103),
    (603 , "orthopedic" , 102);

SELECT * FROM _department;


INSERT INTO _affiliated_with(_physician , _department , _primary_affiliation)
VALUES
    (100 , 601 , 1),
    (101 , 601 , 1),
    (102 , 602 , 1),
    (103 , 603 , 1),
    (104 , 603 , 1),
    (100 , 602 , 0);

SELECT * FROM _affiliated_with;


INSERT INTO _procedure(_code , _name , _cost)
VALUES
    (43 , "bypass surgery" , 10000),
    (67 , "lasik" , 3000),
    (28 , "knee replace" , 6500);

SELECT * FROM _procedure;


INSERT INTO _trained_in(_physician , _treatment , _certification_date , _certification_expires)
VALUES
    (100 , 43 , '2008-03-12' , '2028-03-12'),
    (101 , 43 , '2009-04-13' , '2019-05-16'),
    (103 , 43 , '2003-10-06' , '2018-01-23'),
    (103 , 67 , '2005-11-07' , '2020-10-10'),
    (104 , 67 , '2008-03-12' , '2021-08-08'),
    (102 , 28 , '2001-05-22' , '2026-12-05');

SELECT * FROM _trained_in;


INSERT INTO _nurse(_employee_id , _name , _position , _registered , _ssn)
VALUES
    (201 , "Rupa Shah" , "permanent" , 1 , 5091),
    (202 , "Pratham Shah" , "permanent" , 1 , 5092),
    (203 , "Manan Raj" , "emergency" , 0 , 5093),
    (204 , "Mansi Gupta" , "intern" , 1 , 5094);

SELECT * FROM _nurse;


INSERT INTO _block(_floor , _code)
VALUES
    (1,10),
    (1,11),
    (2,10);

SELECT * FROM _block;


INSERT INTO _room(_number , _type , _block_floor , _block_code , _unavailable)
VALUES
    (120 , "icu" , 1 , 11 , 0),
    (121 , "general" , 1 , 11 , 1),
    (122 , "special" , 2 , 10 , 1),
    (123 , "icu" , 1 , 10 , 0);

SELECT * FROM _room;


INSERT INTO _stay(_stay_id , _patient , _room , _start , _end)
VALUES
    (301 , 5001 , 123 , '2023-01-06' , '2023-01-27'),
    (302 , 5066 , 123 , '2023-01-05' , '2023-01-21'),
    (303 , 5068 , 121 , '2008-06-09' , '2008-06-16'),
    (304 , 5034 , 122 , '2020-03-12' , '2020-03-17'),
    (305 , 5006 , 122 , '2020-12-09' , '2020-12-10');

SELECT * FROM _stay;


INSERT INTO _medication(_code , _name , _brand , _description)
VALUES
    (900 , "remdesivir" , "Mankind" , "popular for covid treatment"),
    (901 , "aspirin" , "Apollo" , "general purpose, headache"),
    (902 , "diominic-dca" , "Johnson and Johnson" , "cough, running nose, sore throat"),
    (903 , "calpol" , "Mankind" , "fever, paracetemol");

SELECT * FROM _medication;


INSERT INTO _appointment(_appointment_id , _patient , _prep_nurse , _physician , _start , _end , _examination_room)
VALUES
    (801 , 5003 , 204 , 104 , '2020-03-02' , '2020-04-03' , "general"),
    (802 , 5066 , 202 , 101 , '2020-04-03' , '2020-05-04' , "special"),
    (803 , 5025 , NULL , 102 , '2022-07-06' , '2022-07-09' , "special"),
    (804 , 5066 , 202 , 100 , '2019-12-13' , '2019-12-16' , "special");

SELECT * FROM _appointment;


INSERT INTO _prescribes(_physician , _patient , _medication , _date , _appointment , _dose)
VALUES
    (100, 5034 , 902 , '2020-02-01' , NULL , "light"),
    (104 , 5003 , 900 , '2020-03-02' , 801 , "light"),
    (101 , 5066 , 900 , '2020-04-03' , 802 , "heavy"),
    (100 , 5052 , 902 , '2020-05-04' , NULL , "light"),
    (102 , 5001 , 902 , '2021-06-05' , NULL , "light"),
    (102 , 5025 , 903 , '2022-07-06' , 803 , "medium");

SELECT * FROM _prescribes;


INSERT INTO _on_call(_nurse , _block_floor , _block_code , _start , _end)
VALUES
    (201 , 1 , 10 , '2023-01-06' , '2023-01-08'),
    (202 , 1 , 10 , '2023-01-08' , '2023-01-11'),
    (201 , 1 , 11 , '2008-06-09' , '2008-06-14'),
    (203 , 2 , 10 , '2020-03-12' , '2020-03-16'),
    (204 , 2 , 10 , '2020-12-09' , '2020-12-09');

SELECT * FROM _on_call;


INSERT INTO _undergoes
VALUES
    (5034 , 43 , 304 , '2020-03-12' , 100 , 201),
    (5006 , 67 , 305 , '2020-12-09' , 103 , NULL),
    (5068 , 28 , 303 , '2008-06-09' , 102 , 203),
    (5066 , 43 , 302 , '2023-01-05' , 101 , 201),
    (5001 , 43 , 301 , '2023-01-06' , 104 , 202);

SELECT * FROM _undergoes;

SELECT
    _physician._name as _name
FROM _physician
    INNER JOIN _trained_in ON _physician._employee_id = _trained_in._physician
    INNER JOIN _procedure ON _trained_in._treatment = _procedure._code
WHERE _procedure._name = "bypass surgery";

SELECT
    _physician._name as _name
FROM _physician
    INNER JOIN _affiliated_with ON _physician._employee_id = _affiliated_with._physician
    INNER JOIN _department ON _department._department_id = _affiliated_with._department
    INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id
    INNER JOIN _procedure ON _procedure._code = _trained_in._treatment
WHERE _procedure._name = "bypass surgery" AND _department._name = "cardiology";

SELECT
    _name
FROM _nurse
    INNER JOIN _on_call ON _on_call._nurse = _nurse._employee_id
    INNER JOIN _block ON _block._floor = _on_call._block_floor AND _block._code = _on_call._block_code
    INNER JOIN _room ON _room._block_floor = _block._floor AND _room._block_code = _block._code
WHERE
    _room._number = 123;

SELECT
    _patient._name as _name,
    _address
FROM _patient
    INNER JOIN _prescribes ON _patient._ssn = _prescribes._patient
    INNER JOIN _medication ON _medication._code = _prescribes._medication
WHERE _medication._name = "remdesivir";

SELECT
    _name,
    _insurance_id
FROM _patient
    INNER JOIN _stay ON _stay._patient = _patient._ssn
    INNER JOIN _room ON _room._number = _stay._room
WHERE _room._type = "icu" AND DATEDIFF(_stay._end , _stay._start) > 15;

SELECT
    _nurse._name as _nurse_name
FROM _nurse
    INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id
    INNER JOIN _procedure ON _procedure._code = _undergoes._procedure
WHERE
    _procedure._name = "bypass surgery";

SELECT
    _nurse._name as _nurse_name,
    _nurse._position as _nurse_position,
    _physician._name as _physician_name
FROM _nurse
    INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id
    INNER JOIN _procedure ON _undergoes._procedure = _procedure._code
    INNER JOIN _physician ON _physician._employee_id = _undergoes._physician
WHERE _procedure._name = "bypass surgery";

SELECT
    P._name
FROM _physician as P
    INNER JOIN _undergoes as U ON U._physician = P._employee_id
WHERE NOT EXISTS (
    SELECT *
    FROM _trained_in
    WHERE _trained_in._physician = P._employee_id AND _trained_in._treatment = U._procedure
);

SELECT
    _name
FROM _physician
    INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id
    INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure
WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;

SELECT
    _physician._name as _physician_name,
    _procedure._name as _procedure_name,
    _undergoes._date as _date,
    _patient._name as _patient_name
FROM _physician
    INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id
    INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure
    INNER JOIN _patient ON _patient._ssn = _undergoes._patient
    INNER JOIN _procedure ON _procedure._code = _undergoes._procedure
WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;

SELECT
    S._name as _patient_name,
    T._name as _physician_name
FROM _patient as S
    INNER JOIN _physician as T ON S._pcp = T._employee_id
WHERE
    EXISTS (
        SELECT *
        FROM _prescribes
        WHERE _prescribes._physician = T._employee_id AND _prescribes._patient = S._ssn
    ) AND
    EXISTS (
        SELECT *
        FROM _procedure
        INNER JOIN _undergoes ON _undergoes._procedure = _procedure._code
        WHERE _cost > 5000 AND _patient = S._ssn
    ) AND
    2<=(SELECT COUNT(*)
        FROM _physician
            INNER JOIN _appointment ON _appointment._physician = _physician._employee_id
            INNER JOIN _affiliated_with ON _affiliated_with._physician = _physician._employee_id
            INNER JOIN _department ON _department._department_id = _affiliated_with._department
        WHERE _appointment._patient = S._ssn AND _department._name = "cardiology"
    ) AND
    NOT EXISTS (SELECT *
                FROM _department
                WHERE _department._head = T._employee_id
    );

SELECT
    _name,
    _brand
FROM _medication
    INNER JOIN (SELECT
                    _medication, COUNT(*) as frequency
                FROM _prescribes
                GROUP BY _medication
                ORDER BY frequency DESC LIMIT 1) as M ON M._medication = _code;

