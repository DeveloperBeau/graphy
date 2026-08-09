module tp_version
  implicit none
  character(len=*), parameter :: version_string = "1.2.0"

contains

  function textprint_version() result(v)
    character(len=len(version_string)) :: v
    v = version_string
  end function textprint_version

  function build_info() result(info)
    character(len=32) :: info
    info = "textprint " // version_string
  end function build_info

end module tp_version
