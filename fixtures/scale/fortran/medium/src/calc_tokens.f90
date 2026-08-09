module calc_tokens
  implicit none

  type :: token_t
    character(len=4) :: kind
    character(len=16) :: text
  end type token_t

contains

  function token_make(kind_name, text) result(tok)
    character(len=*), intent(in) :: kind_name, text
    type(token_t) :: tok
    tok%kind = kind_name
    tok%text = text
  end function token_make

end module calc_tokens
