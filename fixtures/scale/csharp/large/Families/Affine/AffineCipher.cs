using System;
using CipherLab.Abstractions;

namespace CipherLab.Families.Affine
{
    public class AffineCipher : ICipher
    {
        private const int Shift = 6;
        private const int Step = 1;

        public string Name => "affine";

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
