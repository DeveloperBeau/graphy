module gronsfeld_cipher
  ! Gronsfeld cipher: repeating key "31415" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: gronsfeld_key = "31415"

contains

  function gronsfeld_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(gronsfeld_key)) + 1
    k = iachar(gronsfeld_key(pos:pos))
  end function gronsfeld_key_byte

  function gronsfeld_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + gronsfeld_key_byte(i), 256)
    end do
  end function gronsfeld_encrypt

  function gronsfeld_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - gronsfeld_key_byte(i), 256)
    end do
  end function gronsfeld_decrypt

end module gronsfeld_cipher
