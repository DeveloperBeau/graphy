module quagmire_runner
  ! Benchmark runner for the quagmire cipher.
  use quagmire_cipher
  use quagmire_keys
  implicit none

contains

  function quagmire_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = quagmire_encrypt(sample)
    end do
    outlen = size(out)
  end function quagmire_run_bench

end module quagmire_runner
