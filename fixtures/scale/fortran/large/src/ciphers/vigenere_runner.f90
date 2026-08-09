module vigenere_runner
  ! Benchmark runner for the vigenere cipher.
  use vigenere_cipher
  use vigenere_keys
  implicit none

contains

  function vigenere_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = vigenere_encrypt(sample)
    end do
    outlen = size(out)
  end function vigenere_run_bench

end module vigenere_runner
