module sum32_runner
  ! Benchmark runner for the sum32 cipher.
  use sum32_cipher
  use sum32_keys
  implicit none

contains

  function sum32_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = sum32_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function sum32_run_bench

end module sum32_runner
