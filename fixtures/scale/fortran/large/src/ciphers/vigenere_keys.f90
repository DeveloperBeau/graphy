module vigenere_keys
  ! Key material helpers for the vigenere cipher.
  implicit none

contains

  function vigenere_default_key() result(k)
    character(len=5) :: k
    k = "LEMON"
  end function vigenere_default_key

  function vigenere_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function vigenere_key_valid

end module vigenere_keys
