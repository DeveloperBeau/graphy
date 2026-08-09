using System;
using TextPrint.Cli;
using TextPrint.Render;
using TextPrint.Util;

namespace TextPrint
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var options = ArgParser.Parse(args);
            if (options.ShowHelp)
            {
                Usage.Print();
                return;
            }
            var text = InputReader.ReadAll();
            var renderer = new Renderer(options);
            Console.WriteLine(renderer.Render(text));
        }
    }
}
