# Forpic Coding Standards

# Data Oriented Design and Memory-Oriented Interfaces

This program adheres to principles of Data-Oriented Design (DOD) in order to maximize memory and cache efficiency. Additionally, the initializer subroutines for modules are named to emphasize that memory is being allocated when you instantiate a module. This is really a practice for myself to think about proper memory management as I build up my code.

## Principles of DOD


## Memory-Oriented Naming

All modules involved in the physical simulation follow the **Resource Acquisition Is Initialization (RAII)** design pattern. 

- **allocate**
    - The member arrays are allocated in memory using the passed dimensions. Dimensions are *always* passed to this function. 
    - If the module is a lightweight wrapper - such as the electric field module - the wrapper's pointers will be linked to the underlying data arrays.
- **deallocate**
    - The arrays are deallocated in memory and the module is destroyed.
