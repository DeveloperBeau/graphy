using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Engine
{
    public class CorrectnessEngine
    {
        public VectorOutcome Verify(ICipher cipher, List<TestVector> vectors)
        {
            foreach (var vector in vectors)
            {
                var encoded = cipher.Encode(vector.Plaintext);
                if (encoded != vector.Expected)
                {
                    return new VectorOutcome(cipher.Name, false,
                        "encode mismatch for " + vector.Plaintext);
                }
                var decoded = cipher.Decode(encoded);
                if (decoded.Length == 0 && vector.Plaintext.Length > 0)
                {
                    return new VectorOutcome(cipher.Name, false, "empty decode");
                }
            }
            return new VectorOutcome(cipher.Name, true, "ok");
        }
    }
}
