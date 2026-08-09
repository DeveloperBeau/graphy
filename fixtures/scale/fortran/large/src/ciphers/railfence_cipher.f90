module railfence_cipher
  ! RailFence cipher: block transposition with period 6.
  implicit none
  integer, parameter :: railfence_perm(6) = [1, 3, 5, 2, 4, 6]
  integer, parameter :: railfence_inv(6) = [1, 4, 2, 5, 3, 6]

contains

  function railfence_apply(data, order) result(out)
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
  end function railfence_apply

  function railfence_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = railfence_apply(data, railfence_perm)
  end function railfence_encrypt

  function railfence_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = railfence_apply(data, railfence_inv)
  end function railfence_decrypt

end module railfence_cipher
