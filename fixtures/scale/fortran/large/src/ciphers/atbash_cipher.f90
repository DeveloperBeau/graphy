module atbash_cipher
  ! Atbash cipher: mirror each byte across the range.
  implicit none

contains

  function atbash_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = 255 - data
  end function atbash_encrypt

  function atbash_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = 255 - data
  end function atbash_decrypt

end module atbash_cipher
