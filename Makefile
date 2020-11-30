FC = gfortran
OPT = -g -O0 -fbounds-check 

OBJ = m_type.o prog.o sous_prog.o

prog.exe :	$(OBJ)
	$(FC) $(OPT) $(OBJ) -o prog.exe

m_type.o :	m_type.f90
	$(FC) $(OPT) m_type.f90 -c

prog.o :	prog.f90
	$(FC) $(OPT) prog.f90 -c

sous_prog.o :	sous_prog.f90
	$(FC) $(OPT) sous_prog.f90 -c

clean :
	/bin/rm -f $(OBJ) *.mod *.exe *.txt ./img/*

