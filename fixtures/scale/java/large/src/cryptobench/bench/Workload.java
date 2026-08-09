package cryptobench.bench;

import java.util.List;

import cryptobench.util.Rng;

/** Deterministic plaintext payloads used to size benchmark iterations. */
public class Workload {
    public static List<String> payloads(int count) {
        Rng rng = new Rng(0x5EEDL);
        java.util.ArrayList<String> out = new java.util.ArrayList<>();
        for (int i = 0; i < count; i++) {
            out.add(randomSentence(rng, 8 + (i % 24)));
        }
        return out;
    }

    static String randomSentence(Rng rng, int words) {
        StringBuilder sb = new StringBuilder();
        for (int w = 0; w < words; w++) {
            if (w > 0) sb.append(' ');
            int len = 3 + (int) (rng.nextLong() % 7 & 7);
            for (int c = 0; c < len; c++) {
                sb.append((char) ('A' + (int) (rng.nextLong() & 31) % 26));
            }
        }
        return sb.toString();
    }
}
