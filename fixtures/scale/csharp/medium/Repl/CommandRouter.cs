namespace Calc.Repl
{
    public static class CommandRouter
    {
        public static string Dispatch(string line, ReplContext context)
        {
            var parts = line.TrimStart(':').Split(' ');
            switch (parts[0])
            {
                case "help":
                    return HelpCommand.Run(context, parts);
                case "vars":
                    return VarsCommand.Run(context, parts);
                case "history":
                    return HistoryCommand.Run(context, parts);
                case "precision":
                    return PrecisionCommand.Run(context, parts);
                case "angle":
                    return AngleCommand.Run(context, parts);
                case "quit":
                    return QuitCommand.Run(context, parts);
                default:
                    return "unknown command :" + parts[0];
            }
        }
    }
}
