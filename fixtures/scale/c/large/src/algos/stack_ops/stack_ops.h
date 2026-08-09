#ifndef ALGOS_STACK_OPS_H
#define ALGOS_STACK_OPS_H

struct StackOpsStack {
    int *data;
    int top;
    int capacity;
};

struct StackOpsStack *stack_ops_create(int capacity);
int stack_ops_push(struct StackOpsStack *stack, int value);
int stack_ops_pop(struct StackOpsStack *stack, int *out);
int stack_ops_peek(struct StackOpsStack *stack);
void stack_ops_destroy(struct StackOpsStack *stack);
int stack_ops_verify(void);
double stack_ops_bench(void);

#endif
