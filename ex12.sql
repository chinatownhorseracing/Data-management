CREATE TABLE
    students (
        student_id TEXT PRIMARY KEY,
        student_firstname TEXT,
        student_lastname TEXT,
        student_email TEXT,
        year INTEGER,
        address TEXT,
        contact_number TEXT
    );

INSERT INTO
    students (
        student_id,
        student_firstname,
        student_lastname,
        student_email,
        year,
        address,
        contact_number
    )
SELECT DISTINCT
    student_id,
    student_firstname,
    student_surname,
    student_email,
    year,
    address,
    contact_number
FROM
    studentscsv;

CREATE TABLE
    modules (
        module_id TEXT PRIMARY KEY,
        module_name TEXT,
        leader TEXT
    );

INSERT INTO
    modules (module_id, module_name, leader)
SELECT DISTINCT
    module_id,
    module_name,
    leader
FROM
    studentscsv;

CREATE TABLE
    exam_results (
        student_id TEXT,
        module_id TEXT,
        exam_mark REAL,
        PRIMARY KEY (student_id, module_id),
        FOREIGN KEY (student_id) REFERENCES students (student_id),
        FOREIGN KEY (module_id) REFERENCES modules (module_id)
    );

INSERT INTO
    exam_results (student_id, module_id, exam_mark)
SELECT
    student_id,
    module_id,
    exam_mark
FROM
    studentscsv
WHERE
    exam_mark IS NOT NULL
    and exam_mark != '';

CREATE TABLE
    module_lecturers (
        module_id TEXT,
        lecturer_email TEXT,
        PRIMARY KEY (module_id, lecturer_email),
        FOREIGN KEY (module_id) REFERENCES modules (module_id),
        FOREIGN KEY (lecturer_email) REFERENCES lecturers (lecturer_email)
    );

INSERT INTO
    module_lecturers (module_id, lecturer_email)
SELECT DISTINCT
    module_id,
    lecturer1
FROM
    studentscsv
WHERE
    lecturer1 IS NOT NULL
    AND lecturer1 != ''
    AND lecturer1 != leader;

INSERT INTO
    module_lecturers (module_id, lecturer_email)
SELECT DISTINCT
    module_id,
    lecturer2
FROM
    studentscsv
WHERE
    lecturer2 IS NOT NULL
    AND lecturer2 != ''
    AND lecturer2 != leader;

CREATE TABLE
    coursework_marks (
        student_id TEXT,
        module_id TEXT,
        coursework_number INTEGER,
        mark REAL,
        PRIMARY KEY (student_id, module_id, coursework_number),
        FOREIGN KEY (student_id) REFERENCES students (student_id),
        FOREIGN KEY (module_id) REFERENCES modules (module_id)
    );

INSERT INTO
    coursework_marks (student_id, module_id, coursework_number, mark)
SELECT
    student_id,
    module_id,
    1,
    coursework1
FROM
    studentscsv
WHERE
    coursework1 IS NOT NULL
    AND coursework1 != '';

INSERT INTO
    coursework_marks (student_id, module_id, coursework_number, mark)
SELECT
    student_id,
    module_id,
    2,
    coursework2
FROM
    studentscsv
WHERE
    coursework2 IS NOT NULL
    AND coursework2 != '';

INSERT INTO
    coursework_marks (student_id, module_id, coursework_number, mark)
SELECT
    student_id,
    module_id,
    3,
    coursework3
FROM
    studentscsv
WHERE
    coursework3 IS NOT NULL
    AND coursework3 != '';

CREATE TABLE
    lecturers (
        lecturer_email TEXT PRIMARY KEY,
        lecturer_firstname TEXT,
        lecturer_surname TEXT,
        faculty TEXT
    );

INSERT INTO
    lecturers (
        lecturer_email,
        lecturer_firstname,
        lecturer_surname,
        faculty
    )
SELECT DISTINCT
    lecturer_email,
    lecturer_firstname,
    lecturer_surname,
    faculty
FROM
    facultiescsv;

CREATE TABLE
    rooms (
        building TEXT,
        room TEXT,
        capacity INTEGER,
        PRIMARY KEY (building, room)
    );

INSERT INTO
    rooms (building, room, capacity)
SELECT DISTINCT
    building,
    room,
    capacity
FROM
    facultiescsv;

CREATE TABLE
    room_lecturers (
        building TEXT,
        room TEXT,
        lecturer_email TEXT,
        PRIMARY KEY (building, room, lecturer_email),
        FOREIGN KEY (building, room) REFERENCES rooms (building, room),
        FOREIGN KEY (lecturer_email) REFERENCES lecturers (lecturer_email)
    );

INSERT INTO
    room_lecturers (building, room, lecturer_email)
SELECT DISTINCT
    building,
    room,
    lecturer_email
FROM
    facultiescsv;