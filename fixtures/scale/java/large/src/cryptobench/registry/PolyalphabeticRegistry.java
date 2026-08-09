package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.ciphers.vigenere.VigenereSuite;
import cryptobench.ciphers.beaufort.BeaufortSuite;
import cryptobench.ciphers.variantbeaufort.VariantBeaufortSuite;
import cryptobench.ciphers.gronsfeld.GronsfeldSuite;
import cryptobench.ciphers.autokey.AutokeySuite;
import cryptobench.ciphers.runningkey.RunningKeySuite;
import cryptobench.ciphers.porta.PortaSuite;

public class PolyalphabeticRegistry {
    public static List<CipherSuite> suites() {
        List<CipherSuite> suites = new ArrayList<>();
        suites.add(new VigenereSuite());
        suites.add(new BeaufortSuite());
        suites.add(new VariantBeaufortSuite());
        suites.add(new GronsfeldSuite());
        suites.add(new AutokeySuite());
        suites.add(new RunningKeySuite());
        suites.add(new PortaSuite());
        return suites;
    }
}
