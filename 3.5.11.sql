SET @average_time = (SELECT ROUND(AVG(submission_time - attempt_time), 0)
        FROM step_student
             INNER JOIN student USING(student_id)
        WHERE student_name = 'student_59' AND submission_time - attempt_time <= 60*60);


SELECT student_name AS Студент,
       CONCAT(module_id, '.', lesson_position, '.', step_position) AS Шаг,
       ROW_NUMBER() OVER (PARTITION BY step_id ORDER BY submission_time) AS Номер_попытки,
       result AS Результат,
       SEC_TO_TIME(IF(submission_time - attempt_time <60*60, submission_time - attempt_time, @average_time)) AS Время_попытки,
       ROUND(IF(submission_time - attempt_time < 60*60, submission_time - attempt_time, @average_time)*100 /SUM(IF(submission_time - attempt_time < 60*60, submission_time - attempt_time, @average_time)) OVER (PARTITION BY step_id), 2) AS Относительное_время
FROM lesson
     INNER JOIN step USING(lesson_id)
     INNER JOIN step_student USING(step_id)
     INNER JOIN student USING(student_id)
WHERE student_name = 'student_59'
ORDER BY module_id, lesson_position, step_position, submission_time