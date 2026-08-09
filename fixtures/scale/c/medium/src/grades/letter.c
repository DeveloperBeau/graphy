/* converts numeric percentages to letter grades and gpa points */
#include "letter.h"

char letter_from_percent(double percent) {
    if (percent >= 93.0) return 'A';
    if (percent >= 90.0) return 'a';
    if (percent >= 83.0) return 'B';
    if (percent >= 80.0) return 'b';
    if (percent >= 73.0) return 'C';
    if (percent >= 70.0) return 'c';
    if (percent >= 60.0) return 'D';
    return 'F';
}

double letter_to_gpa_points(char letter) {
    switch (letter) {
        case 'A': return 4.0;
        case 'a': return 3.7;
        case 'B': return 3.3;
        case 'b': return 3.0;
        case 'C': return 2.3;
        case 'c': return 2.0;
        case 'D': return 1.0;
        default: return 0.0;
    }
}
