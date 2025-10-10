module field_mod
    
    use precision_mod, only : dp
    use constants
    implicit none

    ! Type declaration 
    type, private :: Field
        
        real(dp), allocatable, private :: data(:, :, :) !! real(ni,nj,nk) stores scalar field values at each point [x, y, z]

    contains 

        !! We should only do pointers to other methods if the user can interact with that class
        procedure :: alloc_field !! Constructor
        procedure :: dealloc_field !! Destructor

    end type Field

    type, private :: Field3 

        real(dp), allocatable, private :: dataX(:, :, :) !! real(ni,nj,nk) stores X component of field at each point [x, y, z]
        real(dp), allocatable, private :: dataY(:, :, :) !! real(ni,nj,nk) stores Y component of field at each point [x, y, z]
        real(dp), allocatable, private :: dataZ(:, :, :) !! real(ni,nj,nk) stores Z component of field at each point [x, y, z]

    contains 

        procedure, private :: alloc_field3
        procedure :: dealloc_field3

    end type Field3

contains 

    subroutine alloc_field(this, ni, nj, nk)
        class(Field), intent(inout) :: this
        integer, intent(in) :: ni, nj, nk

        ! Allocate a matrix for the scalar field data
        allocate(this%data(ni, nj, nk), source=0.0_dp)

    end subroutine alloc_field 

    subroutine dealloc_field(this)
        class(Field), intent(inout) :: this

        deallocate(this%data)

    end subroutine dealloc_field

    subroutine alloc_field3(this, ni, nj, nk)
        class(Field3), intent(inout) :: this
        integer, intent(in) :: ni, nj, nk

        ! Allocate space to store the vector components
        allocate(this%dataX(ni, nj, nk), source=0.0_dp)
        allocate(this%dataY(ni, nj, nk), source=0.0_dp)
        allocate(this%dataZ(ni, nj, nk), source=0.0_dp)

    end subroutine alloc_field3

    subroutine dealloc_field3(this)
        class(Field3), intent(inout) :: this

        ! Allocate space for the 
        deallocate(this%dataX)
        deallocate(this%dataY)
        deallocate(this%dataZ)

    end subroutine dealloc_field3

end module field_mod