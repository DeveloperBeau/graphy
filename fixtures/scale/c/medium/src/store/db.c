/* in-memory registry of every student and course in the system */
#include "db.h"
#include <stddef.h>

void db_init(struct GradeDb *db) {
    db->students = NULL;
    db->courses = NULL;
}

void db_add_student(struct GradeDb *db, struct Student *student) {
    student->next = db->students;
    db->students = student;
}

void db_add_course(struct GradeDb *db, struct Course *course) {
    course->next = db->courses;
    db->courses = course;
}

struct Student *db_find_student(struct GradeDb *db, int student_id) {
    struct Student *cur = db->students;
    while (cur != NULL) {
        if (cur->id == student_id) {
            return cur;
        }
        cur = cur->next;
    }
    return NULL;
}

struct Course *db_find_course(struct GradeDb *db, int course_id) {
    struct Course *cur = db->courses;
    while (cur != NULL) {
        if (cur->id == course_id) {
            return cur;
        }
        cur = cur->next;
    }
    return NULL;
}
