let eval_line env line = Evaluator.eval env (Parser.parse (Scanner.scan line))

let step env line history =
  let value = eval_line env line in
  (Output.format_number value, Log.record line value history)
