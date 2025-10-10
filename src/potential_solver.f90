module potential_solver_class

    use world_class

    implicit none

    type, public :: PotentialSolver
        
        type(World) :: world

    contains 
        procedure, public :: solve
        procedure, public :: compute_electric_field

        !final :: destructor

    end type PotentialSolver


    interface PotentialSolver
        module procedure Constructor
    end interface PotentialSolver

contains 

    function Constructor(world_, max_iterations, tolerance) Result(potential_solver)
        type(PotentialSolver) :: potential_solver
        type(World), intent(in) :: world_
        integer, intent(in) :: max_iterations
        real, intent(in) :: tolerance

        ! This should be passed by reference 
        potential_solver%world = world_
        potential_solver%max_iterations = max_iterations
        potential_solver%tolerance = tolerance

    end function Constructor
    ! Test

    logical function solve(this)
        class(PotentialSolver), intent(in) :: this
        real(3) :: dh 
        real :: idx2, idy2, idz2

        ! Precompute 1/(dx^2)
        dh = this%world%getDh()
        idx2 = 1/(dh[0]**2)
        idy2 = 1/(dh[1]**2)
        idz2 = 1/(dh[2]**2)

        


        ! Solve for potential
        do i = 0, this%world%num_n


    end function solve 
    !! Solves for the potential using the Gauss-Siedel Scheme with SOR



end module potential_solver_class