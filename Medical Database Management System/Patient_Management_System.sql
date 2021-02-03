CREATE TABLE staff(
    staff_name VARCHAR(25) NOT NULL,
    emp_id NUMBER PRIMARY KEY,
    gender VARCHAR(10),
    salary NUMBER,
    qulifications VARCHAR(25),
    phone_number NUMBER,
    address VARCHAR(50),
    special VARCHAR(50) NOT NULL
);
insert into staff values('John Doe', 1, 'male', 200000, 'degree', 416, 'XX Place Drive', 'neuroseurgeon');
insert into staff values('Jane Albert', 2, 'female', 210000, 'degree', 4161234566, '45 Study Drive', 'technician');
insert into staff values('Michael Toon', 3, 'male', 80000, 'diploma', 8974561234, '15 Library Avenue', 'receptionist');
insert into staff values('Emily Blake', 4, 'female', 95000, 'diploma', 6458921678, '125 Desert Road', 'nurse');
insert into staff values('Lydia Chen', 5, 'female', 65000, 'doctoral degree', 5684359635, '7 Best Drive', 'technologist');
select * from staff;

CREATE TABLE billed (
    bill_id NUMBER PRIMARY KEY,
    patient_id NUMBER REFERENCES patient(patient_id),
    procedure_id NUMBER REFERENCES pro_cedure(p_id),
    medicine_id NUMBER REFERENCES medicine(m_id),
    app_id NUMBER REFERENCES appointment(a_id) NOT NULL
);
insert into billed values(1, 3, 1, NULL, 1);
insert into billed values(2, 1, 2, NULL, 2);
select * from billed;

CREATE TABLE appointment (
    a_id NUMBER PRIMARY KEY,
    app_date TIMESTAMP NOT NULL,
    patient_id NUMBER REFERENCES patient(patient_id)
);
insert into appointment values(1, '2020-08-04 13:00:00', 3);
insert into appointment values(2, '2020-04-06 10:00:00', 1);
insert into appointment values(3, '2020-09-05 12:00:00', 2);
select * from appointment;

CREATE TABLE patient(
    p_name VARCHAR(25),
    patient_id NUMBER PRIMARY KEY,
    gender VARCHAR(10),
    admission_date DATE, 
    discharge_date DATE,
    address VARCHAR(50),
    phone_number NUMBER
);
insert into patient values('Sara', 1, 'female', '2020-09-12', '2020-09-17', '123 Anywhere Drive', '4169876543');
insert into patient values('David James', 2, 'male', '2020-06-11', '2020-07-12', '456 Lily Drive', '4164536785');
insert into patient values('Joe Lad', 3, 'male', '2020-02-14', '2020-02-14', '789 Fall Drive', '4164890785');
select * from patient;

CREATE TABLE schedule(
    s_id NUMBER PRIMARY KEY,
    emp_id NUMBER REFERENCES staff(emp_id),
    start_time TIMESTAMP,
    end_time TIMESTAMP
);
insert into schedule values(1, 1, '2020-08-04 12:00:00', '2020-08-04 15:00:00');
insert into schedule values(2, 2, '2020-09-05 08:00:00', '2020-09-05 12:00:00');
insert into schedule values(3, 1, '2020-04-06 10:00:00', '2020-04-06 15:00:00');
select * from schedule;

CREATE TABLE equipment (
    equipment_id NUMBER PRIMARY KEY, 
    room_number NUMBER REFERENCES room(room_number),
    price NUMBER,
    description VARCHAR(100)
);
insert into equipment values(1, 1, 99, 'Used for MRI Sacn');
select * from equipment;

CREATE TABLE medical_record (
    record_number NUMBER PRIMARY KEY,
    patient_id NUMBER REFERENCES patient(patient_id),
    patient_info VARCHAR(1000)
);
insert into medical_record values(1,1);
insert into medical_record values(3,2);
insert into medical_record values(2,3);
select * from medical_record;

CREATE TABLE medical_entry (
    entry_number NUMBER,
    record_number NUMBER REFERENCES medical_record(record_number),
    entry_description VARCHAR(100),
    PRIMARY KEY(entry_number, record_number)
);
insert into medical_entry values(1, 1, 'Check up');
insert into medical_entry values(2, 1, 'Broken Nose');
insert into medical_entry values(1, 2, 'Check up');
insert into medical_entry values(1, 3, 'Withdrawl');
select * from medical_entry;

CREATE TABLE medicine(
    m_id NUMBER PRIMARY KEY,
    price NUMBER,
    dosage VARCHAR(25),
    m_name VARCHAR(25)
);
insert into medicine values(1, 10, '10mg', 'tylenol');
insert into medicine values(2, 27, '50mg', 'advil');
insert into medicine values(3, 100, '100mg', 'insulin');
select * from medicine;

CREATE TABLE pro_cedure (
    p_id NUMBER PRIMARY KEY,
    p_type VARCHAR(25),
    price NUMBER
);
insert into pro_cedure values(1, 'heart surgery', 5000);
insert into pro_cedure values(2, 'therapy', 8000);
select * from pro_cedure;

CREATE TABLE insurance(
    provider_name VARCHAR(25),
    insurance_number NUMBER PRIMARY KEY,
    phone_number NUMBER,
    address VARCHAR(50)
);
insert into insurance values('Sunlife',1,4157891234,'67 Bank Drive');
insert into insurance values('Moonlife',2,456789123,'98 Wall Street');
select * from insurance;

CREATE TABLE claim(
    claim_number NUMBER PRIMARY KEY,
    bill_id NUMBER REFERENCES billed(bill_id)
);
insert into claim values(1, 2);
insert into claim values(2, 1);
select * from claim;

CREATE TABLE room(
    room_number NUMBER PRIMARY KEY,
    room_type VARCHAR(25)
);
insert into room values(1, 'recovery');
insert into room values(2, 'surgery');
select * from room;

CREATE TABLE uses(
    equipment_id NUMBER REFERENCES equipment(equipment_id),
    emp_id NUMBER REFERENCES staff(emp_id),
    PRIMARY KEY (equipment_id, emp_id)
);
insert into uses values(1,3);
select * from uses;

CREATE TABLE manages(
    record_number NUMBER REFERENCES medical_record(record_number),
    emp_id NUMBER REFERENCES staff(emp_id)
);
insert into manages values(3,2);
insert into manages values(1,3);
select * from manages;

CREATE TABLE follow (
    emp_id NUMBER REFERENCES staff(emp_id),
    s_id NUMBER REFERENCES schedule(s_id),
    PRIMARY KEY(emp_id, s_id)
);
insert into follow values(1,1);
insert into follow values(2,2);
select * from follow;

CREATE TABLE attends(
    emp_id NUMBER REFERENCES staff(emp_id),
    patient_id NUMBER REFERENCES patient(patient_id),
    PRIMARY KEY (emp_id, patient_id)
);
insert into attends values(1,1);
insert into attends values(2,2);
select * from attends;

CREATE TABLE governs (
    emp_id NUMBER REFERENCES staff(emp_id),
    room_number NUMBER REFERENCES room(room_number),
    PRIMARY KEY (emp_id, room_number)
);
insert into governs values(1, 1);
insert into governs values(2, 2);
select * from governs;

CREATE TABLE handles (
    emp_id NUMBER REFERENCES staff(emp_id),
    appointment_id NUMBER REFERENCES appointment(a_id),
    PRIMARY KEY(emp_id, appointment_id)
);
insert into handles values(2,1);
insert into handles values(4,2);
insert into handles values(2, 3);
select * from handles;