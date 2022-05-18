-- Problem 1
SELECT CourseNumber, CourseDescription, DepartmentName
FROM Courses
JOIN Departments
    ON Courses.DepartmentID = Departments.DepartmentID
ORDER BY DepartmentName, CourseNumber ASC;


-- Problem 2
SELECT LAstName, FirstName, CourseNumber, CourseDescription
FROM Departments
JOIN Courses
    ON Departments.DepartmentID = Courses.DepartmentID
JOIN Instructors
    ON Departments.DepartmentID = Instructors.DepartmentID
WHERE Instructors.Status = 'P'
ORDER BY LastName, FirstName;


-- Problem 3
SELECT DepartmentName, CourseDescription, FirstName, LastName
FROM Departments d
JOIN Course c
    ON d.DepartmentID = c.DepartmentID
JOIN Instructors i
    ON d.DepartmentID = i.DepartmentID
ORDER BY DepartmentName, CourseDescription ASC;


-- Problem 4
SELECT DepartmentName, CourseDescription, FirstName, LastName
FROM Departments
JOIN Courses
    ON Departments.DepartmentID = Courses.DepartmentID
JOIN StudentCourses
    ON Courses.CourseID = StudentCourses.CourseID
JOIN Students
    ON StudentCourses.StudentID = Students.StudentID
WHERE DepartmentName = 'English'
ORDER BY DepartmentName, CourseDescription ASC;


-- Problem 5
LastName, FirstName, CourseDescription
FROM Instructors
LEFT JOIN Courses
    ON Instructors.InstructorID = Courses.InstructorID
ORDER BY LastName, FirstName;


-- Problem 6
    SELECT 'UNDERGRAD' AS Status, FirstName,
        LastName, EnrolmentDate, GraduationDate
    FROM Students
    WHERE FGraduationDate IS NULL
UNION
    SELECT 'GRADUATED' AS Status, FirstName,
        LastName, EnrollmentDate, GraduationDate
    FROM Students
    WHERE GraduationDate IS NOT NULL
ORDER BY EnrollmentDate;


-- Problem 7
SELECT DepartmentName, CourseID
FROM Departments
FULL OUTER JOIN Courses
    ON Departments.DepartmentID = Courses.DepartmentID
WHERE CourseID IS NULL;


-- Problem 8
SELECT d2.DepartmentName AS InstructorDept,
    FirstName, LastName, CourseDescription,
    d1.DepartmentName as CourseDept
FROM Courses
JOIN Departments d1
    ON Courses.DepartmentID = d1.DepartmentID
JOIN Instructors
    ON Course.InstructorID = Instructors.InstructorID
JOIN Departments d1
    ON Instructors.DepartmentID = d2.DepartmentID
WHERE d1.DepartmentID <> d2.DepartmentName;
