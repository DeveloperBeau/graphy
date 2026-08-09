using System;
using Calc.Repl;

namespace Calc
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine(Version.Banner());
            var settings = Settings.Interactive();
            var context = new ReplContext(settings);
            new Repl(context).Run();
        }
    }
}
