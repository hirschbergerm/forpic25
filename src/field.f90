module field_mod
    
    use precision_mod, only : dp
    use constants
    implicit none

    ! Type declaration 
    type :: Field
        
        real(dp), allocatable, private :: data(:, :, :) !! real(ni,nj,nk) stores scalar field values at each point [x, y, z]

    contains 

        !! We should only do pointers to other methods if the user can interact with that class
        procedure, public :: allocate => alloc_field !! Constructor
        procedure, public :: deallocate => dealloc_field !! Destructor

        procedure, public :: get
        procedure, public :: set

    end type Field

contains 

    subroutine alloc_field(this, ni, nj, nk)
        class(Field), intent(inout) :: this
        integer, intent(in) :: ni, nj, nk

        ! Allocate a matrix for the scalar field data
        allocate(this%data(ni, nj, nk), source=0.0_dp)

    end subroutine alloc_field 

    function get(this, i, j, k) result(value)
        class(Field), intent(in) :: this
        integer, intent(in) :: i, j, k
        real(dp) :: value

        value = this%data(i, j, k)

    end function get

    subroutine set(this, i, j, k, value)
        class(Field), intent(inout) :: this
        integer, intent(in) :: i, j, k
        real(dp), intent(in) :: value

        ! Do some value checks here.
        ! In the future this should probably be customizable to each class

        this%data(i, j, k) = value

    end subroutine set

    subroutine dealloc_field(this)
        class(Field), intent(inout) :: this

        deallocate(this%data)

    end subroutine dealloc_field


end module field_mod