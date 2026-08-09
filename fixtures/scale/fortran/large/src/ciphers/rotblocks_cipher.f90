module rotblocks_cipher
  ! RotBlocks cipher: block transposition with period 6.
  implicit none
  integer, parameter :: rotblocks_perm(6) = [3, 4, 5, 6, 1, 2]
  integer, parameter :: rotblocks_inv(6) = [5, 6, 1, 2, 3, 4]

contains

  function rotblocks_apply(data, order) result(out)
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
  end function rotblocks_apply

  function rotblocks_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = rotblocks_apply(data, rotblocks_perm)
  end function rotblocks_encrypt

  function rotblocks_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = rotblocks_apply(data, rotblocks_inv)
  end function rotblocks_decrypt

end module rotblocks_cipher
