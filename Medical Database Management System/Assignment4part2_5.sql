SELECT medical_record.record_number, patient.p_name
FROM medical_record, patient
WHERE medical_record.patient_id = patient.patient_id
ORDER BY medical_record.patient_id ASC;

SELECT schedule.s_id, staff.staff_name
FROM schedule, staff
WHERE staff.emp_id = schedule.emp_id
ORDER BY schedule.s_id ASC;

SELECT billed.bill_id, claim.claim_number, patient.p_name
FROM billed, patient,claim
WHERE billed.patient_id = patient.patient_id AND claim.bill_id = billed.bill_id
ORDER BY billed.bill_id;

Create VIEW Male_Staff AS(
SELECT staff_name, gender
FROM staff
WHERE gender='male');
select * from male_staff;

Create VIEW Large_Salary AS(
SELECT staff_name, gender, salary
FROM staff
WHERE salary>80000);
select * from large_salary;

Create VIEW Qualify AS(
SELECT staff_name, salary, qulifications, gender
FROM staff
WHERE salary>90000 AND (qulifications='degree' OR qulifications='diploma'));
select * from qualify;

select room.room_number, count(staff.emp_id)
from staff,room
where exists
        (select uses.emp_id, governs.emp_id,equipment.room_number, governs.room_number
         from uses, governs, room, equipment
         where   uses.equipment_id = equipment.equipment_id
                AND governs.room_number =equipment.room_number
                AND ((staff.emp_id = uses.emp_id) OR (staff.emp_id = governs.emp_id)))
        group by room.room_number;
        
(select staff_name from staff)
minus
(select staff_name from schedule, staff
where staff.emp_id = schedule.emp_id);

SELECT MIN(salary), MAX(salary), AVG(salary)
From staff;

SELECT patient.patient_id AS ID, p_name AS PeopleInToday
FROM patient
WHERE EXISTS
    (SELECT *
    FROM appointment
    WHERE patient.patient_id = appointment.patient_id 
          AND app_date = '2020-09-05 12:00:00')
UNION
SELECT staff.emp_id, staff_name
FROM staff
WHERE EXISTS
    (SELECT *
    FROM schedule
    WHERE staff.emp_id = schedule.emp_id
          AND start_time = '2020-09-05 08:00:00');
          
SELECT equipment_id AS EQP_ID, emp_id AS STAFF_ID, staff_name AS STAFF_NAME
FROM equipment, staff
WHERE EXISTS
    (SELECT *
    FROM uses
    WHERE staff.emp_id = uses.emp_id);

    


