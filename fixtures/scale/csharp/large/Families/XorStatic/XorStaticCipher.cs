using System;
using System.Text;
using CipherLab.Abstractions;

namespace CipherLab.Families.XorStatic
{
    public class XorStaticCipher : ICipher
    {
        private const int Mask = 5;

        public string Name => "xorstatic";

        public string Encode(string plaintext)
        {
            var sb = new StringBuilder();
            var bytes = Encoding.UTF8.GetBytes(plaintext);
            for (var i = 0; i < bytes.Length; i++)
            {
                sb.Append(((bytes[i] ^ (Mask + i)) & 0xFF).ToString("x2"));
            }
            return sb.ToString();
        }

        public string Decode(string ciphertext)
        {
            var sb = new StringBuilder();
            for (var i = 0; i < ciphertext.Length; i += 2)
            {
                var value = Convert.ToInt32(ciphertext.Substring(i, 2), 16);
                sb.Append((char)((value ^ (Mask + i / 2)) & 0xFF));
            }
            return sb.ToString();
        }
    }
}
