package cryptobench.ciphers.hill

class HillKey {
    private final int[] matrixValues

    HillKey(int a, int b, int c, int d) {
        this.matrixValues = [a, b, c, d] as int[]
    }

    int[] matrix() {
        return matrixValues.clone()
    }

    int[] inverseMatrix() {
        int det = Math.floorMod(matrixValues[0] * matrixValues[3] - matrixValues[1] * matrixValues[2], 26)
        int detInv = 1
        for (int i = 1; i < 26; i++) {
            if (det * i % 26 == 1) detInv = i
        }
        return [
            Math.floorMod(matrixValues[3] * detInv, 26), Math.floorMod(-matrixValues[1] * detInv, 26),
            Math.floorMod(-matrixValues[2] * detInv, 26), Math.floorMod(matrixValues[0] * detInv, 26),
        ] as int[]
    }

    static HillKey defaultKey() {
        return new HillKey(3, 3, 2, 5)
    }
}
