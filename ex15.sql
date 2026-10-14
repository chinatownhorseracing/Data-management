SELECT
    module_lecturers.module_id,
    room_lecturers.building,
    room_lecturers.room
FROM
    exam_results
    JOIN module_lecturers ON exam_results.module_id = module_lecturers.module_id
    JOIN room_lecturers ON module_lecturers.lecturer_email = room_lecturers.lecturer_email
    JOIN rooms ON room_lecturers.building = rooms.building
    AND room_lecturers.room = rooms.room
GROUP BY
    module_lecturers.module_id,
    room_lecturers.building,
    room_lecturers.room
HAVING
    COUNT(DISTINCT exam_results.student_id) > rooms.capacity;
