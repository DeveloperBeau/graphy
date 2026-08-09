using System;

namespace Calc.Eval
{
    public class EvalError : Exception
    {
        public string Subject { get; }

        public EvalError(string message, string subject) : base(message)
        {
            Subject = subject;
        }

        public string Pretty()
        {
            return Message + ": " + Subject;
        }
    }
}
