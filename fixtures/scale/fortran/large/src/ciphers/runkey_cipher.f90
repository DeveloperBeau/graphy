module runkey_cipher
  ! Runkey cipher: repeating key "THEQUICKBROWNFOX" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: runkey_key = "THEQUICKBROWNFOX"

contains

  function runkey_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(runkey_key)) + 1
    k = iachar(runkey_key(pos:pos))
  end function runkey_key_byte

  function runkey_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + runkey_key_byte(i), 256)
    end do
  end function runkey_encrypt

  function runkey_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - runkey_key_byte(i), 256)
    end do
  end function runkey_decrypt

end module runkey_cipher
