using System;
using System.Text;

namespace TextPrint.Util
{
    public static class InputReader
    {
        public static string ReadAll()
        {
            var sb = new StringBuilder();
            string line;
            while ((line = Console.In.ReadLine()) != null)
            {
                if (sb.Length > 0)
                {
                    sb.Append(' ');
                }
                sb.Append(line.Trim());
            }
            return sb.ToString();
        }
    }
}
