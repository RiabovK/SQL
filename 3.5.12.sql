WITH group_1 AS
(SELECT 'I' AS Группа, student_name AS Студент, COUNT(*) AS Количество_шагов
FROM (SELECT student_name, step_id, result,
      LAG(result) OVER (PARTITION BY student_name, step_id order by submission_time) AS result_after
      FROM student
           INNER JOIN step_student USING(student_id)
      ORDER BY student_name, step_id) AS I
WHERE (result, result_after) = ('wrong', 'correct')
GROUP BY student_name),

group_2 AS
(SELECT 'II' AS Группа,
       student_name AS Студент, 
       COUNT(Количество_шагов) AS Количество_шагов
FROM (SELECT student_name, step_id, COUNT(result) AS Количество_шагов
      FROM student
           INNER JOIN step_student USING(student_id)
      WHERE result = 'correct'
      GROUP BY student_name, step_id
      HAVING Количество_шагов > 1) AS II
GROUP BY student_name
ORDER BY Количество_шагов DESC),


group_031 AS
(SELECT student_name, step_id, COUNT(result) AS qwe
FROM student
     INNER JOIN step_student USING(student_id)
GROUP BY student_name, step_id
ORDER BY student_name, step_id),

group_032 AS
(SELECT student_name, step_id, COUNT(result) AS asd
FROM student
     INNER JOIN step_student USING(student_id)
WHERE result = 'wrong'
GROUP BY student_name, step_id
ORDER BY student_name, step_id),

group_3 AS 
(SELECT 'III' AS Группа, student_name AS Студент, COUNT(step_id) AS Количество_шагов
FROM group_031
     INNER JOIN group_032 USING(student_name, step_id)
WHERE qwe = asd
GROUP BY student_name)