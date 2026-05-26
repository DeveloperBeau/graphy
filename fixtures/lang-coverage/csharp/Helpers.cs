// feature: static class, static methods, called cross-file
using System;
using S = System.String;

namespace Graphy
{
    public static class Helpers
    {
        public static string FormatName(string name)
        {
            return "hi, " + name.Trim();
        }

        public static int UnrelatedHelper()
        {
            return 7;
        }
    }
}
