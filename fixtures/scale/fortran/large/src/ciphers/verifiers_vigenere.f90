module verifiers_vigenere
  ! Round-trip verification driver for the vigenere family.
  use vigenere_check
  use beaufort_check
  use autokey_check
  use gronsfeld_check
  use porta_check
  use runkey_check
  use keymix_check
  use trithemius_check
  use quagmire_check
  implicit none

contains

  subroutine verify_vigenere_family(sample, failures)
    integer, intent(in) :: sample(:)
    integer, intent(inout) :: failures
    if (.not. vigenere_verify(sample)) failures = failures + 1
    if (.not. beaufort_verify(sample)) failures = failures + 1
    if (.not. autokey_verify(sample)) failures = failures + 1
    if (.not. gronsfeld_verify(sample)) failures = failures + 1
    if (.not. porta_verify(sample)) failures = failures + 1
    if (.not. runkey_verify(sample)) failures = failures + 1
    if (.not. keymix_verify(sample)) failures = failures + 1
    if (.not. trithemius_verify(sample)) failures = failures + 1
    if (.not. quagmire_verify(sample)) failures = failures + 1
  end subroutine verify_vigenere_family

end module verifiers_vigenere
