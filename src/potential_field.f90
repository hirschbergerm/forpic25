submodule (field_mod) potential_field_mod

    use constants 
    use field_mod
    use electric_field_mod
    implicit none

    type, extends(Field) :: PotentialField 

        real(dp), allocatable, private :: phi(:,:,:)

    contains 

        procedure :: allocate 

    end type PotentialField 

contains 

    subroutine allocate(this)
        class(PotentialField), intent(inout) :: this

        

    end subroutine allocate 

end submodule potential_field_mod