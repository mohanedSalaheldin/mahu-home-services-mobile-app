DROP TABLE IF EXISTS exam_result;
DROP TABLE IF EXISTS exam;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;

CREATE TABLE course (
    course_id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT
);

CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    email TEXT,
    password TEXT,
    fname TEXT,
    lname TEXT,
    dob DATE,
    phone TEXT,
    mobile TEXT,
    date_of_join DATE,
    status BOOLEAN,
    last_login_date DATE,
    last_login_ip TEXT
);

CREATE TABLE exam (
    exam_id INTEGER PRIMARY KEY,
    name TEXT,
    start_date DATE
);

CREATE TABLE exam_result (
    exam_id INTEGER,
    student_id INTEGER,
    course_id INTEGER,
    marks INTEGER,
    PRIMARY KEY (exam_id, student_id, course_id),
    FOREIGN KEY (exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

INSERT INTO student (student_id, email, password, fname, lname, dob, phone, mobile, date_of_join, status, last_login_date, last_login_ip) 
VALUES 
(1, 'yasser@gmail.com', 'yasserpass123', 'Yasser', 'Ahmed', '2000-04-22', '012334478', '091234478', '2018-11-01', TRUE, '2025-07-10', '192.168.1.1'),
(2, 'hager@gmail.com', 'hagerpass456', 'Hager', 'Khaled', '2001-12-13', '0111111133', '0991234555', '2018-11-02', TRUE, '2025-07-11', '192.168.1.2'),
(3, 'maryam@gmail.com', 'maryampass789', 'Maryam', 'Abobakr', '2001-05-01', '0122669933', '0122669932', '2018-11-03', TRUE, '2025-07-12', '192.168.1.3');

INSERT INTO course (course_id, name, description) 
VALUES 
(1, 'Mathematics', 'Advanced Mathematics'),
(2, 'Computer Fundamentals', 'Course covering computer components and history'),
(3, 'Human-Computer Interaction', 'Focuses on UI design, user experience, and related software');

INSERT INTO exam (exam_id, name, start_date) 
VALUES 
(1, 'Mathematics Final Exam', '2025-12-10'),
(2, 'Computer Fundamentals Midterm', '2025-12-15'),
(3, 'HCI Lab Exam', '2025-12-20');

INSERT INTO exam_result (exam_id, student_id, course_id, marks) 
VALUES 
(1, 1, 1, 95),
(2, 2, 2, 87),
(3, 3, 3, 91),
(2, 1, 2, 89),
(3, 1, 3, 85),
(1, 2, 1, 92),
(3, 2, 3, 88),
(1, 3, 1, 90),
(2, 3, 2, 76);