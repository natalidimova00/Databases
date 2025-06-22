-- 1.
ALTER TABLE MOVIE
ADD CONSTRAINT unique_length UNIQUE (length)

ALTER TABLE MOVIE
ADD CONSTRAINT unique_studio_length UNIQUE (studioName, length)

-- 2.
ALTER TABLE MOVIE
DROP CONSTRAINT unique_length

ALTER TABLE MOVIE
DROP CONSTRAINT unique_studio_length

-- 3.
CREATE TABLE Students (
	fn INT NOT NULL CHECK (fn BETWEEN 1 AND 99999),
	name VARCHAR(100) NOT NULL,
	egn CHAR(10) NOT NULL UNIQUE CHECK (LEN(egn) = 10),
	email NVARCHAR(100) NOT NULL UNIQUE,
	birth_date DATE NOT NULL,
	enrollment_date DATE NOT NULL CHECK (DATEDIFF(YEAR, birth_date, enrollment_date) >= 18),
	CONSTRAINT PK_Students PRIMARY KEY (fn),
	CONSTRAINT CK_Email_ValidFormat CHECK (email LIKE '_%@_%._%')
)

CREATE TABLE Courses (
	course_id INT PRIMARY KEY,
	name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE StudentCourses (
	fn INT NOT NULL,
	course_id INT NOT NULL,
	PRIMARY KEY (fn, course_id),
	FOREIGN KEY (fn) REFERENCES Students(fn) ON DELETE CASCADE,
	FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
)