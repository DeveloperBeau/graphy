module revblocks_cipher
  ! RevBlocks cipher: block transposition with period 4.
  implicit none
  integer, parameter :: revblocks_perm(4) = [4, 3, 2, 1]
  integer, parameter :: revblocks_inv(4) = [4, 3, 2, 1]

contains

  function revblocks_apply(data, order) result(out)
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
  end function revblocks_apply

  function revblocks_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = revblocks_apply(data, revblocks_perm)
  end function revblocks_encrypt

  function revblocks_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = revblocks_apply(data, revblocks_inv)
  end function revblocks_decrypt

end module revblocks_cipher
