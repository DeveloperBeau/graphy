module bench_run
  use bench_args
  use bench_corpus
  use bench_store
  use bench_csv
  use bench_timer
  use bench_progress
  use bench_summary
  use drivers_shift
  use drivers_vigenere
  use drivers_stream
  use drivers_transposition
  use drivers_hash
  implicit none

contains

  subroutine bench_all()
    integer :: sample(512)
    integer :: total, t0
    sample = corpus_sample(512)
    call store_init()
    call store_append(csv_header())
    call progress_start(5)
    total = 0
    t0 = timer_start()
    call run_shift_family(sample, bench_rounds, total)
    call run_vigenere_family(sample, bench_rounds, total)
    call run_stream_family(sample, bench_rounds, total)
    call run_transposition_family(sample, bench_rounds, total)
    call run_hash_family(sample, bench_rounds, total)
    call store_append(csv_row("all", total, timer_elapsed_micros(t0)))
    call progress_finish()
    call summary_print()
  end subroutine bench_all

end module bench_run
