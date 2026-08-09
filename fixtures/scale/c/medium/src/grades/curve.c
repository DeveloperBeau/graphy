/* optional post-processing curves applied to a raw percentage */
#include "curve.h"

double curve_flat_bonus(double percent, double bonus_points) {
    double curved = percent + bonus_points;
    return curved > 100.0 ? 100.0 : curved;
}

double curve_scale_to_max(double percent, double class_max) {
    if (class_max <= 0.0) {
        return percent;
    }
    double scaled = (percent / class_max) * 100.0;
    return scaled > 100.0 ? 100.0 : scaled;
}
