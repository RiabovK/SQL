WITH max_t(student_name, Урок, mt) AS
(SELECT student_name, CONCAT(module_id, '.' ,lesson_position), MAX(submission_time)
FROM lesson
     INNER JOIN step USING(lesson_id)
     INNER JOIN step_student USING(step_id)
     INNER JOIN student USING(student_id)
WHERE result = 'correct'
GROUP BY student_name, lesson_id),

req AS
(SELECT student_name
FROM max_t
GROUP BY student_name
HAVING COUNT(*) = 3)

SELECT student_name AS Студент, Урок, FROM_UNIXTIME(mt) AS Макс_время_отправки, IFNULL(CEIL((mt - LAG(mt) OVER(PARTITION BY student_name ORDER BY mt)) / 86400), '-') AS Интервал
FROM max_t INNER JOIN req USING(student_name)
ORDER BY 1, 3