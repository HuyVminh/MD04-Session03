create table class(
class_id int not null primary key auto_increment,
class_name varchar(60) not null,
start_date datetime not null,
status bit(1)
);

create table student(
student_id int not null primary key auto_increment,
student_name varchar(30) not null,
address varchar(50),
phone varchar(20),
status bit(1),
class_id int not null,
foreign key(class_id)references class(class_id)
);

create table subject(
sub_id int not null primary key auto_increment,
sub_name varchar(30),
credit tinyint not null default(1)  check(credit>=1),
status bit(1) default(1)
);
drop table mark;
create table mark(
mark_id int not null primary key auto_increment,
sub_id int not null,
foreign key(sub_id)references subject(sub_id),
student_id int not null unique key,
foreign key(student_id) references student(student_id),
mark float default(0) check (mark between 0 and 100),
exam_time tinyint default(1)
);

INSERT INTO class (class_name, start_date, status)
VALUES
  ('Math 101', '2023-11-15 08:00:00', 1),
  ('English 201', '2023-11-16 10:00:00', 1),
  ('Physical 401', '2023-11-12 08:00:00', 1),
  ('Science 301', '2023-11-17 13:00:00', 1);
INSERT INTO student (student_name, address, phone, status, class_id)
VALUES
  ('John Doe', '123 Main St', '(123) 456-7890', 1, 1),
  ('Jane Smith', '456 Oak Ave', '(555) 555-1212', 1, 1),
  ('Bob Johnson', '789 Maple Dr', '(555) 123-4567', 1, 2),
  ('Marry Doen', '123 Main St', '(123) 456-7890', 1, 3),
  ('Jane Bone', '456 Oak Ave', '(555) 555-1212', 1, 4),
  ('Glen Johnson', '789 Maple Dr', '(555) 123-4567', 1, 4);

INSERT INTO subject (sub_name, credit, status)
VALUES
  ('Math', 6, 1),
  ('English', 4, 1),
  ('Science', 7, 1),
  ('Physical', 3, 1);
  
INSERT INTO mark (sub_id, student_id, mark, exam_time)
VALUES
  (1, 1, 80, 1),
  (2, 2, 90, 1),
  (3, 3, 80, 1),
  (4, 4, 90, 1),
  (1, 5, 80, 1),
  (2, 6, 75, 1);

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT * from student where student_name like '%h%';
-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 11
SELECT * from class where month(start_date) = 11;
-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5
select * from subject where credit >= 3 and credit <= 5;
-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Jane Bone’ là 2
update student set class_id = 2 where student_name = 'Jane Bone';
-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm
select s.student_name,b.sub_name,m.mark
from mark m
join student s
on m.student_id=s.student_id
join subject b
on b.sub_id=m.sub_id
order by m.mark desc;