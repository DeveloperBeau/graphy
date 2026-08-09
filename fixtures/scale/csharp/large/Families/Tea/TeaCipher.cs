using System;
using System.Text;
using CipherLab.Abstractions;

namespace CipherLab.Families.Tea
{
    public class TeaCipher : ICipher
    {
        private const int Rounds = 1;

        public string Name => "tea";

        public string Encode(string plaintext)
        {
            var sb = new StringBuilder();
            var bytes = Encoding.UTF8.GetBytes(plaintext);
            for (var i = 0; i < bytes.Length; i++)
            {
                var rotated = ((bytes[i] << Rounds) | (bytes[i] >> (8 - Rounds))) & 0xFF;
                sb.Append(rotated.ToString("x2"));
            }
            return sb.ToString();
        }

        public string Decode(string ciphertext)
        {
            var sb = new StringBuilder();
            for (var i = 0; i < ciphertext.Length; i += 2)
            {
                var value = Convert.ToInt32(ciphertext.Substring(i, 2), 16);
                var back = ((value >> Rounds) | (value << (8 - Rounds))) & 0xFF;
                sb.Append((char)back);
            }
            return sb.ToString();
        }
    }
}
