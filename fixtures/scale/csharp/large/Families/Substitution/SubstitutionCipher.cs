using System;
using CipherLab.Abstractions;

namespace CipherLab.Families.Substitution
{
    public class SubstitutionCipher : ICipher
    {
        private const int Shift = 6;
        private const int Step = 2;

        public string Name => "substitution";

        public string Encode(string plaintext)
        {
            var chars = plaintext.ToCharArray();
            for (var i = 0; i < chars.Length; i++)
            {
                if (char.IsUpper(chars[i]))
                {
                    chars[i] = (char)('A' + (chars[i] - 'A' + Shift + i * Step) % 26);
                }
            }
            return new string(chars);
        }

        public string Decode(string ciphertext)
        {
            var chars = ciphertext.ToCharArray();
            for (var i = 0; i < chars.Length; i++)
            {
                if (char.IsUpper(chars[i]))
                {
                    chars[i] = (char)('A' + (chars[i] - 'A' - Shift - i * Step + 260) % 26);
                }
            }
            return new string(chars);
        }
    }
}
