namespace Calc.Lexing
{
    public class Token
    {
        public TokenKind Kind { get; }
        public string Text { get; }

        public Token(TokenKind kind, string text)
        {
            Kind = kind;
            Text = text;
        }

        public double NumberValue()
        {
            return double.Parse(Text, System.Globalization.CultureInfo.InvariantCulture);
        }
    }
}
