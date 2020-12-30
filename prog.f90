program main
        use m_type
        implicit none
        
        type(mes) :: a
        character(len=9) :: choix
        integer :: i
        real :: delta_x, delta_t
        
        ! Récupère les arguments
        if (iargc()==0) then
                choix = "classique"
        else
                call getarg(1, choix)
        end if
        call recup_donnee(a)
        if (choix=="part3" .or. choix=="part5") then
                open(11,file="res.csv")
                do i=20,80
                        if (choix=="part3") then 
                                a%N=i
                        else
                                a%Nt=i
                                delta_t=a%tf/a%Nt
                        end if
                        delta_x=a%L/a%N
                        allocate(a%X(a%N))
                        call maillage(a)
                        allocate(a%C(a%N,a%Nt))
                        allocate(a%C2(a%N,a%Nt))
                        call C_init(a,choix)
                        call concentration(a,choix)
                        call validation(a)
                        write(11,*) a%D*a%tf/(a%Nt*delta_x**2), sum(maxval(abs(a%C-a%C2),1))/real(a%Nt)!, delta_x/a%L
                        deallocate(a%X,a%C,a%C2)
                end do
                close(11)
        else
                allocate(a%X(a%N))
                call maillage(a)
                allocate(a%C(a%N,a%Nt))
                call C_init(a,choix)
                call concentration(a,choix)
                if (choix == "part2") then
                        allocate(a%db2(a%N))
                        call part2(a)
                end if
                call ecriture_csv(a,choix)
                if (allocated(a%db2)) then
                        deallocate(a%X,a%C,a%db2)
                else
                        deallocate(a%X,a%C)
                end if
        end if
end program main
