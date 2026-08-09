module rotmix_cipher
  ! Rotmix cipher: position-salted shift of +3.
  implicit none

contains

  function rotmix_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + 3 + i - 1, 256)
    end do
  end function rotmix_encrypt

  function rotmix_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - 3 - (i - 1), 256)
    end do
  end function rotmix_decrypt

end module rotmix_cipher
