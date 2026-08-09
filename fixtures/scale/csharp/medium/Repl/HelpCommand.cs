namespace Calc.Repl
{
    public static class HelpCommand
    {
        public static string Run(ReplContext context, string[] parts)
        {
            var names = string.Join(", ", context.Functions.Names());
            return string.Join("\n",
                "commands: :help :vars :history :precision N :angle MODE :quit",
                "functions: " + names,
                "assign with  name = expression");
        }
    }
}
