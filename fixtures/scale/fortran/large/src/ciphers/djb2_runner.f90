module djb2_runner
  ! Benchmark runner for the djb2 cipher.
  use djb2_cipher
  use djb2_keys
  implicit none

contains

  function djb2_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = djb2_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function djb2_run_bench

end module djb2_runner
