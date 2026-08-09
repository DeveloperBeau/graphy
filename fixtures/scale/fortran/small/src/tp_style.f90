module tp_style
  implicit none

contains

  function style_bold(text) result(styled)
    character(len=*), intent(in) :: text
    character(len=len(text) + 8) :: styled
    styled = char(27) // "[1m" // text // char(27) // "[0m"
  end function style_bold

  function apply_style(style, text) result(styled)
    character(len=*), intent(in) :: style, text
    character(len=len(text) + 8) :: styled
    if (trim(style) == "bold") then
      styled = style_bold(text)
    else
      styled = text
    end if
  end function apply_style

end module tp_style
