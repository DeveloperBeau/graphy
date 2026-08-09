module blockswap_cipher
  ! BlockSwap cipher: block transposition with period 8.
  implicit none
  integer, parameter :: blockswap_perm(8) = [5, 6, 7, 8, 1, 2, 3, 4]
  integer, parameter :: blockswap_inv(8) = [5, 6, 7, 8, 1, 2, 3, 4]

contains

  function blockswap_apply(data, order) result(out)
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
  end function blockswap_apply

  function blockswap_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = blockswap_apply(data, blockswap_perm)
  end function blockswap_encrypt

  function blockswap_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = blockswap_apply(data, blockswap_inv)
  end function blockswap_decrypt

end module blockswap_cipher
