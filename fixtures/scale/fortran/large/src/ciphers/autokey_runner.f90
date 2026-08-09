module autokey_runner
  ! Benchmark runner for the autokey cipher.
  use autokey_cipher
  use autokey_keys
  implicit none

contains

  function autokey_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = autokey_encrypt(sample)
    end do
    outlen = size(out)
  end function autokey_run_bench

end module autokey_runner
