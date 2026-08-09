module cbcxor_cipher
  ! CbcXor cipher: xor chained against the previous cipher byte.
  implicit none
  integer, parameter :: cbcxor_iv = 113

contains

  function cbcxor_keystream(cipher) result(ks)
    integer, intent(in) :: cipher(:)
    integer :: ks(size(cipher))
    ks(1) = cbcxor_iv
    if (size(cipher) > 1) ks(2:) = cipher(1:size(cipher) - 1)
  end function cbcxor_keystream

  function cbcxor_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i, prev
    prev = cbcxor_iv
    do i = 1, size(data)
      out(i) = ieor(data(i), prev)
      prev = out(i)
    end do
  end function cbcxor_encrypt

  function cbcxor_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, cbcxor_keystream(data))
  end function cbcxor_decrypt

end module cbcxor_cipher
