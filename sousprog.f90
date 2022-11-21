subroutine read_data (phys)
use m_type
    implicit none
    type(phys_type), intent(inout) :: phys
    integer :: i, j
    open (unit=10, file="donnees.dat")
    read(10,*) phys%L
    read(10,*) phys%D
    read(10,*) phys%C0
    read(10,*) phys%xd
    read(10,*) phys%xf
    close (10)
end subroutine read_data