module m_type 
        ! Module des mesures physiques du programme.
        implicit none

        type mes
                real :: C0,L,D,xd,xf,tf
                integer :: N,Nt
                real,dimension(:),allocatable :: X
                real,dimension(:,:),allocatable :: C
        end type mes
end module m_type
