module addmod_runner
  ! Benchmark runner for the addmod cipher.
  use addmod_cipher
  use addmod_keys
  implicit none

contains

  function addmod_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = addmod_encrypt(sample)
    end do
    outlen = size(out)
  end function addmod_run_bench

end module addmod_runner
