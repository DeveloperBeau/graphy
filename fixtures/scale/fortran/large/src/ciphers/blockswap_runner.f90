module blockswap_runner
  ! Benchmark runner for the blockswap cipher.
  use blockswap_cipher
  use blockswap_keys
  implicit none

contains

  function blockswap_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = blockswap_encrypt(sample)
    end do
    outlen = size(out)
  end function blockswap_run_bench

end module blockswap_runner
