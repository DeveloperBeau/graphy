/* top-level orchestrator: fans out to each category's registry, then
   prints the combined pass/fail summary for the whole benchmark suite */
#include "registry.h"
#include "registry_sorting.h"
#include "registry_searching.h"
#include "registry_hashing.h"
#include "registry_linkedlist.h"
#include "registry_misc.h"
#include "../core/report.h"

int registry_run_all(void) {
    int total = 0;
    int passed = 0;
    registry_run_sorting(&total, &passed);
    registry_run_searching(&total, &passed);
    registry_run_hashing(&total, &passed);
    registry_run_linkedlist(&total, &passed);
    registry_run_misc(&total, &passed);
    report_summary(total, passed);
    return passed == total ? 0 : 1;
}
