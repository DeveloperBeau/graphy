import Foundation

struct BenchmarkEngine {
    func sample(_ cipher: Cipher, _ vectors: [TestVector], _ iterations: Int) -> BenchSample {
        let start = DispatchTime.now()
        for _ in 0..<iterations {
            for vector in vectors {
                _ = cipher.encode(vector.plaintext)
            }
        }
        let elapsed = DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds
        return BenchSample(family: cipher.name, nanoseconds: Int(elapsed), iterations: iterations * vectors.count)
    }
}
