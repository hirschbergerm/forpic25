program ForPIC25

    use constants
    use world_mod
    implicit none

    ! Variable declarations
    ! At some point maybe we want to load a config file. For now we'll hard-code simulation parameters

    integer :: sim_iterations
    integer, parameter :: n_nodes = 21

    type(World) :: sim_domain

    !-------------------------------------------------------------------------------------------------
    ! Construct world
    call sim_domain%allocate(21, 21, 21)
    
    ! Load species 
    

    ! Apply particle distribution and apply any perturbations
    

    ! Basic domain discretization and initializing 





end program ForPIC25
