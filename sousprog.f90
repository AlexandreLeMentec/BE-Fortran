subroutine read_data (phys,num)
use m_type
    implicit none
    type(num_type), intent(inout) :: num
    type(phys_type), intent(inout) :: phys
    integer :: i, j
    open (unit=10, file="donnees.dat")
    read(10,*)
    read(10,*) phys%L
    read(10,*) phys%D
    read(10,*) phys%C0
    read(10,*) phys%xd
    read(10,*) phys%xf
    write(*,*) "donner le nombre de discrétisation spatial N"
    read(*,*) num%N
    write(*,*) "donner le pas du temps Dt"
    read(*,*) num%Dt
    write(*,*) "donner la discrétisation temporelle Nt"
    read(*,*) num%Nt
    close (10)
end subroutine read_data

function heaviside (x)
    implicit none
    real:: heaviside
    real, intent(in) :: x
    if (x < 0.) then
        heaviside = 0.
    else
        heaviside = 1.
    endif
end function heaviside

subroutine regular_mesh (phys,num,mesh)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(out) :: mesh
    integer :: i, j
    real :: dx
    dx = phys%L / (num%N - 1)
    do i = 1, num%N
        mesh(i) = phys%xd + (i - 1) * dx
    enddo
end subroutine regular_mesh

subroutine conc_init (phys,num,mesh,C)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(in) :: mesh
    real, dimension(num%N,num%Nt), intent(out) :: C
    real:: heaviside
    integer :: i
    do i = 1, num%N
        C(i,1) = phys%C0 *(heaviside(mesh(i) - phys%xd) - heaviside(mesh(i) - phys%xf))
    enddo
end subroutine conc_init

subroutine conc_calc_temp (phys,num,C1,C2)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(in) :: C1
    real, dimension(num%N), intent(out) :: C2
    integer :: i
    real :: R,dx
    dx = phys%L / (num%N - 1)
    R = phys%D * num%Dt / (dx*dx)
    do i = 2, num%N-1
        C2(i) = R*C1(i-1) + (1-2*R)*C1(i) + R*C1(i+1)
    enddo
end subroutine conc_calc_temp

subroutine conc_calc(phys,num,C)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N,num%Nt), intent(inout) :: C
    real, dimension(num%N) :: C1, C2
    real::func
    integer :: j
    do j = 2, num%Nt-1
        C1(:) = C(:,j)
        call conc_calc_temp(phys,num,C1,C2)
        C(:,j+1) = C2(:)
    enddo
    do j =  2, num%Nt
        C(1,j) = func(j)
        C(num%N,j) = 0.
    enddo
end subroutine conc_calc

function func (j)
    implicit none
    real:: func
    integer, intent(in) :: j
    func = 0.
end function func

subroutine display(phys,num,mesh,C)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(in) :: mesh
    real, dimension(num%N,num%Nt), intent(in) :: C
    integer :: i, j
    open (unit=10, file="resultat.dat")
    do j = 1, num%Nt
        write(10,*)(mesh(i), C(i,j), i = 1, num%N)
    enddo
    close (10)
end subroutine display