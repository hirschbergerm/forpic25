module species_class

    use particle_class 

    implicit none
    private

    ! HAVE to declare the type as public or the main script won't see it
    type, public :: species

        ! Public
        integer, public :: count
        real, public :: charge ! The electric charge of the species "Z"
        real, public :: mass ! Mass of the species [kg]
        real, public :: n ! Number density [m^-3]

        ! Public
        integer, private :: foo
        
        
    contains 
        procedure, public :: return_total_charge
    
    end type species

contains 

    real function return_total_charge(this) 
        !! Returns the total charge of the whole species within the simulation.
        ! Have to specify the type of the input
        class(species), intent(in) :: this

        ! As well as the output

        return_total_charge = this%count * this%charge

    end function return_total_charge


end module species_class