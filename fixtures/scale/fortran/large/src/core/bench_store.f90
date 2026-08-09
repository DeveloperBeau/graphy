module bench_store
  implicit none
  character(len=*), parameter :: results_path = "results.csv"

contains

  subroutine store_init()
    integer :: unit
    open(newunit=unit, file=results_path, status="replace", action="write")
    close(unit)
  end subroutine store_init

  subroutine store_append(row)
    character(len=*), intent(in) :: row
    integer :: unit
    open(newunit=unit, file=results_path, status="old", position="append", action="write")
    write(unit, '(a)') trim(row)
    close(unit)
  end subroutine store_append

end module bench_store
