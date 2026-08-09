module tp_config
  implicit none
  integer, parameter :: default_width = 72

contains

  function config_width() result(width)
    integer :: width
    character(len=8) :: override
    call get_environment_variable("TEXTPRINT_WIDTH", override)
    if (len_trim(override) > 0) then
      read(override, *) width
    else
      width = default_width
    end if
  end function config_width

  function config_style() result(style)
    character(len=8) :: style
    style = "plain"
  end function config_style

end module tp_config
