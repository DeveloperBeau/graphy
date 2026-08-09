module rotblocks_runner
  ! Benchmark runner for the rotblocks cipher.
  use rotblocks_cipher
  use rotblocks_keys
  implicit none

contains

  function rotblocks_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = rotblocks_encrypt(sample)
    end do
    outlen = size(out)
  end function rotblocks_run_bench

end module rotblocks_runner
