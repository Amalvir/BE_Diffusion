program main
	use m_type
	implicit none
	
	type(mes) :: a
	character(len=9) :: choix
	integer :: i
	real :: delta_x
	
	! Récupère les arguments
	if (iargc()==0) then
		choix = "classique"
	else
		call getarg(1, choix)
	end if
	call recup_donnee(a)
	if (.not.(choix=="debug3")) then
		allocate(a%X(a%N))
		call maillage(a)
		allocate(a%C(a%N,a%Nt))
		call C_init(a,choix)
		call concentration(a,choix)
		if (choix == "debug2") then
			allocate(a%db2(a%N))
			call debug2(a)
		end if
		call ecriture_csv(a,choix)
		if (allocated(a%db2)) then
			deallocate(a%X,a%C,a%db2)
		else
			deallocate(a%X,a%C)
		end if
	else
		open(11,file="res.csv")
		do i=10,1000,10
			a%N=i
			delta_x=a%L/a%N
			allocate(a%X(a%N))
			call maillage(a)
			allocate(a%C(a%N,a%Nt))
			allocate(a%C2(a%N,a%Nt))
			call C_init(a,choix)
			call concentration(a,choix)
		!call ecriture(a)
			call validation(a)
			!call ecriture2(a)
			write(11,*) delta_x/a%L, sum(maxval(abs(a%C-a%C2),1))/real(a%Nt), a%D*a%tf/(a%Nt*delta_x**2)
			deallocate(a%X,a%C,a%C2)
		end do
		close(11)
	end if
end program main
