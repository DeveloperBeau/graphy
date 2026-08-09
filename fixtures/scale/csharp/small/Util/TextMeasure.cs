namespace TextPrint.Util
{
    public static class TextMeasure
    {
        public static int VisibleLength(string line)
        {
            var length = 0;
            var inEscape = false;
            foreach (var ch in line)
            {
                if (ch == '\u001b')
                {
                    inEscape = true;
                }
                else if (inEscape && ch == 'm')
                {
                    inEscape = false;
                }
                else if (!inEscape)
                {
                    length++;
                }
            }
            return length;
        }
    }
}
