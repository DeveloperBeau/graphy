module tp_banner
  use tp_align
  use tp_border
  use tp_log
  use tp_config
  implicit none

contains

  subroutine cmd_banner(text)
    character(len=*), intent(in) :: text
    integer :: width
    width = config_width()
    call log_info("rendering banner")
    call border_print(center_text(text, width), width)
  end subroutine cmd_banner

end module tp_banner
