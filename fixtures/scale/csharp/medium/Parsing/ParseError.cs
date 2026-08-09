using System;

namespace Calc.Parsing
{
    public class ParseError : Exception
    {
        public string Fragment { get; }

        public ParseError(string message, string fragment) : base(message)
        {
            Fragment = fragment;
        }

        public string Pretty()
        {
            return Message + " near '" + Fragment + "'";
        }
    }
}
