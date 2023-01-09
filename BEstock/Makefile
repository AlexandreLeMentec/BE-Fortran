FC = gfortran
OPT = -g -O0 -fbounds-check

OBJ = m_type.o Main.o sousprog.o

Main.exe :	$(OBJ)
	$(FC) $(OPT) $(OBJ) -o Main.exe

m_type.o :	m_type.f90
	$(FC) $(OPT) m_type.f90 -c

Main.o :	Main.f90
	$(FC) $(OPT) Main.f90 -c

sousprog.o :	sousprog.f90
	$(FC) $(OPT) sousprog.f90 -c

clean :
	/bin/rm -f $(OBJ) *.mod *.exe

