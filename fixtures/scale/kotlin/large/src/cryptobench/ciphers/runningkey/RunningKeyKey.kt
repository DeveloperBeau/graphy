package cryptobench.ciphers.runningkey

data class RunningKeyKey(val stream: String) {

    fun keyCharAt(position: Int): Char = stream[position % stream.length]

    companion object {
        private const val PASSAGE =
            "ITWASABRIGHTCOLDDAYINAPRILANDTHECLOCKSWERESTRIKINGTHIRTEEN"

        fun default(): RunningKeyKey = RunningKeyKey(PASSAGE)
    }
}
