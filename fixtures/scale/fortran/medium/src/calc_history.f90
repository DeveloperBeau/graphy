module calc_history
  implicit none
  integer, parameter :: history_max = 100
  character(len=144) :: entries(history_max)
  integer :: entry_count = 0

contains

  subroutine history_add(expr, value)
    character(len=*), intent(in) :: expr
    real(kind=8), intent(in) :: value
    if (entry_count >= history_max) return
    entry_count = entry_count + 1
    write(entries(entry_count), '(a,a,f0.6)') trim(expr), " = ", value
  end subroutine history_add

  subroutine history_show()
    integer :: i
    do i = 1, entry_count
      print *, trim(entries(i))
    end do
  end subroutine history_show

end module calc_history
