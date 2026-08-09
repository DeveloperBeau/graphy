package cryptobench.ciphers.hill;

public class HillKey {
    private final int[] matrix;

    public HillKey(int a, int b, int c, int d) {
        this.matrix = new int[] { a, b, c, d };
    }

    public int[] matrix() {
        return matrix.clone();
    }

    public int[] inverseMatrix() {
        int det = Math.floorMod(matrix[0] * matrix[3] - matrix[1] * matrix[2], 26);
        int detInv = 1;
        for (int i = 1; i < 26; i++) {
            if (det * i % 26 == 1) detInv = i;
        }
        return new int[] {
            Math.floorMod(matrix[3] * detInv, 26), Math.floorMod(-matrix[1] * detInv, 26),
            Math.floorMod(-matrix[2] * detInv, 26), Math.floorMod(matrix[0] * detInv, 26),
        };
    }

    public static HillKey defaultKey() {
        return new HillKey(3, 3, 2, 5);
    }
}
