package cryptobench.util

class Hex {
    private static final String DIGITS = "0123456789abcdef"

    static String encode(byte[] data) {
        StringBuilder sb = new StringBuilder(data.length * 2)
        data.each { b ->
            sb.append(DIGITS[(b >> 4) & 0xF]).append(DIGITS[b & 0xF])
        }
        return sb.toString()
    }

    static byte[] decode(String hex) {
        byte[] out = new byte[hex.length().intdiv(2)]
        for (int i = 0; i < out.length; i++) {
            out[i] = Integer.parseInt(hex.substring(i * 2, i * 2 + 2), 16) as byte
        }
        return out
    }
}
