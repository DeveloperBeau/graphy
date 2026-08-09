module bench_verify
  use bench_corpus
  use bench_log
  use verifiers_shift
  use verifiers_vigenere
  use verifiers_stream
  use verifiers_transposition
  use verifiers_hash
  implicit none

contains

  subroutine verify_all()
    integer :: sample(64)
    integer :: failures
    sample = corpus_sample(64)
    failures = 0
    call verify_shift_family(sample, failures)
    call verify_vigenere_family(sample, failures)
    call verify_stream_family(sample, failures)
    call verify_transposition_family(sample, failures)
    call verify_hash_family(sample, failures)
    if (failures > 0) then
      call log_warn("round-trip failures detected")
    else
      call log_info("all ciphers verified")
    end if
  end subroutine verify_all

end module bench_verify
