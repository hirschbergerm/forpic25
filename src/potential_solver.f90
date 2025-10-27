module potential_solver_mod
   
    use precision_mod, only : dp
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
        procedure, public :: compute_electricfield

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

    subroutine solve_GaussSeidel(this)
        class(PotentialSolver), intent(inout) :: this

        real(dp) :: idx2, idy2, idz2, dh(3)
        integer :: it, i, j, k
        real(dp) :: L2
        logical :: converged 

        ! Precompute 1/(dx^2)
        dh = this%world_ptr%getDh()
        idx2 = 1.0 / (dh(1) * dh(1))
        idy2 = 1.0 / (dh(2) * dh(2))
        idz2 = 1.0 / (dh(3) * dh(3))

        L2 = 0
        converged = .false.

        ! Solve the potential using the charge density field
        do it = 0, this%max_solver_it
            do i = 2, this%world_ptr%ni - 1
                

            end do
        end do



        

    end subroutine solve_GaussSeidel

    subroutine compute_ef(this)
        class(PotentialSolver), intent(inout) :: this

        

    end subroutine compute_ef

end module potential_solver_mod