SELECT
    students.student_id,
    students.student_firstname,
    students.student_lastname,
    AVG(exam_results.exam_mark) AS avg_exam_mark
FROM
    students
    JOIN exam_results ON students.student_id = exam_results.student_id
    JOIN modules ON exam_results.module_id = modules.module_id
WHERE
    modules.module_id LIKE 'COMP%'
    AND students.year = 1
GROUP BY
    students.student_id
ORDER BY
    avg_exam_mark DESC
LIMIT
    5;