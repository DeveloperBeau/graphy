package cryptobench.bench

import cryptobench.util.Rng

/** Deterministic plaintext payloads used to size benchmark iterations. */
class Workload {
    static List<String> payloads(int count) {
        Rng rng = new Rng(0x5EED)
        List<String> out = []
        for (int i = 0; i < count; i++) {
            out << randomSentence(rng, 8 + (i % 24))
        }
        return out
    }

    static String randomSentence(Rng rng, int words) {
        StringBuilder sb = new StringBuilder()
        for (int w = 0; w < words; w++) {
            if (w > 0) sb.append(' ')
            int len = 3 + rng.nextInt(7)
            for (int c = 0; c < len; c++) sb.append(('A' as char) + rng.nextInt(26) as char)
        }
        return sb.toString()
    }
}
