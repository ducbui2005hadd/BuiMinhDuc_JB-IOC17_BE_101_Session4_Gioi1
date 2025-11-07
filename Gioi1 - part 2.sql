CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    major VARCHAR(50),
    gpa DECIMAL(3, 2)
);

CREATE TABLE scholarships (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id),
    name VARCHAR(50),
    amount DECIMAL(10, 2),
    year INT
);

INSERT INTO students (name, age, major, gpa) VALUES
('An', 20, 'CNTT', 3.5),
('Bình', 21, 'Toán', 3.2),
('Cường', 22, 'CNTT', 3.8),
('Dương', 20, 'Vật lý', 3.0),
('Em', 21, 'CNTT', 2.9);

INSERT INTO scholarships (student_id, name, amount, year) VALUES
(1, 'Học bổng xuất sắc', 1000, 2025), 
(3, 'Học bổng xuất sắc', 1200, 2025), 
(2, 'Học bổng khuyến khích', 500, 2025), 
(4, 'Học bổng khuyến khích', 400, 2025); 

INSERT INTO scholarships (student_id, name, amount, year)
VALUES (5, 'Học bổng khuyến khích', 450, 2025);

UPDATE students
SET gpa = 4.0
WHERE id IN (
    SELECT student_id 
    FROM scholarships 
    WHERE name = 'Học bổng xuất sắc'
);

DELETE FROM scholarships
WHERE student_id IN (
    SELECT id 
    FROM students 
    WHERE gpa < 3.0
);

SELECT s.name AS ten_sinh_vien, s.major AS chuyen_nganh, sc.name AS ten_hoc_bong, sc.amount AS so_tien
FROM students s
JOIN scholarships sc ON s.id = sc.student_id
WHERE sc.year = 2025
ORDER BY sc.amount DESC;

SELECT s.name AS ten_sinh_vien,
COUNT(sc.id) AS so_luong_hoc_bong
FROM students s
JOIN scholarships sc ON s.id = sc.student_id
GROUP BY s.id, s.name 
HAVING 
    COUNT(sc.id) > 1;

SELECT 
    s.name AS ten_sinh_vien,
    sc.name AS ten_hoc_bong,
    sc.amount AS so_tien
FROM 
    students s
JOIN 
    scholarships sc ON s.id = sc.student_id
WHERE 
    s.name ILIKE 'C%' 
    AND sc.amount > 1000;

SELECT *
FROM students
ORDER BY gpa DESC
LIMIT 2;

SELECT *
FROM students
ORDER BY gpa DESC
LIMIT 2 OFFSET 1; 

