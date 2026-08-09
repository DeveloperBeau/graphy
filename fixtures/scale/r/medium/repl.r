# Interactive read-eval-print loop.

repl_prompt <- function() {
  cat("calc> ")
  readLines(file("stdin"), n = 1)
}

repl_loop <- function() {
  repeat {
    line <- repl_prompt()
    if (length(line) == 0 || identical(line, "quit")) {
      break
    }
    result <- tryCatch(eval_expr(line), error = function(e) {
      err_set(conditionMessage(e))
      NULL
    })
    if (!is.null(result)) {
      history_add(line, result)
      cat(fmt_result(result), "\n")
    }
  }
}
