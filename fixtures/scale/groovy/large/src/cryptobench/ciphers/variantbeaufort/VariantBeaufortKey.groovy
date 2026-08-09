package cryptobench.ciphers.variantbeaufort

class VariantBeaufortKey {
    final String keyword
    VariantBeaufortKey(String keyword) {
        this.keyword = keyword.toUpperCase()
    }

    char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length())
    }

    static VariantBeaufortKey defaultKey() {
        return new VariantBeaufortKey("COBALT")
    }
}
