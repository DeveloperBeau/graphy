module bench_corpus
  implicit none
  character(len=*), parameter :: corpus_base = &
    "the quick brown fox jumps over the lazy dog 0123456789 "

contains

  function corpus_sample(n) result(sample)
    integer, intent(in) :: n
    integer :: sample(n)
    integer :: i, pos
    do i = 1, n
      pos = mod(i - 1, len(corpus_base)) + 1
      sample(i) = iachar(corpus_base(pos:pos))
    end do
  end function corpus_sample

end module bench_corpus
