package cryptobench.ciphers.gronsfeld

class GronsfeldKey {
    final String digits
    GronsfeldKey(String digits) {
        this.digits = digits
    }

    int digitAt(int position) {
        return digits.charAt(position % digits.length()) - ('0' as char)
    }

    static GronsfeldKey defaultKey() {
        return new GronsfeldKey("31415")
    }
}
