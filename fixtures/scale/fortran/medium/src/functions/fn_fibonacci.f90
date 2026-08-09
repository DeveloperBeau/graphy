module fn_fibonacci
  ! Fibonacci number (iterative).
  implicit none

contains

  function calc_fibonacci(n) result(f)
    integer, intent(in) :: n
    integer :: f, a, b, t, i
    a = 0
    b = 1
    do i = 1, n
      t = a + b
      a = b
      b = t
    end do
    f = a
  end function calc_fibonacci

end module fn_fibonacci
