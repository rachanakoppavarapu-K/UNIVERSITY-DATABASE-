CREATE DATABASE UNIVERSITY;

USE UNIVERSITY;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Major VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

USE UNIVERSITY;

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE UNIVERSITY.Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

DROP TABLE UNIVERSITY.Departments;

INSERT INTO Students (StudentID, Name, Age, Major, Email) VALUES
(1, 'Alex', 20, 'Computer Science', 'alex@gmail.com'),
(2, 'Brian', 22, 'Data Science', 'brian@gmail.com'),
(3, 'Catherine', 19, 'Cyber', 'catherine@gmail.com'),
(4, 'Daniel', 23, 'Computer Science', 'daniel@gmail.com'),
(5, 'Ella', 21, 'Data Science', 'ella@gmail.com'),
(6, 'Felix', 24, 'Machine Learning', 'felix@gmail.com'),
(7, 'Grace', 20, 'Cyber', 'grace@gmail.com'),
(8, 'Hannah', 22, 'Computer Science', 'hannah@gmail.com'),
(9, 'Ian', 25, 'Machine Learning', 'ian@gmail.com'),
(10, 'Julia', 21, 'AI', 'julia@gmail.com');

INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
(101, 'Database Systems', 4),
(102, 'DBMS', 3),
(103, 'Algorithms', 4),
(104, 'Statistics', 3),
(105, 'Deep Learning', 4);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(1, 1, 101, 'A+'),   
(2, 1, 102, 'B+'),   
(3, 2, 101, 'A+'),   
(4, 3, 103, 'C+'),   
(5, 4, 102, 'A+'),   
(6, 5, 103, 'B+'),   
(7, 6, 104, 'B+'),   
(8, 7, 103, 'A+'),   
(9, 8, 105, 'C+'),   
(10, 9, 104, 'A+'),  
(11, 10, 105, 'B+'); 

UPDATE Students SET Major = 'Data Science' WHERE StudentID = 1;

DELETE FROM Students WHERE Age <= 19;

SELECT Name, Major FROM Students WHERE Age > 19;

SELECT AVG(Age) AS AvgAge FROM Students;

SELECT Major, COUNT(*) AS StudentCount
FROM Students
GROUP BY Major
HAVING COUNT(*) >= 2;

SELECT * FROM Students WHERE Age > 20 AND Major = 'Computer Science';

SELECT s.Name, e.Grade,
       RANK() OVER (ORDER BY e.Grade DESC) AS RankInClass
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID;

SELECT s.Name, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

SELECT s.Name, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

SELECT s.Name, c.CourseName
FROM Students s
CROSS JOIN Courses c;

SELECT s1.Name AS Student1, s2.Name AS Student2
FROM Students s1
JOIN Students s2
ON s1.Major = s2.Major
AND s1.StudentID <> s2.StudentID;

SELECT Major, GROUP_CONCAT(Name ORDER BY Name SEPARATOR ', ') AS Students
FROM Students
GROUP BY Major;

SELECT Name 
FROM Students
WHERE Age > (SELECT AVG(Age) FROM Students);

SELECT Name FROM Students s
WHERE EXISTS (
    SELECT * FROM Enrollments e
    WHERE e.StudentID = s.StudentID  AND e.Grade = 'A+'
);

SELECT Major, AvgAge
FROM (SELECT Major, AVG(Age) AS AvgAge FROM Students GROUP BY Major) AS t;

SELECT Name FROM Students
UNION
SELECT CourseName FROM Courses;

SELECT StudentID FROM Enrollments
WHERE StudentID IN (SELECT StudentID FROM Students);

SELECT StudentID, Name
FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

ALTER TABLE Students 
ADD CONSTRAINT AgeCheck CHECK (Age >= 17);

ALTER TABLE Students DROP CONSTRAINT AgeCheck;

BEGIN;

INSERT INTO Enrollments VALUES (101, 1, 101, 'A');

UPDATE Students SET Major = 'AI' WHERE StudentID = 1;

COMMIT;

CREATE INDEX idx_student_major ON Students(Major);

SHOW INDEX FROM Students;

EXPLAIN SELECT * FROM Students WHERE Major = 'Data Science';

DROP INDEX idx_student_major ON Students;

SELECT *
FROM Students
WHERE Major = 'Data Science';

SELECT Name, Age
FROM Students;

SELECT *FROM Students WHERE Age > 20;

SELECT Major, COUNT(*)
FROM Students
GROUP BY Major;

SELECT Major, COUNT(*) AS StudentCount
FROM Students
GROUP BY Major
HAVING COUNT(*) >= 2;

SELECT Name, Age
FROM Students
ORDER BY Age DESC;

SELECT Name, Age
FROM Students
ORDER BY Age DESC, Name ASC;

SELECT * FROM Students LIMIT 5;

SELECT s.Name, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

WITH AvgAge AS (
    SELECT AVG(Age) AS AgeValue FROM Students
)
SELECT * 
FROM Students 
WHERE Age > (SELECT AgeValue FROM AvgAge);

INSERT INTO Students (StudentID, Name, Age, Major, Email) VALUES
(11, 'Kevin', 22, 'Data Science', 'kevin@gmail.com');

SELECT StudentID, Name
FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);















































