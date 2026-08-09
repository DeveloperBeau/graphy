module rotmix_runner
  ! Benchmark runner for the rotmix cipher.
  use rotmix_cipher
  use rotmix_keys
  implicit none

contains

  function rotmix_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = rotmix_encrypt(sample)
    end do
    outlen = size(out)
  end function rotmix_run_bench

end module rotmix_runner
