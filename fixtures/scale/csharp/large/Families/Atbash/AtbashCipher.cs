using System;
using CipherLab.Abstractions;

namespace CipherLab.Families.Atbash
{
    public class AtbashCipher : ICipher
    {
        private const int Shift = 5;
        private const int Step = 3;

        public string Name => "atbash";

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
