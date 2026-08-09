using System;
using Calc.Eval;
using Calc.Output;
using Calc.Parsing;

namespace Calc.Repl
{
    public class Repl
    {
        private readonly ReplContext _context;
        private readonly InputReader _reader;

        public Repl(ReplContext context)
        {
            _context = context;
            _reader = new InputReader("calc> ");
        }

        public void Run()
        {
            var evaluator = new Evaluator(_context.Environment, _context.Functions);
            string line;
            while (_context.Settings.Running && (line = _reader.NextLine()) != null)
            {
                if (line.Trim().Length == 0) continue;
                if (line.StartsWith(":"))
                {
                    Console.WriteLine(CommandRouter.Dispatch(line, _context));
                    continue;
                }
                var node = new Parser(line).ParseStatement();
                var value = evaluator.Eval(node);
                _context.History.Append(line.Trim(), value);
                Console.WriteLine(ResultFormatter.FormatResult(value, _context.Settings));
            }
        }
    }
}
