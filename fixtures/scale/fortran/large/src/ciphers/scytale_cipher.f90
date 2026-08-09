module scytale_cipher
  ! Scytale cipher: block transposition with period 6.
  implicit none
  integer, parameter :: scytale_perm(6) = [1, 4, 2, 5, 3, 6]
  integer, parameter :: scytale_inv(6) = [1, 3, 5, 2, 4, 6]

contains

  function scytale_apply(data, order) result(out)
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
  end function scytale_apply

  function scytale_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = scytale_apply(data, scytale_perm)
  end function scytale_encrypt

  function scytale_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = scytale_apply(data, scytale_inv)
  end function scytale_decrypt

end module scytale_cipher
