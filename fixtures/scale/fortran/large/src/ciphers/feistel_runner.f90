module feistel_runner
  ! Benchmark runner for the feistel cipher.
  use feistel_cipher
  use feistel_keys
  implicit none

contains

  function feistel_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = feistel_encrypt(sample)
    end do
    outlen = size(out)
  end function feistel_run_bench

end module feistel_runner
