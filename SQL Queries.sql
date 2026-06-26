-- Qeries

use Peace_Uni;

-- View All Students
select*
from Student;

-- view all courses
select*
from Course;

-- insert a new Student
insert into Student (First_Name, Last_Name, Email, DOB, Status)
values ('George', 'Kiptoo', 'george.kiptoo@peace-student.edu', '2001-02-08', 'Active')
;

-- Update instructors email
update Instructor
set email = 'hello.okay@tries.com'
where Instructor_ID = 4;

-- Delete an enrollment
delete from Enrollment
where Enrollment_ID = 1;

-- Join students with courses
SELECT s.First_Name, s.Last_Name, c.Course_Code, e.Grade
FROM Enrollment e
JOIN Student s ON e.Student_ID = s.Student_ID
JOIN Course c ON e.Course_ID = c.Course_ID;

-- Show students with grade A
SELECT s.First_Name, s.Last_Name, c.Course_Code, e.Grade
FROM Enrollment e
JOIN Student s ON e.Student_ID = s.Student_ID
JOIN Course c ON e.Course_ID = c.Course_ID
WHERE e.Grade = 'A';

-- Average credit of all courses
SELECT AVG(Credits) AS average_credits
FROM Course;

-- Show courses with instructor names
SELECT c.Title, i.First_Name, i.Last_Name
FROM Course c
JOIN Course_Instructor ci
ON c.Course_ID = ci.Course_ID
JOIN Instructor i
ON ci.Instructor_ID = i.Instructor_ID;


-- Create store procedure
delimiter //

CREATE PROCEDURE GetProbationStudents()
BEGIN
    SELECT 
        s.Student_ID,
        CONCAT(s.First_Name, ' ', s.Last_Name) AS StudentName
    FROM Student s
    JOIN Academic_Records a ON s.Student_ID = a.Student_ID
    WHERE a.Academic_Standing = 'Probation';
end //

delimiter ;

CALL GetProbationStudents();
# Displays students on probation

-- Inner Join
SELECT 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    a.GPA,
    a.Academic_Standing
FROM Student s
INNER JOIN Academic_Records a ON s.Student_ID = a.Student_ID;
# George Kiptoo has no academic record so he is not visible in the table

-- Left Join
SELECT 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    a.GPA,
    a.Academic_Standing
FROM Student s
LEFT JOIN Academic_Records a ON s.Student_ID = a.Student_ID;
# All students, even if they have no academic record

-- Right Join
SELECT 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    a.GPA,
    a.Academic_Standing
FROM Student s
RIGHT JOIN Academic_Records a ON s.Student_ID = a.Student_ID;
# All academic records

-- Full Join
SELECT 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    a.GPA,
    a.Academic_Standing
FROM Student s
LEFT JOIN Academic_Records a ON s.Student_ID = a.Student_ID

UNION

SELECT 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    a.GPA,
    a.Academic_Standing
FROM Student s
RIGHT JOIN Academic_Records a ON s.Student_ID = a.Student_ID;

-- Transaction Enroll a student

START TRANSACTION;

-- 1: Check if student exists
SELECT 'Checking if student exists...' AS Status;
SELECT * FROM Student WHERE Student_ID = 1;

-- 2: Check if course exists
SELECT 'Checking if course exists...' AS Status;
SELECT * FROM Course WHERE Course_ID = 1;

-- 3: Enroll the student
SELECT 'Enrolling student...' AS Status;
INSERT INTO Enrollment (Student_ID, Course_ID, Semester, Year, Enrollment_Date)
VALUES (1, 1, 'Fall', 2025, CURDATE());

-- 4: Check the enrollment
SELECT 'Enrollment completed!' AS Status;
SELECT * FROM Enrollment WHERE Student_ID = 1 AND Course_ID = 1;

-- If all steps succeeded, commit
COMMIT;

-- Trigers

DELIMITER //

CREATE TRIGGER UpdateStanding
AFTER UPDATE ON Academic_Records
FOR EACH ROW
BEGIN
    -- Update standing based on GPA
    UPDATE Academic_Records 
    SET Academic_Standing = 
        CASE 
            WHEN NEW.GPA >= 2.0 THEN 'Good'
            WHEN NEW.GPA >= 1.0 THEN 'Probation'
            ELSE 'Suspended'
        END
    WHERE Student_ID = NEW.Student_ID;
END //

DELIMITER ;
-- Test
UPDATE Academic_Records SET GPA = 1.50 WHERE Student_ID = 2;

SELECT * FROM Academic_Records WHERE Student_ID = 2;



