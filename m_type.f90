module m_type 
	implicit none

	type mes
		real :: C0,L,D,xd,xf,tf
		integer :: N,Nt
		real,dimension(:),allocatable :: X,db2
		real,dimension(:,:),allocatable :: C
	end type mes
end module m_type
