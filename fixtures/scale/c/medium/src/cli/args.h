#ifndef ARGS_H
#define ARGS_H

struct ParsedArgs {
    const char *command;
    const char *arg1;
    const char *arg2;
};

struct ParsedArgs args_parse(int argc, char **argv);

#endif
