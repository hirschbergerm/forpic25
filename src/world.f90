module world_class

    !! NOTE: Only implements a Cartesian mesh for now
    use constants
    use field_class

    implicit none

    type, public :: World

        ! Public 
        real(3), public :: num_nodes !! Number of nodes in x,y,z

        type(Field), public :: ef  ! Electric field
        type(Field), public :: rho ! Charge density
        type(Field), public :: phi ! Potential 

        ! Protected
        real(3), protected :: x0 !! Origin of the mesh
        real(3), protected :: dh !! Cell spacing in x,y,z 
        real(3), protected :: x_centroid !! Centroid of the mesh
        real(3), protected :: x_max !! Maximum values of x,y,z dimensions
        
    contains 
        procedure, public :: init
        procedure, public :: setExtents

        ! Getters and setters
        procedure, public :: getDh

        !final :: destructor
    
    end type World 

    interface World
        module procedure Constructor
    end interface World

contains 

    real function init(this, ni, nj, nk)
        class(World), intent(in) :: this
        integer, intent(in) :: ni, nj, nk 
        
        this%num_nodes[0] = ni
        this%num_nodes[1] = nj
        this%num_nodes[2] = nk

        this%rho = Field(ni, nj, nk)
        this%phi = Field(ni, nj, nk)
        this%ef = Field(ni, nj, nk)

    end function init
    !! "Constructor" for the World class. Sets the number of nodes in each direction
    
    real function setExtents(this, x1, y1, z1, x2, y2, z2)
        class(World), intent(in) :: this
        real, intent(in) :: x1, y1, z1, x2, y2, z2

        ! Set origin to x_min
        this%x0[0] = x1
        this%x0[1] = y1
        this%x0[2] = z1

        ! Set Diagonally-Opposite corner
        this%x_max[0] = x2
        this%x_max[1] = y2
        this%x_max[2] = z2

        ! Calculate cell spacing
        do i = 0, 3
            this%dh[i] = (x_max[i] - this%x0[i]) / (this%num_nodes[i]-1)
        end do

        ! Compute centroid
        do i = 0, 3
            this%x_centroid[i] = 0.5*(this%x0[i] + this%x_max[i])
        end do

    end function setExtents
    !! Sets mesh extents and computes cell spacing
    
    real(3) function getDh(this) Result(this%dh)
         class(World), intent(in) :: this
    end function getDh

end module world_class
