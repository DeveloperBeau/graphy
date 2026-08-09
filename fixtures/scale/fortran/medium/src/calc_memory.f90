module calc_memory
  implicit none
  real(kind=8) :: memory_slot = 0.0d0

contains

  subroutine mem_store(value)
    real(kind=8), intent(in) :: value
    memory_slot = value
  end subroutine mem_store

  function mem_recall() result(value)
    real(kind=8) :: value
    value = memory_slot
  end function mem_recall

  subroutine mem_clear()
    memory_slot = 0.0d0
  end subroutine mem_clear

end module calc_memory
