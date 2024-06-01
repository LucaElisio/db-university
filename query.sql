-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * 
FROM `students`
WHERE `date_of_birth` LIKE "1990-%"

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT *
FROM `courses`
WHERE `cfu` > 10

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * 
FROM `students` 
WHERE 2024 - YEAR(`date_of_birth`) > 30;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * 
FROM `courses`
WHERE `year` = 1
AND `period` = "I semestre"

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * 
FROM `exams`
WHERE `date` = '2020-06-20'
AND `hour` > '14:00:00';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT *
FROM `degrees`
WHERE `level` = "magistrale"

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT count(`id`) AS `departments`
FROM `departments`


-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT count(`id`) AS `teachers_number`
FROM `teachers`
WHERE `phone` IS NULL;


-- 9. Inserire nella tabella degli studenti un nuovo record con i propri dati (per il campo degree_id, inserire un valore casuale)
INSERT INTO `students` (`degree_id` ,`name`, `surname`, `date_of_birth`, `fiscal_code`, `enrolment_date`, `registration_number`, `email`)
VALUES (1, "Luca", "Elisio", "1999-08-29", "LSELCU99M29A345G", "2024-01-01", 01010101, "emaildiluca@gmail.com");


-- 10. Cambiare il numero dell’ufficio del professor Pietro Rizzo in 126
UPDATE `teachers`
SET `office_number` = 126
WHERE `teachers`.`name` = "Pietro"
AND `teachers`.`surname` = "Rizzo"



-- 11. Eliminare dalla tabella studenti il record creato precedentemente al punto 9
DELETE FROM `students`
WHERE `surname` = "Elisio";


------------------------------------------------------------------------
-- GROUP BY EXCERCISE

-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT YEAR(`students`.`enrolment_date`), COUNT(*) AS `num_of_students`
FROM `students`
GROUP BY YEAR(`students`.`enrolment_date`)

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT `teachers`.`office_address`, COUNT(*) AS `same_office`
FROM `teachers`
GROUP BY `teachers`.`office_address`

-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT `exam_student`.`exam_id`, AVG(`exam_student`.`vote`) AS `average_vote` 
FROM `exam_student` 
GROUP BY `exam_student`.`exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT `degrees`.`department_id` ,`degrees`.`name`, COUNT(*) AS `num_of_courses`
FROM `degrees` 
GROUP BY `degrees`.`department_id`



---------------------------------------------------------------------------
-- JOIN EXCERCISE

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT `students`.`id`, `students`.`name`, `students`.`surname`      
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia";

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT *
FROM `departments`
INNER JOIN `degrees`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `degrees`.`level`="magistrale"
AND `departments`.`name` = "dipartimento di neuroscienze";

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT *
FROM `teachers`
INNER JOIN `course_teacher`
ON `course_teacher`.`teacher_id` = `teacher`.`id`
INNER JOIN `courses`
ON `courses_teacher`.`course_id` = `course`.`id`
WHERE `teachers`.`id` = "44"

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT 	`students`.`surname` AS `Cognome`, `students`.`name` AS `Nome`, `degrees`.`name` AS `Corso di laurea`, `departments`.`name` AS `Dipartimento`
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`, `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT 	`teachers`.`name` AS `Nome`, `teachers`.`surname` As `Cognome`, `degrees`.`name` AS `Corso laurea`, `courses`.`name` AS `Corso`
FROM `teachers`
INNER JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses`
ON `course_teacher`.`course_id` = `courses`.`id`
INNER JOIN `degrees`
ON `courses`.`degree_id` = `degrees`.`id`

