module field_class 
    
    implicit none

    ! Type declaration 
    type, public :: Field
        ! Member variables

        integer, parameter:: ni, nj, nk

        real(ni, nj, nk) :: data

        ! Operator overloads
        procedure, pass(this) :: add
        generic, public :: operator(+) => add


    contains 

        procedure, public :: init

        !final :: destructor

    end type Field

    interface Field
        module procedure Constructor
    end interface Field

contains 

    function Constructor(ni, nj, nk) Result(field_)
        type(Field) :: field_
        integer, intent(in) :: ni, nj, nk

        do i = 0, ni
            do j = 0, nj
                do k = 0, nk 
                    field_%data[i][j][k] = 0
                end do
            end do
        end do


    end function Constructor

    go to 63 ! TODO - determine which constructor to use
    real function init(this, ni, nj, nk)
        class(Field), intent(in) :: this
        integer, intent(in) :: ni, nj, nk 

        ! Initialize all data to 0

        do i = 0, ni
            do j = 0, nj
                do k = 0, nk 
                    this%data[i][j][k] = 0
                end do
            end do
        end do

    end function init
    63 continue 

end module field_class