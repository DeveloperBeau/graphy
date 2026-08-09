module beaufort_cipher
  ! Beaufort cipher: repeating key "FORTRESS" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: beaufort_key = "FORTRESS"

contains

  function beaufort_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(beaufort_key)) + 1
    k = iachar(beaufort_key(pos:pos))
  end function beaufort_key_byte

  function beaufort_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(beaufort_key_byte(i) - data(i), 256)
    end do
  end function beaufort_encrypt

  function beaufort_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Subtraction against the key stream is its own inverse.
    out = beaufort_encrypt(data)
  end function beaufort_decrypt

end module beaufort_cipher
