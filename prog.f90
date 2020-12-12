program main
	use m_type
	implicit none
	
	type(mes) :: a
	integer :: i
	real :: delta_x
	call recup_donnee(a)
	open(11,file="res.csv")
	do i=10,1000,10
		a%N=i
		delta_x=a%L/a%N
		allocate(a%X(a%N))
		call maillage(a)
		allocate(a%C(a%N,a%Nt))
		allocate(a%C2(a%N,a%Nt))
		call C_init(a)
		call concentration(a)
	!call ecriture(a)
		call validation(a)
		!call ecriture2(a)
		write(11,*) delta_x/a%L, sum(maxval(abs(a%C-a%C2),1))/real(a%Nt), a%D*a%tf/(a%Nt*delta_x**2)
		deallocate(a%X,a%C,a%C2)
	end do
	close(11)
end program main
