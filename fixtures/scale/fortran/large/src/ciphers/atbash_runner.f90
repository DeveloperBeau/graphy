module atbash_runner
  ! Benchmark runner for the atbash cipher.
  use atbash_cipher
  use atbash_keys
  implicit none

contains

  function atbash_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = atbash_encrypt(sample)
    end do
    outlen = size(out)
  end function atbash_run_bench

end module atbash_runner
