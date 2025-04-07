-- INIT database
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,  -- Changed to VARCHAR instead of TEXT
  class VARCHAR(50) NOT NULL,  -- Changed to VARCHAR instead of TEXT
  Gender VARCHAR(10)           -- Changed to VARCHAR instead of TEXT
);

-- Inserting data into students table
INSERT INTO students (student_id, name, class, gender)
VALUES (1, 'John Doe', '10th', 'Male'),
       (2, 'Jane Smith', '12th', 'Female'),
       (3, 'Sam Wilson', '11th', 'Male');

CREATE TABLE marks (
    mark_id INT PRIMARY KEY,           -- Unique ID for each mark record
    student_id INT,                    -- Reference to the student
    subject VARCHAR(100) NOT NULL,     -- Changed to VARCHAR instead of TEXT
    marks_obtained INT NOT NULL,       -- Marks obtained in the subject
    FOREIGN KEY (student_id) REFERENCES students(student_id)  -- Foreign key referencing students table
);

-- Inserting data into marks table
INSERT INTO marks (mark_id, student_id, subject, marks_obtained)
VALUES (1, 1, 'Math', 85),
       (2, 1, 'English', 92),
       (3, 2, 'Math', 78),
       (4, 2, 'English', 88),
       (5, 3, 'Math', 91),
       (6, 3, 'English', 89);

CREATE TABLE grades (
    grade_id INT IDENTITY(1,1) PRIMARY KEY ,  -- Unique ID for each record
    student_id INT,                          -- Foreign key linking to the students table
    subject VARCHAR(100),                    -- Changed to VARCHAR instead of TEXT
    marks_obtained INT,                      -- Marks obtained in that subject
    grade VARCHAR(2),                        -- Changed to VARCHAR instead of TEXT
    FOREIGN KEY (student_id) REFERENCES students(student_id)  -- Foreign key constraint
);

-- Insert calculated grades into the grades table
INSERT INTO grades (student_id, subject, marks_obtained, grade)
SELECT m.student_id, m.subject, m.marks_obtained,
       CASE
           WHEN m.marks_obtained >= 90 THEN 'A'
           WHEN m.marks_obtained >= 80 THEN 'B'
           WHEN m.marks_obtained >= 70 THEN 'C'
           WHEN m.marks_obtained >= 60 THEN 'D'
           ELSE 'F'
       END AS grade
FROM marks m;