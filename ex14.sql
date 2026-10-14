SELECT
    module_id,
    leader_firstname,
    leader_surname,
    faculty,
    average_mark
FROM
    (
        SELECT
            modules.module_id,
            lecturers.lecturer_firstname AS leader_firstname,
            lecturers.lecturer_surname AS leader_surname,
            lecturers.faculty,
            AVG(coursework_marks.mark) + AVG(exam_results.exam_mark) AS average_mark,
            ROW_NUMBER() OVER (
                PARTITION BY
                    lecturers.faculty
                ORDER BY
                    (
                        AVG(coursework_marks.mark) + AVG(exam_results.exam_mark)
                    ) DESC
            ) AS mark_rank_for_this_faculty
        FROM
            coursework_marks
            JOIN exam_results ON coursework_marks.module_id = exam_results.module_id
            JOIN modules ON exam_results.module_id = modules.module_id
            JOIN lecturers ON modules.leader = lecturers.lecturer_email
        GROUP BY
            exam_results.module_id
    )
WHERE
    mark_rank_for_this_faculty = 1;