module quagmire_cipher
  ! Quagmire cipher: repeating key "OCEAN" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: quagmire_key = "OCEAN"

contains

  function quagmire_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(quagmire_key)) + 1
    k = iachar(quagmire_key(pos:pos))
  end function quagmire_key_byte

  function quagmire_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + quagmire_key_byte(i) + 11, 256)
    end do
  end function quagmire_encrypt

  function quagmire_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - quagmire_key_byte(i) - 11, 256)
    end do
  end function quagmire_decrypt

end module quagmire_cipher
