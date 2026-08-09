module tp_align
  implicit none

contains

  function pad_left(text, width) result(padded)
    character(len=*), intent(in) :: text
    integer, intent(in) :: width
    character(len=width) :: padded
    padded = repeat(" ", max(0, width - len_trim(text))) // trim(text)
  end function pad_left

  function center_text(text, width) result(centered)
    character(len=*), intent(in) :: text
    integer, intent(in) :: width
    character(len=width) :: centered
    integer :: lead
    lead = (width - len_trim(text)) / 2 + len_trim(text)
    centered = pad_left(text, lead)
  end function center_text

end module tp_align
