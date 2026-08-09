namespace Calc.Lexing
{
    public class ScanCursor
    {
        private readonly string _source;
        private int _position;

        public ScanCursor(string source)
        {
            _source = source;
        }

        public bool AtEnd()
        {
            return _position >= _source.Length;
        }

        public char Peek()
        {
            return AtEnd() ? '\0' : _source[_position];
        }

        public char Advance()
        {
            return _source[_position++];
        }
    }
}
