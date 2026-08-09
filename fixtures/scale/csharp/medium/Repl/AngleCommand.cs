using Calc.Eval;

namespace Calc.Repl
{
    public static class AngleCommand
    {
        public static string Run(ReplContext context, string[] parts)
        {
            if (parts.Length < 2)
            {
                return "angle mode is " + context.Settings.Angle;
            }
            context.Settings.Angle = parts[1] == "degrees" ? AngleMode.Degrees : AngleMode.Radians;
            return "angle mode set to " + context.Settings.Angle;
        }
    }
}
