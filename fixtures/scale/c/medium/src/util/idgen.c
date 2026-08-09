/* monotonically increasing ids for each record kind */
#include "idgen.h"

static int idgen_student_counter = 1;
static int idgen_course_counter = 1;
static int idgen_enrollment_counter = 1;

int idgen_next_student_id(void) {
    return idgen_student_counter++;
}

int idgen_next_course_id(void) {
    return idgen_course_counter++;
}

int idgen_next_enrollment_id(void) {
    return idgen_enrollment_counter++;
}
