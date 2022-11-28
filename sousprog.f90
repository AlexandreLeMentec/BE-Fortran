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
    read(10,*)
    read(10,*)
    read(10,*) num%N
    read(10,*) num%Dt
    read(10,*) num%Nt
    close (10)
    num%dx = phys%L / (num%N - 1)
    num%R = phys%D * num%Dt / (num%dx*num%dx)
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
    do i = 1, num%N
        mesh(i) = (i - 1) * num%dx
    enddo
end subroutine regular_mesh

subroutine conc_init (phys,num,mesh,C1)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(in) :: mesh
    real, dimension(num%N), intent(out) :: C1
    real:: heaviside
    integer :: i
    do i = 1, num%N
        C1(i) = phys%C0 *(heaviside(mesh(i) - phys%xd) - heaviside(mesh(i) - phys%xf))
    enddo
end subroutine conc_init

subroutine conc_calc (phys,num,C1,C2,j)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(in) :: C1
    real, dimension(num%N), intent(inout) :: C2
    integer, intent(in) :: j
    real::func
    integer :: i
    C2(1) = func(j)
    C2(num%N) = 0.
    do i = 2, num%N-1
        C2(i) = num%R*C1(i-1) + (1 - 2*num%R)*C1(i) + num%R*C1(i+1)
    enddo
end subroutine conc_calc

function func (j)
    implicit none
    real:: func
    integer, intent(in) :: j
    func = 0.
end function func

subroutine display(phys,num,mesh,C2)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(in) :: mesh
    real, dimension(num%N), intent(in) :: C2
    integer :: i
    write(10,*) C2
end subroutine display

subroutine Cphysique (phys,num,mesh,Cth,j)
use m_type
    implicit none
    type(phys_type), intent(in) :: phys
    type(num_type), intent(in) :: num
    real, dimension(num%N), intent(in) :: mesh
    real, dimension(num%N), intent(inout) :: Cth
    integer, intent(in) :: j
    integer :: i
    real :: erf
    do i = 1, num%N
        write(*,*) "mesh(i) = ", mesh(i), "j = ", j, "num%dt = ", num%Dt, "phys%D", phys%D
        Cth(i) = phys%C0 * ( 1- erf(mesh(i)/(2*sqrt(phys%D*j*num%Dt)) ))
        write(*,*) mesh(i)/(2*sqrt(phys%D*j*num%Dt))
    enddo
    write(*,*) "Cth=",Cth
end subroutine Cphysique

function concentration (x, t, D)
    implicit none
    real:: concentration
    real, intent(in) :: x
    real, intent(in) :: t
    real, intent(in) :: D
    real :: erf
    concentration = 1 - erf(x/(2*sqrt(D*t)))
end function concentration