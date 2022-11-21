program pollution
use m_type
implicit none 
    type(phys_type):: phys
    type(num_type):: num
    real, dimension(:), allocatable:: mesh
    real, dimension(:), allocatable :: C1, C2
    integer::j
    call read_data (phys,num)
    allocate(mesh(num%N))
    allocate(C1(num%N))
    allocate(C2(num%N))
    call regular_mesh (phys,num,mesh)
    call conc_init (phys,num,mesh,C1)
    call display(phys,num,mesh,C1)
    do j=2,num%Nt
        call conc_calc(phys,num,C1,C2,j)
        call display(phys,num,mesh,C2)
        C1(:) = C2(:)
    end do
    deallocate(C1)
    deallocate(C2)
    deallocate(mesh)
end program pollution