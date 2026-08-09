module porta_cipher
  ! Porta cipher: repeating key "GLACIER" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: porta_key = "GLACIER"

contains

  function porta_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(porta_key)) + 1
    k = iachar(porta_key(pos:pos))
  end function porta_key_byte

  function porta_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(porta_key_byte(i) - data(i), 256)
    end do
  end function porta_encrypt

  function porta_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Subtraction against the key stream is its own inverse.
    out = porta_encrypt(data)
  end function porta_decrypt

end module porta_cipher
