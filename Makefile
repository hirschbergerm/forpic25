# Declare some variables
PROG := forpic

FC := gfortran # Fortran compiler
LD := $(FC)
RM := del

# List all source files
SRS = $(wildcard src/*.f90)
OBJS = $(patsubst src/%.f90, build/%.o, $(SOURCES))

.PHONY: all clean
all: $(PROG)

# Target the program
# Prerequisites: object files
# Command: gfortran -o forpic25 main.o, constants.o, ...
$(PROG): $(OBJS)
		gfortran -o $@ $^ -fopenmp

$(OBJS): %.o: %.f90
		gfortran -c -o $@ $< 

# Specify dependencies for each source file
src/main.o: src/constants.o \
			src/physical_classes/species.o \
			src/physical_classes/particle.o

src/physical_classes/species.o: src/physical_classes/particle.o 

src/world.o: src/constants.o \
			 src/field_classes/electric_field.o

clean:
	$(RM) $(filter %.o, $(OBJS)) $(filter %.exe, $(PROG)) $(wildcard *.mod)