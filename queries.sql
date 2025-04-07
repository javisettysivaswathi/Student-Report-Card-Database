-- Generating the final report card
     
SELECT s.name, s.class,
       STUFF((
           SELECT ', ' + g.subject + ': ' + CAST(g.marks_obtained AS VARCHAR(10)) + ' (' 
                        + g.grade + ')'
           FROM grades g
           WHERE g.student_id = s.student_id
           FOR XML PATH('')
       ), 1, 2, '') AS report_card,
       SUM(g.marks_obtained) AS total_marks,
       AVG(g.marks_obtained) AS average_marks,  -- Average marks
       CASE
           WHEN AVG(g.marks_obtained) >= 90 THEN 'A'
           WHEN AVG(g.marks_obtained) >= 80 THEN 'B'
           WHEN AVG(g.marks_obtained) >= 70 THEN 'C'
           WHEN AVG(g.marks_obtained) >= 60 THEN 'D'
           ELSE 'F'
       END AS average_grade -- Average grade based on average marks
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.name, s.class;

UPDATE students
SET average_marks = (
    SELECT AVG(g.marks_obtained)
    FROM grades g
    WHERE g.student_id = students.student_id
),
average_grade = (
    SELECT CASE
                WHEN AVG(g.marks_obtained) >= 90 THEN 'A'
                WHEN AVG(g.marks_obtained) >= 80 THEN 'B'
                WHEN AVG(g.marks_obtained) >= 70 THEN 'C'
                WHEN AVG(g.marks_obtained) >= 60 THEN 'D'
                ELSE 'F'
           END
    FROM grades g
    WHERE g.student_id = students.student_id
);

SELECT student_id, name, class, average_marks, average_grade
FROM students;








