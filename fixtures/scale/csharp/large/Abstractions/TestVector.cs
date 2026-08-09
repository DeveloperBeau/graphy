namespace CipherLab.Abstractions
{
    public class TestVector
    {
        public string Plaintext { get; }
        public string Expected { get; }

        public TestVector(string plaintext, string expected)
        {
            Plaintext = plaintext;
            Expected = expected;
        }
    }
}
