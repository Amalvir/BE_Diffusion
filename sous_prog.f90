subroutine recup_donnee(a)
	use mes
	implicit none

	type(mes),intent(out) :: a
	
	open(10,file="donnee.dat")

	read(10,*) a%C0
	read(10,*) a%L
	read(10,*) a%D
	read(10,*) a%xd
	read(10,*) a%xf
	read(10,*) a%N
	read(10,*) a%Nt
	read(10,*) a%tf
	
	close(10)
end subroutine recup_donnee
	
subroutine maillage(a)
	use mes
	implicit none
	
	type(mes), intent(inout) :: a
	integer :: i
	
	do i=1,N
		a%X(i)=a%N/a%L*(i-1)
	end do
end subroutine maillage

subroutine C_init(a)
	use mes
	implicit none

	type(mes),intent(inout) :: a
	integer :: H,i

	do i=1,N
		a%C(i,1)=a%C0*(H(a%X(i)-a%xd) - H(a%X(i)-a%xf)) 
	end do
end subroutine C_init

function H(x)
	implicit none
	real,intent(in) :: x
	integer :: H
	
	if (x>=0) then H=1
	else H=0
	end if

end function H
