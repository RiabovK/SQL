WITH student_step(Модуль, Студент, Пройдено_шагов)  AS 

(SELECT module_id, student_name, COUNT(DISTINCT step_id) AS steps
FROM lesson
     INNER JOIN step USING(lesson_id)
     INNER JOIN step_student USING(step_id)
     INNER JOIN student USING(student_id)
WHERE result = 'correct'
GROUP BY module_id, student_name)


SELECT Модуль, 
       Студент, 
       Пройдено_шагов,
       ROUND(Пройдено_шагов * 100 / (MAX(Пройдено_шагов) OVER (PARTITION BY Модуль)), 1) AS Относительный_рейтинг
FROM student_step
ORDER BY Модуль, Относительный_рейтинг DESC, Студент