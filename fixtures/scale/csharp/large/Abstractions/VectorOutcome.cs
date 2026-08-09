namespace CipherLab.Abstractions
{
    public class VectorOutcome
    {
        public string Family { get; }
        public bool Passed { get; }
        public string Detail { get; }

        public VectorOutcome(string family, bool passed, string detail)
        {
            Family = family;
            Passed = passed;
            Detail = detail;
        }
    }
}
