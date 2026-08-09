module zigzag_cipher
  ! ZigZag cipher: block transposition with period 2.
  implicit none
  integer, parameter :: zigzag_perm(2) = [2, 1]
  integer, parameter :: zigzag_inv(2) = [2, 1]

contains

  function zigzag_apply(data, order) result(out)
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
  end function zigzag_apply

  function zigzag_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = zigzag_apply(data, zigzag_perm)
  end function zigzag_encrypt

  function zigzag_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = zigzag_apply(data, zigzag_inv)
  end function zigzag_decrypt

end module zigzag_cipher
