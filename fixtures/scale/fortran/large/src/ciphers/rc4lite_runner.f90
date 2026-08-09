module rc4lite_runner
  ! Benchmark runner for the rc4lite cipher.
  use rc4lite_cipher
  use rc4lite_keys
  implicit none

contains

  function rc4lite_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = rc4lite_encrypt(sample)
    end do
    outlen = size(out)
  end function rc4lite_run_bench

end module rc4lite_runner
