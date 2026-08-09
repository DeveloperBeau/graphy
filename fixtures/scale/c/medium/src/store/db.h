#ifndef DB_H
#define DB_H

#include "../models/student.h"
#include "../models/course.h"

struct GradeDb {
    struct Student *students;
    struct Course *courses;
};

void db_init(struct GradeDb *db);
void db_add_student(struct GradeDb *db, struct Student *student);
void db_add_course(struct GradeDb *db, struct Course *course);
struct Student *db_find_student(struct GradeDb *db, int student_id);
struct Course *db_find_course(struct GradeDb *db, int course_id);

#endif
