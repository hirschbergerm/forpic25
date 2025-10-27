module world_mod

    !! NOTE: Only implements a Cartesian mesh for now
    use constants
    use field_mod
    use electric_field_mod

    implicit none

    type, public :: World

        ! Mesh Data
        real, public :: mesh_origin(3) !! real(3) [x, y, z] components of mesh origin 
        real, public :: num_nodes(3) !! real(3) [nx, ny, nz] Number of nodes along each axis
        real, public :: ni, nj, nk 

        real, private :: dh(3) !! real(3) [dx, dy, dz] cell spacing along each axis
        real, private :: max_bound(3) !! real(3) [xmax, ymax, zmax] maximum value along each axis
        real, private :: centroid(3)

        class(Field), allocatable, private :: phi
        class(Field), allocatable, private :: rho !! 
        class(ElectricField), allocatable, private :: ef !! 
        

    contains 

        procedure, public :: allocate => alloc_world
    
    end type World 

contains 
    
    !! Constructor for the world class.
    !! Initializes mesh data and allocates memory for the cells 
    subroutine alloc_world(this, ni, nj, nk) 
        class(World), intent(inout) :: this
        integer, intent(in) :: ni, nj, nk

        !! Allocate the charge density and potential fields
        call this%phi%allocate(ni, nj, nk)
        call this%rho%allocate(ni, nj, nk)

        !! Allocate memory for the electric field data
        call this%ef%allocate(ni, nj, nk)

    end subroutine alloc_world

end module world_mod
