module m_type
    type phys_type
        real::L, D, C0, xd, xf, A, B, w
    end type phys_type

    type num_type
        integer::N, Nt
        real::Dt,dx,R
    end type num_type
end module m_type