module interleave_cipher
  ! Interleave cipher: block transposition with period 8.
  implicit none
  integer, parameter :: interleave_perm(8) = [1, 3, 5, 7, 2, 4, 6, 8]
  integer, parameter :: interleave_inv(8) = [1, 5, 2, 6, 3, 7, 4, 8]

contains

  function interleave_apply(data, order) result(out)
    integer, intent(in) :: data(:), order(:)
    integer :: out(size(data))
    integer :: p, blk, base, j
    p = size(order)
    out = data
    do blk = 0, size(data) / p - 1
      base = blk * p
      do j = 1, p
        out(base + j) = data(base + order(j))
      end do
    end do
  end function interleave_apply

  function interleave_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = interleave_apply(data, interleave_perm)
  end function interleave_encrypt

  function interleave_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = interleave_apply(data, interleave_inv)
  end function interleave_decrypt

end module interleave_cipher
