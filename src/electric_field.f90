module electric_field_mod

    use precision_mod, only : dp
    use constants
    implicit none

    type :: ElectricField

        real(dp), allocatable, private :: Ex(:, :, :) !! real(ni x nj  nk) X-component of the electric field at (x, y, z)
        real(dp), allocatable, private :: Ey(:, :, :) !! real(ni x nj  nk) Y-component of the electric field at (x, y, z)
        real(dp), allocatable, private :: Ez(:, :, :) !! real(ni x nj  nk) Z-component of the electric field at (x, y, z)

    contains 

        procedure :: allocate => alloc_electricfield
        procedure :: deallocate => dealloc_electricfield

    end type ElectricField
    
contains

    subroutine alloc_electricfield(this, ni, nj, nk)
        class(ElectricField), intent(inout) :: this
        integer, intent(in) :: ni, nj, nk

        !! Link electric field components
        allocate(this%Ex(ni, nj, nk), source = 0.0_dp)
        allocate(this%Ey(ni, nj, nk), source = 0.0_dp)
        allocate(this%Ez(ni, nj, nk), source = 0.0_dp)

    end subroutine alloc_electricfield

    subroutine dealloc_electricfield(this)
        class(ElectricField), intent(inout) :: this

        deallocate(this%Ex)
        deallocate(this%Ey)
        deallocate(this%Ez)

    end subroutine dealloc_electricfield

end module electric_field_mod