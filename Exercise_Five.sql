-- Problem 1
SELECT COUNT(InstructorID) AS NumberInstructors, AVG(AnnualSalary) AS AverageSalary
FROM Instructors
WHERE Status = 'F';


-- Problem 2
SELECT DepartmentName, COUNT(InstructorID) AS InstructorCount, MAX(AnnualSalary) AS MaxSalary
FROM Departments
JOIN Instructors
    ON Departments.DepartmentID = Instructors.DepartmentID
GROUP BY DepartmentNAme
ORDER BY InstructorCount DESC;


-- Problem 3
SELECT CONCAT(FirstName, ' ', LastName) AS InstructorName, Count(CourseID) AS ClassCount
FROM Instructors
JOIN Courses
    ON Courses.InstructorID = Instructors.InstructorID
GROUP BY CONCAT(FirstName, ' ', LastName)
ORDER BY ClassCount DESC;
     

-- Problem 4
SELECT DepartmentName, CourseDescription, COUNT(StudentID) AS StudentCount
FROM Courses
JOIN Departments
    ON Courses.DepartmentID = Department.DepartmentID
LEFT JOIN StudentCourses
    ON StudentCourses.CourseID = Courses.CourseID
GROUP BY DepartmentName, Courses.CourseDescription
ORDER BY DepartmentName, StudentCount DESC;


-- Problem 5
SELECT Students.StudentID, COUNT(CourseID) AS CourseCount
FROM Students
JOIN StudentCourses
    ON Students.StudentID = StudentCourses.StudentID
GROUP BY Students.StudentID
ORDER BY CourseCount DESC;


-- Problem 6
SELECT Student.StudentID, COUNT(Courses.CourseID) AS CourseCount
FROM Students
JOIN StudentCourses
    ON Students.StudentID = StudentCourses.StudentID
JOIN Courses
    ON StudentCourses.CourseID = Courses.CourseID
GROUP BY Students.StudentID
ORDER BY Students.StudentID;

-- Problem 7
SELECT Inst.InstructorName, COUNT(Courses.CourseID) AS CoursesTaught
FROM Courses
LEFT JOIN (
    SELECT CONCAT(LastName, ', ', FirstName) AS InstructorName, InstructorID
    FROM Instructors
    WHERE Instuctors.Status = 'P') AS Inst
    ON Inst.InstructorID = Course.InstructorID
WHERE InstructorName IS NOT NULL
GROUP BY Inst.InstructorName;


-- Problem 8
SELECT LastName, FirstName
FROM Instructors
WHERE InstructorID IN (
    SELECT DISTINCT InstructorID
    FROM Courses)
ORDER BY LastName, FirstName;


-- Problem 9
SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnaulSalary > (
    SELECT AVG(AnnualSalary)
    FROM Instructors)
ORDER BY AnnualSalary DESC;


-- Problem 10
SELECT LastName, FirstName
FROM Instructors
WHERE NOT EXISTS (
    SELECT *
    FROM Courses
    WHERE InstructorID = Instructors.InstructorID)
ORDER BY LastName, FirstName;


- Problem 11
SELECT LastName, FirstName, COUNT(*) AS Number of Courses
FROM Students
JOIN StudentCourses
    ON Students.StudentID = StudentCourses.StudentID
WHERE StudentCourses.StudentID IN (
    SELECT StudentID
    FROM StudentCourses
    JOIN Courses
        ON StudentCourses.CourseID = Courses.CourseID
    GROUP BY StudentID
    HAVING COUNT(*) > 1)
GROUP BY LastName, FirstName
ORDER BY LastName, FirstName;


-- Problem 12
SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnualSalary NOT IN (
    SELECT AnnualSalary
    FROM Instructors
    GROUP BY AnnualSalary
    HAVING COUNT(AnnualSalary) > 1)
ORDER BY LastName, FirstName;


-- Problem 13
WITH CourseSummary AS (
    SELECT CoursesSub.CourseID, MAX(EnrillmentDate) AS MaxEnrollmentDate
    FROM Courses CoursesSub
    JOIN StudentCourses StuCorSub
        ON CoursesSub.CourseID = StuCorSub.CourseID
    JOIN Students StuSub
        ON StuCorSub.StudentID = StuSub.StudentID
    GROUP BY CoursesSub.CourseID)
SELECT CourseDescription, LastName, FirstName, EnrollmentDate
FROM Courses CoursesMain
JOIN StudentCourses StuCorMain
    ON CoursesMain.CourseID = StuCorMain.CourseID
JOIN Students StuMain
    ON StuCorMain.StudentID = StuMain.StudentID
JOIN CourseSummary CorSumMain
    ON CoursesMain.CourseID = CorSumMain.CourseID AND StuMain.EnrollmentDate = CorSumMain.MaxEnrollmentDate;
    
-- Problem 14
WITH UnitsSummary AS (
    SELECT Students.StudentID, COUNT(CourseUnits) AS TotalUnits
    FROM Students
    JOIN StudentCourses
        ON Students.StudentID = StudentCourses.StudentID
    JOIN Courses
        ON StudentCourses.CourseID = Courses.CourseID
    GROUP BY Student.StudentID
    HAVING SUM(CourseUnits) > 9)
SELECT StudentID, TotalUnits, FullTimeCost + (TotalUnits * PerUnitCost) AS Tuition
FROM UnitsSummary 
CROSS JOIN Tuition;
