subroutine recup_donnee(a)
        ! Lecture des données du problème dans le fichier donnee.dat.
        use m_type
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
        ! Maillage dans l'espace 1D en fonction des paramètre de a.
        use m_type
        implicit none
        
        type(mes), intent(inout) :: a
        integer :: i
        
        do i=1,a%N
                a%X(i)=a%L*(i-1)/(a%N-1)
        end do
end subroutine maillage

subroutine C_init(a)
        ! Initialisation de la concentration pour t = 0 s.
        use m_type
        implicit none

        type(mes),intent(inout) :: a
        integer :: H,i

        do i=1,a%N
                a%C(i,1)=a%C0*(H(a%X(i)-a%xd) - H(a%X(i)-a%xf)) 
        end do
end subroutine C_init

subroutine concentration(a)
        ! Construction du tableau des concentrations à partir de l'équation (6).
        ! C(i,j) avec i le paramêtre d'espace et j le temps.
        use m_type
        implicit none

        type(mes), intent(inout) :: a
        integer :: i,j
        real :: delta_x,delta_t,R,t,f

        delta_x=a%L/real(a%N-1)
        delta_t=a%tf/real(a%Nt-1)
        R=a%D*delta_t/(delta_x**2)
        t=0.

        do j=1,a%Nt-1
                a%C(1,j+1)=f(t)
                a%C(a%N,j+1)=0.
                t=t+delta_t
                do i=2,a%N-1
                        a%C(i,j+1)=R*a%C(i-1,j)+(1.-2.*R)*a%C(i,j)+R*a%C(i+1,j)
                end do
        end do
end subroutine

subroutine ecriture(a)
        use m_type
        implicit none
        
        type(mes), intent(in) :: a
        integer :: i,j
        
        open(11, file="res.csv")
        do i=1,a%Nt
                do j=1,a%N
                        write(11,*) a%X(j), a%C(j,i)
                end do
        end do
        close(11)
        
end subroutine ecriture

function H(x)
        ! Fonction de Heaviside.
        implicit none
        real,intent(in) :: x
        integer :: H
        
        if (x>=0) then
                H=1
        else 
                H=0
        end if
end function H

function f(t)
        ! Définit la concentration en x=0. Dans notre problème, elle vaut 0 pour tout t
        real,intent(in) :: t
        real :: f

        f=0.
end function f
