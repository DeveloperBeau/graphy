module keymix_cipher
  ! Keymix cipher: repeating key "ZEBRA" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: keymix_key = "ZEBRA"

contains

  function keymix_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(keymix_key)) + 1
    k = iachar(keymix_key(pos:pos))
  end function keymix_key_byte

  function keymix_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + keymix_key_byte(i) + 7, 256)
    end do
  end function keymix_encrypt

  function keymix_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - keymix_key_byte(i) - 7, 256)
    end do
  end function keymix_decrypt

end module keymix_cipher
