package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.ciphers.caesar.CaesarSuite;
import cryptobench.ciphers.rot13.Rot13Suite;
import cryptobench.ciphers.atbash.AtbashSuite;
import cryptobench.ciphers.affine.AffineSuite;
import cryptobench.ciphers.keywordsub.KeywordSubSuite;
import cryptobench.ciphers.polybius.PolybiusSuite;

public class ClassicalRegistry {
    public static List<CipherSuite> suites() {
        List<CipherSuite> suites = new ArrayList<>();
        suites.add(new CaesarSuite());
        suites.add(new Rot13Suite());
        suites.add(new AtbashSuite());
        suites.add(new AffineSuite());
        suites.add(new KeywordSubSuite());
        suites.add(new PolybiusSuite());
        return suites;
    }
}
