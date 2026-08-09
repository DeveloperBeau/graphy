using Calc.Eval;
using Calc.Functions;
using Calc.Memory;

namespace Calc.Repl
{
    public class ReplContext
    {
        public Environment Environment { get; }
        public FunctionRegistry Functions { get; }
        public HistoryLog History { get; }
        public MemoryStore Memory { get; }
        public Settings Settings { get; }

        public ReplContext(Settings settings)
        {
            Environment = new Environment();
            Functions = StandardLibrary.BuildRegistry();
            History = new HistoryLog();
            Memory = new MemoryStore();
            Settings = settings;
        }
    }
}
