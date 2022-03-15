WITH table_0(column_0, column_1, column_2) AS 

(SELECT student_id,
       CONCAT(module_id, '.', lesson_position, ' ', lesson_name) AS Урок, 
       SUM(IF(submission_time - attempt_time <= 14400, submission_time - attempt_time, 0)) AS время_решения
FROM module
     INNER JOIN lesson USING(module_id)
     INNER JOIN step USING(lesson_id)
     INNER JOIN step_student USING(step_id)
GROUP BY student_id, Урок
ORDER BY student_id, Урок)

SELECT ROW_NUMBER() OVER (ORDER BY ROUND(AVG(column_2)/3600, 2)) AS Номер,
       column_1 AS Урок, 
       ROUND(AVG(column_2)/3600, 2) AS Среднее_время
FROM table_0
GROUP BY column_1