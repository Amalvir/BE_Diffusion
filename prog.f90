program main
        ! Programme principal qui écrit un fichier res.csv pouvant être utilisé par le fichier lecture_fichier python.
        use m_type
        implicit none
        
        type(mes) :: a
        
        call recup_donnee(a)
        allocate(a%X(a%N))
        call maillage(a)
        allocate(a%C(a%N,a%Nt))
        call C_init(a)
        call concentration(a)
        call ecriture(a)
        deallocate(a%X,a%C)
end program main
