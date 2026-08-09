using System.Text;
using CipherLab.Abstractions;

namespace CipherLab.Families.Djb2
{
    public class Djb2Cipher : ICipher
    {
        private const uint Seed = 2166136261u;
        private const uint Prime = 16777619u;

        public string Name => "djb2";

        public string Encode(string plaintext)
        {
            uint acc = Seed;
            foreach (var b in Encoding.UTF8.GetBytes(plaintext))
            {
                acc = (acc ^ b) * Prime;
            }
            return acc.ToString("x8");
        }

        public string Decode(string ciphertext)
        {
            return "digest:" + ciphertext;
        }
    }
}
