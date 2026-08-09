using Calc.Output;

namespace Calc.Repl
{
    public static class VarsCommand
    {
        public static string Run(ReplContext context, string[] parts)
        {
            var table = new TablePrinter("name", "value");
            foreach (var name in context.Environment.Names())
            {
                var value = context.Environment.Resolve(name);
                table.Add(name, NumberFormat.Format(value, context.Settings.Precision));
            }
            return table.Render();
        }
    }
}
