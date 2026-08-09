package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.ciphers.playfair.PlayfairSuite;
import cryptobench.ciphers.twosquare.TwoSquareSuite;
import cryptobench.ciphers.foursquare.FourSquareSuite;
import cryptobench.ciphers.hill.HillSuite;
import cryptobench.ciphers.bifid.BifidSuite;
import cryptobench.ciphers.adfgvx.AdfgvxSuite;

public class DigraphRegistry {
    public static List<CipherSuite> suites() {
        List<CipherSuite> suites = new ArrayList<>();
        suites.add(new PlayfairSuite());
        suites.add(new TwoSquareSuite());
        suites.add(new FourSquareSuite());
        suites.add(new HillSuite());
        suites.add(new BifidSuite());
        suites.add(new AdfgvxSuite());
        return suites;
    }
}
