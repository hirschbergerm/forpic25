module potential_solver_mod
   
    use precision_mod, only : dp
    use constants
    use field_mod
    use world_mod
    implicit none

    type, public :: PotentialSolver

        class(World), pointer :: world_ptr
        integer :: max_solver_it !! maximum number of solver iterations
        real(dp) :: tolerance !! solver tolerance

    contains 
        ! Constructor and Destructor
        procedure, public :: constructor
        procedure, public :: destructor 

        procedure, public :: solve_GaussSeidel
        procedure, public :: compute_ef

    end type PotentialSolver

contains 

    subroutine constructor(this, sim_domain, max_solver_it, tolerance)
        class(PotentialSolver), intent(inout) :: this
        class(World), target, intent(in) :: sim_domain
        integer, intent(in) :: max_solver_it
        real(dp), intent(in) :: tolerance

        ! Initialize members
        this%world_ptr => sim_domain
        this%max_solver_it = max_solver_it
        this%tolerance = tolerance

    end subroutine constructor

    subroutine destructor(this)
        class(PotentialSolver), intent(inout) :: this

    end subroutine destructor

    function solve_GaussSeidel(this) result(converged)
        class(PotentialSolver), intent(inout), target :: this

        real(dp) :: idx2, idy2, idz2, dh(3), phi_new
        integer :: it, i, j, k

        real(dp) :: L2, residual, sum
        logical :: converged !! Indicates whether the Gauss-Seidel calculation converged

        ! Local pointers to world data members. This is purely to reduce verbosity!
        ! Otherwise we'd have to type this%world_ptr%phi
        class(Field), pointer :: phi, rho

        phi => this%world_ptr%phi
        rho => this%world_ptr%rho

        ! Precompute 1/(dx^2)
        dh = this%world_ptr%getDh()
        idx2 = 1.0 / (dh(1) * dh(1))
        idy2 = 1.0 / (dh(2) * dh(2))
        idz2 = 1.0 / (dh(3) * dh(3))

        L2 = 0
        converged = .false.

        ! Main solver loop
        do it = 0, this%max_solver_it

            ! Loop over all of the internal mesh nodes
            do i = 2, this%world_ptr%ni - 1
                do j = 2, this%world_ptr%nj - 1
                    do k = 2, this%world_ptr%nk - 1
                        ! Finite difference equation
                        phi_new = ((rho%get(i,j,k) / EPS0) + idx2 * (phi%get(i-1,j,k) + phi%get(i+1,j,k)) + &
                                    idy2 * (phi%get(i,j-1,k) + phi%get(i,j+1,k)) + &
                                    idz2 * (phi%get(i,j,k-1) + phi%get(i,j,k+1))) / (2*idx2 + 2*idy2 + 2*idz2)

                        ! Successive Over-Relaxation
                        call phi%set(i, j, k, phi%get(i,j,k) + 1.4 * (phi_new - phi%get(i,j,k)))
                    end do
                end do
            end do ! end internal node loop

            ! Check for convergence every couple of iterations
            if (mod(it, 25) .eq. 0) then
                sum = 0
                do i = 2, this%world_ptr%ni - 1
                    do j = 2, this%world_ptr%nj - 1
                        do k = 2, this%world_ptr%nk - 1
                            ! Finite difference equation
                            residual = -phi%get(i,j,k)*(2*idx2 + 2*idy2 + 2*idz2) + (rho%get(i,j,k) / EPS0) + & 
                                        idx2 * (phi%get(i-1,j,k) + phi%get(i+1,j,k)) + &
                                        idy2 * (phi%get(i,j-1,k) + phi%get(i,j+1,k)) + &
                                        idz2 * (phi%get(i,j,k-1) + phi%get(i,j,k+1))

                            ! Successive Over-Relaxation
                            sum = residual + residual
                        end do
                    end do
                end do

                L2 = sqrt( sum / (this%world_ptr%ni * this%world_ptr%nj * this%world_ptr%nk))

                if (L2 .le. this%tolerance) then
                    converged= .true.
                    exit 
                end if 

            end if ! end convergence check if

        end do ! end main loop



        if (.not. converged) then
            print *, "ERROR: Gauss-Seidel Solver failed to converge. L2=", L2 
            error stop ! requires F2008
        end if

    end function solve_GaussSeidel

    subroutine compute_ef(this)
        class(PotentialSolver), intent(inout) :: this

        

    end subroutine compute_ef

end module potential_solver_mod