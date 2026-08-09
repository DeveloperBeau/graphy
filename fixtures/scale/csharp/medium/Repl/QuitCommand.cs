namespace Calc.Repl
{
    public static class QuitCommand
    {
        public static string Run(ReplContext context, string[] parts)
        {
            context.Settings.Running = false;
            return "bye (" + context.History.Count() + " calculations this session)";
        }
    }
}
