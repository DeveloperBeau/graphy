module fnv1a_runner
  ! Benchmark runner for the fnv1a cipher.
  use fnv1a_cipher
  use fnv1a_keys
  implicit none

contains

  function fnv1a_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = fnv1a_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function fnv1a_run_bench

end module fnv1a_runner
