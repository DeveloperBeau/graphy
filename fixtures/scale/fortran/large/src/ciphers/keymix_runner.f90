module keymix_runner
  ! Benchmark runner for the keymix cipher.
  use keymix_cipher
  use keymix_keys
  implicit none

contains

  function keymix_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = keymix_encrypt(sample)
    end do
    outlen = size(out)
  end function keymix_run_bench

end module keymix_runner
