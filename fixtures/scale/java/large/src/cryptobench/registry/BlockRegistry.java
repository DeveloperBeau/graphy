package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.ciphers.feistel.FeistelSuite;
import cryptobench.ciphers.tea.TeaSuite;
import cryptobench.ciphers.xtea.XteaSuite;
import cryptobench.ciphers.speck.SpeckSuite;
import cryptobench.ciphers.simon.SimonSuite;
import cryptobench.ciphers.ecb.EcbModeSuite;
import cryptobench.ciphers.cbc.CbcModeSuite;
import cryptobench.ciphers.ctr.CtrModeSuite;

public class BlockRegistry {
    public static List<CipherSuite> suites() {
        List<CipherSuite> suites = new ArrayList<>();
        suites.add(new FeistelSuite());
        suites.add(new TeaSuite());
        suites.add(new XteaSuite());
        suites.add(new SpeckSuite());
        suites.add(new SimonSuite());
        suites.add(new EcbModeSuite());
        suites.add(new CbcModeSuite());
        suites.add(new CtrModeSuite());
        return suites;
    }
}
