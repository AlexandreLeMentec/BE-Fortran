program pollution
use m_type
implicit none 
    type(phys_type):: phys
    type(num_type):: num
    real, dimension(:), allocatable:: mesh
    real, dimension(:), allocatable :: C1, C2, Cth
    integer::j
    call read_data (phys,num)                        ! Récupération des données
    allocate(mesh(num%N))
    allocate(C1(num%N))
    allocate(C2(num%N))
    allocate(Cth(num%N))
    call regular_mesh (phys,num,mesh)
    call conc_init (phys,num,mesh,C1)
    open (unit=10, file="resultat.dat")
    call display(phys,num,mesh)                     ! Affichage en ligne de la concentration à l'instant initial en tout point x 
    do j=2,num%Nt                                   ! Boucle pour faire varier le temps avec un pas dt
        call conc_calc(phys,num,C1,C2,j)            ! Calcul de la concentration C(x,t) notée dans C2 en fonction de C(x,t-dt) notée dans C1
        call Cphysique(phys,num,mesh,Cth,j)         ! Calcul la solution analytique Cth(x,t)
        call display(phys,num,C2)                   ! Affichage en ligne de la concentration C(x,t) en tout point x à l'instant t
        call display(phys,num,Cth)                  ! Affichage en ligne de la solution analytique Cth(x,t) en tout point x à l'instant t
        C1(:)=C2(:)                                 ! C1 prend la valeur de C1 pour poursuivre la boucle au temps suivant
    enddo
    close (10)
    deallocate(C1)
    deallocate(C2)
    deallocate(mesh)
    deallocate(Cth)
end program pollution