using Calc.Output;

namespace Calc.Repl
{
    public static class HistoryCommand
    {
        public static string Run(ReplContext context, string[] parts)
        {
            var table = new TablePrinter("expression", "value");
            foreach (var entry in context.History.Recent(10))
            {
                table.Add(entry.Expression, NumberFormat.Format(entry.Value, context.Settings.Precision));
            }
            return table.Render();
        }
    }
}
