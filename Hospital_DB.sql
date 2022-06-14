DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
use hospital;

DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Physician;
DROP TABLE IF EXISTS Nurse;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Hospitalization;
DROP TABLE IF EXISTS Monitor;
DROP TABLE IF EXISTS Instructions;
DROP TABLE IF EXISTS Nurse_Execution;
DROP TABLE IF EXISTS Medication;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Payment;

CREATE TABLE Staff(
name	VARCHAR(40),
address	VARCHAR(80),
phone_num VARCHAR(10),
staff_type	VARCHAR(15),
staff_num	VARCHAR(20),
PRIMARY KEY(staff_num)
);

CREATE TABLE Physician(
physician_id	VARCHAR (20),
staff_num	VARCHAR (20),
certification_num	VARCHAR(16),
field_of_expertise	VARCHAR(50),
PRIMARY KEY(physician_id, staff_num),
FOREIGN KEY(staff_num) REFERENCES Staff(staff_num)
);

CREATE TABLE Nurse(
nurse_id VARCHAR (20),
certification_num VARCHAR(16),
staff_num VARCHAR(20),
PRIMARY KEY(nurse_id, staff_num),
FOREIGN KEY(staff_num) REFERENCES Staff(staff_num)
);

CREATE TABLE Patient(
patient_id VARCHAR (20),
name	VARCHAR(50),
address	VARCHAR(80),
phone_num VARCHAR(10),
PRIMARY KEY(patient_id)
);

CREATE TABLE Room(
room_num VARCHAR(3),
capacity VARCHAR(2),
fee_per_night	VARCHAR(5),
PRIMARY KEY(room_num)
);

CREATE TABLE Hospitalization(
room_num VARCHAR(3),
patient_id VARCHAR (20),
num_of_nights VARCHAR(4),
PRIMARY KEY(patient_id,room_num),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Monitor(
patient_id VARCHAR (20),
physician_id	VARCHAR (20),
duration VARCHAR(4),
PRIMARY KEY(patient_id, physician_id),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY (physician_id) REFERENCES Physician(physician_id)

);

CREATE TABLE Instructions(
physician_id	VARCHAR (20),
patient_id VARCHAR (20),
date DATE,
instruction_id VARCHAR (20),
description VARCHAR(200),
PRIMARY KEY(physician_id, patient_id),
FOREIGN KEY(physician_id) REFERENCES Physician(physician_id),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Nurse_Execution(
nurse_id VARCHAR (20),
date DATE,
status VARCHAR(40),
patient_id VARCHAR (20),
nurse_execution_code VARCHAR (20),
PRIMARY KEY(nurse_id,patient_id),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY(nurse_id) REFERENCES Nurse(nurse_id)
);

CREATE TABLE Medication(
nurse_id VARCHAR (20),
patient_id VARCHAR (20),
payable_medicine VARCHAR(30),
medicine	VARCHAR(50),
dosage 	VARCHAR(20),
PRIMARY KEY (payable_medicine, patient_id, nurse_id),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY(nurse_id) REFERENCES Nurse(nurse_id)
);

CREATE TABLE Invoice(
payable_medicine VARCHAR(30),
invoice_num VARCHAR (20),
date DATE,
patient_id VARCHAR (20),
room_fee VARCHAR(20),
instruction_fee VARCHAR(20),
PRIMARY KEY(patient_id, payable_medicine),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY(payable_medicine) REFERENCES Medication(payable_medicine)
);

CREATE TABLE Payment(
patient_id VARCHAR (20),
date DATE,
amount VARCHAR(20),
PRIMARY KEY(patient_id),
FOREIGN KEY(patient_id) REFERENCES Patient(patient_id)
);