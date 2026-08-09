namespace CipherLab.Abstractions
{
    // Implemented once per cipher family under Families/<Name>/<Name>Cipher.cs.
    public interface ICipher
    {
        // Short identifier used for reporting and registry lookups.
        string Name { get; }

        // Transforms plaintext into the family's ciphertext representation.
        string Encode(string plaintext);

        // Reverses Encode; not required to be lossless for hash families.
        string Decode(string ciphertext);
    }
}
