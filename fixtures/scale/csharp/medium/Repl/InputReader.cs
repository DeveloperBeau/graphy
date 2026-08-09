using System;

namespace Calc.Repl
{
    public class InputReader
    {
        private readonly string _prompt;

        public InputReader(string prompt)
        {
            _prompt = prompt;
        }

        public string NextLine()
        {
            Console.Write(_prompt);
            return Console.In.ReadLine();
        }
    }
}
