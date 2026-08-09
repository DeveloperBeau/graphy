using System.Collections.Generic;

namespace CipherLab.Abstractions
{
    public interface IFamilyDescriptor
    {
        string Family { get; }
        string Suite { get; }
        CipherKind Kind { get; }
        ICipher Cipher();
        List<TestVector> Vectors();
    }
}
