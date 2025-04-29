program unit_tests
    !! Runs unit tests for the ForPIC 25 classes.

    use :: species_class
    use :: constants

    implicit none

    ! Declare variables
    type(species) :: electrons

    real :: Q

    electrons%mass = me
    electrons%count = 1000
    electrons%charge = e

    ! ---------------------RUN UNIT TESTS----------------------------
    
    Q = electrons%return_total_charge()

    print *, Q


end program unit_tests