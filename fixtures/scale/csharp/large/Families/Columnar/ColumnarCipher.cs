using System;
using CipherLab.Abstractions;

namespace CipherLab.Families.Columnar
{
    public class ColumnarCipher : ICipher
    {
        private const int Shift = 9;
        private const int Step = 2;

        public string Name => "columnar";

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
