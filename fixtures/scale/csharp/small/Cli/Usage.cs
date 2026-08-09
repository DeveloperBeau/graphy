using System;

namespace TextPrint.Cli
{
    public static class Usage
    {
        public static string Text()
        {
            return string.Join(Environment.NewLine,
                "textprint [options] < input.txt",
                "  --width N       wrap width (default 60)",
                "  --align MODE    left | center | right",
                "  --border STYLE  single | double | ascii | none",
                "  --theme NAME    plain | bright | mono",
                "  --help          show this help");
        }

        public static void Print()
        {
            Console.WriteLine(Text());
        }
    }
}
