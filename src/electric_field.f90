submodule (field_mod) electric_field_mod

    use constants
    use field_mod
    implicit none

    type, extends(Field3) :: ElectricField

        real(dp), allocatable, private :: Ex(:, :, :)
        real(dp), allocatable, private :: Ey(:, :, :)
        real(dp), allocatable, private :: Ez(:, :, :)

    contains 

        procedure:: allocate => alloc_electricfield

    end type ElectricField
    
contains

    subroutine alloc_electricfield(this, ni, nj, nk)
        class(ElectricField), intent(inout) :: this
        integer, intent(in) :: ni, nj, nk

        !! Allocate the field arrays 
        call this%alloc_field3(ni, nj, nk)

        !! Link electric field components
        this%Ex = this%dataX
        this%Ey = this%dataY
        this%Ez = this%dataZ

    end subroutine alloc_electricfield


end submodule electric_field_mod