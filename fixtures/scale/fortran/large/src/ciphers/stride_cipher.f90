module stride_cipher
  ! Stride cipher: block transposition with period 9.
  implicit none
  integer, parameter :: stride_perm(9) = [1, 4, 7, 2, 5, 8, 3, 6, 9]
  integer, parameter :: stride_inv(9) = [1, 4, 7, 2, 5, 8, 3, 6, 9]

contains

  function stride_apply(data, order) result(out)
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
  end function stride_apply

  function stride_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = stride_apply(data, stride_perm)
  end function stride_encrypt

  function stride_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = stride_apply(data, stride_inv)
  end function stride_decrypt

end module stride_cipher
