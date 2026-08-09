module revblocks_runner
  ! Benchmark runner for the revblocks cipher.
  use revblocks_cipher
  use revblocks_keys
  implicit none

contains

  function revblocks_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = revblocks_encrypt(sample)
    end do
    outlen = size(out)
  end function revblocks_run_bench

end module revblocks_runner
