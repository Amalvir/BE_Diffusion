program main
	use m_type
	implicit none
	
	type(mes) :: a
	
	call recup_donnee(a)
	allocate(a%X(a%N))
	call maillage(a)
	allocate(a%C(a%N,a%Nt))
	allocate(a%C2(a%N,a%Nt))
	call C_init(a)
	call concentration(a)
	!call ecriture(a)
	call validation(a)
	call ecriture2(a)
	deallocate(a%X,a%C,a%C2)
end program main
