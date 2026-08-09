module railfence_runner
  ! Benchmark runner for the railfence cipher.
  use railfence_cipher
  use railfence_keys
  implicit none

contains

  function railfence_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = railfence_encrypt(sample)
    end do
    outlen = size(out)
  end function railfence_run_bench

end module railfence_runner
