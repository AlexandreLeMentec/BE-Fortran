program pollution
use m_type
implicit none 
    type(phys_type):: phys
    type(num_type):: num
    real, dimension(:,:), allocatable:: C 
    real, dimension(:), allocatable:: mesh
    call read_data (phys,num)
    allocate(C(phys%N,phys%Nt))
    allocate(mesh(phys%N))
    call regular_mesh (phys,num,mesh)
    call conc_init (phys,num,mesh,C)
    call conc_calc (phys,num,mesh,C)
    call display (phys,num,mesh,C)
end program pollution