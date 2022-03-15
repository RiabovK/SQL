SET @sum_progr = (SELECT COUNT(DISTINCT(step_id)) FROM step_student);

SELECT student_name AS Студент, 
       ROUND(COUNT(DISTINCT(step_id))*100/@sum_progr, 0) AS Прогресс,
       CASE
          WHEN COUNT(DISTINCT(step_id))*100/@sum_progr = 100 THEN "Сертификат с отличием"
          WHEN COUNT(DISTINCT(step_id))*100/@sum_progr >= 80 THEN "Сертификат"
          ELSE ''
       END AS Результат 
FROM student
     INNER JOIN step_student USING(student_id)
WHERE result = 'correct'
GROUP BY student_name
ORDER BY Прогресс DESC, Студент;