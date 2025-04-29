# Declare some variables
PROG := forpic

FC := gfortran # Fortran compiler
LD := $(FC)
RM := del

# List all source files
SRCS := src\main.f90 \
		src\constants.f90 \
		src\physical_classes\species.f90 \
		src\physical_classes\particle.f90

OBJS := src\main.o \
		src\constants.o \
		src\physical_classes\species.o \
		src\physical_classes\particle.o

.PHONY: all clean
all: $(PROG)

# Target the program
# Prerequisites: object files
# Command: gfortran -o forpic25 main.o, constants.o, ...
$(PROG): $(OBJS)
		gfortran -o $@ $^ -fopenmp

$(OBJS): %.o: %.f90
		gfortran -c -o $@ $< -J src\mods

# Dependencies
src\main.o: src\constants.o \
			src\physical_classes\species.o \
			src\physical_classes\particle.o
src\physical_classes\species.o: src\physical_classes\particle.o 
src\world.o: src\field_classes\electric_field.o

clean:
	$(RM) $(filter %.o, $(OBJS)) $(filter %.exe, $(PROG)) $(wildcard *.mod)