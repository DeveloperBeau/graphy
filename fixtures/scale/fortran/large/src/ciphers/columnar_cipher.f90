module columnar_cipher
  ! Columnar cipher: block transposition with period 4.
  implicit none
  integer, parameter :: columnar_perm(4) = [4, 2, 1, 3]
  integer, parameter :: columnar_inv(4) = [3, 2, 4, 1]

contains

  function columnar_apply(data, order) result(out)
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
  end function columnar_apply

  function columnar_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = columnar_apply(data, columnar_perm)
  end function columnar_encrypt

  function columnar_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = columnar_apply(data, columnar_inv)
  end function columnar_decrypt

end module columnar_cipher
