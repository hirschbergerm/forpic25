program ForPIC25

    ! Use statements
    use constants 
    use species_class
    use world_class

    ! Implicit none declaration
    implicit none

    ! Variable declarations
    ! At some point maybe we want to load a config file. For now we'll hard-code simulation parameters

    integer :: sim_iterations
    integer, parameter :: n_nodes = 21

    integer :: i, j, k 


    type(world) :: simulation_domain
    type(species) :: electrons, protons 

    !-------------------------------------------------------------------------------------------------
    
    simulation_domain%init(21, 21, 21)
    simulation_domain%setExtents(-0.1, -0.1)
    
    ! Load species 
    

    ! Apply particle distribution and apply any perturbations
    

    ! Basic domain discretization and initializing 





end program ForPIC25