/* array-backed LIFO stack with a fixed capacity */
#include "stack_ops.h"
#include <stdlib.h>

struct StackOpsStack *stack_ops_create(int capacity) {
    struct StackOpsStack *stack = malloc(sizeof(struct StackOpsStack));
    stack->data = malloc(sizeof(int) * (size_t)capacity);
    stack->top = -1;
    stack->capacity = capacity;
    return stack;
}

int stack_ops_push(struct StackOpsStack *stack, int value) {
    if (stack->top + 1 >= stack->capacity) {
        return 0;
    }
    stack->data[++stack->top] = value;
    return 1;
}

int stack_ops_pop(struct StackOpsStack *stack, int *out) {
    if (stack->top < 0) {
        return 0;
    }
    *out = stack->data[stack->top--];
    return 1;
}

int stack_ops_peek(struct StackOpsStack *stack) {
    return stack->top >= 0 ? stack->data[stack->top] : -1;
}

void stack_ops_destroy(struct StackOpsStack *stack) {
    free(stack->data);
    free(stack);
}
