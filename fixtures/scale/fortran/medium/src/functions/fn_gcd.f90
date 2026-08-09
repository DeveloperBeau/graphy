module fn_gcd
  ! Greatest common divisor (Euclid).
  implicit none

contains

  function calc_gcd(a, b) result(g)
    integer, intent(in) :: a, b
    integer :: g, x, y, t
    x = abs(a)
    y = abs(b)
    do while (y /= 0)
      t = mod(x, y)
      x = y
      y = t
    end do
    g = x
  end function calc_gcd

end module fn_gcd
