-- Peace University Management System
create database Peace_Uni;

use Peace_Uni;

-- 1. Department
CREATE TABLE Department (
    Department_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200)
);

-- 2. Instructor
CREATE TABLE Instructor (
    Instructor_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

-- 3. Course
CREATE TABLE Course (
    Course_ID INT AUTO_INCREMENT PRIMARY KEY,
    Course_Code VARCHAR(20) UNIQUE NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Credits INT CHECK (Credits > 0 AND Credits <= 6),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

-- 4. Course_Instructor
CREATE TABLE Course_Instructor (
    Course_Instructor_ID INT AUTO_INCREMENT PRIMARY KEY,
    Course_ID INT,
    Instructor_ID INT,
    Role VARCHAR(20) CHECK (Role IN ('Primary', 'Secondary', 'TA')),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
    UNIQUE (Course_ID, Instructor_ID)
);

-- 5. Student
CREATE TABLE Student (
    Student_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DOB DATE,
    Status VARCHAR(20) CHECK (Status IN ('Active', 'Graduated', 'Suspended', 'Deferred'))
);

-- 6. Erollment
CREATE TABLE Enrollment (
    Enrollment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE DEFAULT CURRENT_DATE,
    Semester VARCHAR(10) CHECK (Semester IN ('Fall', 'Spring', 'Summer')),
    Year INT,
    Grade VARCHAR(2) CHECK (Grade IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F', NULL)),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    UNIQUE (Student_ID, Course_ID, Semester, Year)
);

-- 7. Academic_Records
CREATE TABLE Academic_Records (
    Record_ID INT AUTO_INCREMENT PRIMARY KEY,
    Student_ID INT UNIQUE,
    GPA DECIMAL(3,2) CHECK (GPA >= 0.0 AND GPA <= 4.0),
    Total_Credits INT DEFAULT 0,
    Academic_Standing VARCHAR(20) CHECK (Academic_Standing IN ('Good', 'Probation', 'Suspended')),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);


INSERT INTO Department (Name, Address) 
VALUES
('Computer Science', 'Block A, Room 100'),
('Mathematics', 'Block B, Room 200'),
('Business Administration', 'Block C, Room 300'),
('Engineering', 'Block D, Room 400'),
('Physics', 'Block E, Room 500')
;

INSERT INTO Instructor ( First_Name, Last_Name, Email, Department_ID)
VALUES
('John', 'Kibet', 'john.kibet@peace-university.edu', 1),
('Sarai', 'Njeri', 'sarai.njeri@peace-university.edu', 1),
('Ben', 'Mwangi', 'ben.mwangi@peace-university.edu', 2),
('Kimberly', 'Oloo', 'kimberly.oloo@peace-university.edu', 2),
('Edwin', 'mawera', 'edwin.mawera@peace-university.edu', 3),
('Eva', 'Kahoots', 'eva.kahoots@peace-university.edu', 3),
('David', 'Goliath', 'david.goliath@peace-university.edu', 4),
('Esther', 'Makori', 'esther.makori@peace-university.edu', 4),
('Lee', 'Blake', 'lee.blake@peace-university.edu', 5),
('Faith', 'Mariga', 'faith.mariga@peace-university.edu', 5)
;

INSERT INTO Course (Course_Code, Title, Credits, Department_ID) 
values
('CS101', 'Introduction to Programming', 3, 1),
('CS102', 'Data Structures and Algorithms', 4, 1),
('MATH101', 'Calculus I', 3, 2),
('MATH102', 'Algebra', 3, 2),
('BUS202', 'Business Ethics', 2, 3),
('BUS301', 'Strategic Management', 4, 3),
('ENG101', 'Introduction to Engineering', 3, 4),
('ENG102', 'Engineering Mechanics', 4, 4),
('PHY202', 'Electromagnetism', 3, 5),
('PHY301', 'Quantum Mechanics', 4, 5)
;

INSERT INTO Course_Instructor (Course_ID, Instructor_ID, Role) 
values
(1, 1, 'Primary'),
(2, 2, 'Secondary'),
(3, 3, 'TA'),
(4, 4, 'Primary'),
(5, 5, 'Secondary'),
(6, 6, 'TA'),
(7, 7, 'Primary'),
(8, 8, 'Secondary'),
(9, 9, 'Secondary'),
(10, 10, 'Primary')
;

INSERT INTO Student (First_Name, Last_Name, Email, DOB, Status)
VALUES
('Alice', 'Johnson', 'alice.johnson@peace-student.edu', '2000-05-15', 'Active'),
('Diana', 'Smith', 'diana.smith@peace-student.edu', '2000-03-10', 'Deferred'),
('Eve', 'Adams', 'eve.adams@peace-student.edu', '2002-07-19', 'Active'),
('Frank', 'Miller', 'frank.miller@peace-student.edu', '2001-11-05', 'Active'),
('Grace', 'Davis', 'grace.davis@peace-student.edu', '2000-09-25', 'Active'),
('Henry', 'Garcia', 'henry.garcia@peace-student.edu', '1999-06-30', 'Graduated'),
('Ivy', 'Rodriguez', 'ivy.rodriguez@peace-student.edu', '2002-02-14', 'Active'),
('Jack', 'Martinez', 'jack.martinez@peace-student.edu', '2001-04-08', 'Deferred'),
('Karen', 'Hernandez', 'karen.hernandez@peace-student.edu', '2000-10-12', 'Active'),
('Rachel', 'Moore', 'rachel.moore@peace-student.edu', '2000-08-14', 'Active'),
('Sam', 'Jackson', 'sam.jackson@peace-student.edu', '2002-04-01', 'Suspended'),
('Leo', 'Lopez', 'leo.lopez@peace-student.edu', '1998-07-20', 'Graduated'),
('Mia', 'Gonzalez', 'mia.gonzalez@peace-student.edu', '2001-12-03', 'Active'),
('Noah', 'Wilson', 'noah.wilson@peace-student.edu', '2000-01-17', 'Active'),
('Samwel', 'Njenga', 'samwel.njenga@peace-student.edu', '2002-05-29', 'Suspended'),
('Tina', 'Martin', 'tina.martin@peace-student.edu', '2001-10-30', 'Active'),
('Mark', 'Tony', 'mark.tony@peace-student.edu', '2003-12-12', 'Active'),
('Quinn', 'Taylor', 'quinn.taylor@peace-student.edu', '2001-06-28', 'Active'),
('Cate', 'Malala', 'cate.malala@peace-student.edu', '2002-11-30', 'Active'),
('Martin', 'Antony', 'martin.antony@peace-student.edu', '2001-12-17', 'Active')
;


INSERT INTO Enrollment (Student_ID, Course_ID, Enrollment_Date, Semester, Year, Grade)
VALUES
(1, 1, '2024-09-01', 'Fall', 2024, 'A'),
(2, 1, '2024-03-01', 'Spring', 2023, 'A-'),
(3, 1, '2024-06-01', 'Summer', 2024, 'B+'),
(4, 2, '2024-09-01', 'Fall', 2024, 'A'),
(5, 2, '2024-03-01', 'Spring', 2024, 'A-'),
(6, 2, '2024-06-01', 'Summer', 2021, 'B+'),
(7, 3, '2024-09-01', 'Fall', 2024, 'A'),
(8, 3, '2024-03-01', 'Spring', 2023, 'A-'),
(9, 3, '2024-06-01', 'Summer', 2024, 'B+'),
(10, 4, '2024-03-01', 'Spring', 2024, 'A'),
(11, 4, '2024-09-01', 'Fall', 2022, 'A-'),
(12, 4, '2024-06-01', 'Summer', 2021, 'B+'),
(13, 5, '2024-03-01', 'Spring', 2024, 'A'),
(14, 5, '2024-09-01', 'Fall', 2024, 'A-'),
(15, 5, '2024-03-01', 'Spring', 2022, 'B+'),
(16, 1, '2024-09-01', 'Fall', 2024, 'A'),
(17, 2, '2024-03-01', 'Spring', 2024, 'A-'),
(18, 3, '2024-09-01', 'Fall', 2024, 'B+'),
(19, 4, '2024-06-01', 'Summer', 2024, 'A-'),
(20, 5, '2024-06-01', 'Summer', 2024, 'B+')
;

INSERT INTO Academic_Records (Student_ID, GPA, Total_Credits, Academic_Standing) 
VALUES
(1, 3.75, 45, 'Good'),
(2, 3.20, 48, 'Suspended'),    -- Deferred
(3, 3.90, 42, 'Good'),
(4, 3.45, 39, 'Probation'),  -- Low GPA
(5, 3.60, 51, 'Good'),
(6, 2.80, 42, 'Good'),     -- Graduated
(7, 3.85, 47, 'Good'),
(8, 3.10, 60, 'Suspended'),     -- Deferred
(9, 3.50, 44, 'Good'),
(10, 2.50, 36, 'Probation'),        -- Low GPA
(11, 3.30, 40, 'Suspended'),  -- Suspended
(12, 3.00, 65, 'Good'),    -- Graduated
(13, 3.70, 43, 'Good'),
(14, 2.90, 38, 'Probation'), -- Low GPA
(15, 3.55, 41, 'Suspended'),  -- Suspended
(16, 3.20, 58, 'Good'),    -- Graduated
(17, 1.80, 30, 'Probation'),        -- Low GPA
(18, 3.80, 46, 'Good'),
(19, 3.40, 42, 'Good'),
(20, 2.60, 35, 'Probation') -- Low GPA
;







