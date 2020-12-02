program main
	use m_type
	implicit none
	
	type(mes) :: a
	character(len=9) :: choix
	
	! Récupère les arguments
	if (iargc()==0) then
		choix = "classique"
	else
		call getarg(1, choix)
	end if
	call recup_donnee(a)
	allocate(a%X(a%N))
	call maillage(a)
	allocate(a%C(a%N,a%Nt))
	call C_init(a,choix)
	call concentration(a,choix)
	if (choix == "debug2") then
		allocate(a%db2(a%N))
		call debug2(a)
	end if
	call ecriture(a)
	call ecriture_csv(a,choix)
	if (allocated(a%db2)) then
		deallocate(a%X,a%C,a%db2)
	else
		deallocate(a%X,a%C)
	end if
end program main
