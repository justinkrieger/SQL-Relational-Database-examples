-- Problem 1
SELECT COUNT(InstructorID) AS NumberInstructors, AVG(AnnualSalary) AS AverageSalary
FROM Instructors
WHERE Status = 'F'


-- Problem 2
SELECT DepartmentName, COUNT(InstructorID) AS InstructorCount, MAX(AnnualSalary) AS MaxSalary
FROM Departments
    JOIN Instructors
        ON Departments.DepartmentID = Instructors.DepartmentID
GROUP BY DepartmentNAme
ORDER BY InstructorCount DESC


-- Problem 3
SELECT CONCAT(FirstName, ' ', LastName) AS InstructorName, Count(CourseID) AS ClassCount
FROM Instructors
     JOIN Courses
     
