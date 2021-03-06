## CV32/TB: testbenches for the CV32E40\* CORE-V family of RISC-V cores.
Derived from the
[tb](https://github.com/pulp-platform/riscv/tree/master/tb)
directory of the PULP-Platform RI5CY project.  There are two distinct
testbenches:

### core
Modified to remove a few RTL files (placed these in the rtl directory). This
testbench supports Verilator and we will do what we can to maintain Verilator
support here.  Note that `tb_riscv` is now a sub-directory of `core`.

### uvmt_cv32
The testbench and testharness for the CV32E40\* UVM verification
environments.  This tb/th maintains support for all features of the `core`
testbench.  Future releases of `uvmt_cv32` will support features such as
an Instruction Set Simulator reference model of the cv32, an instruction
generator, and functional coverage. Cannot be run with Verilator.

## Retired Testbenches
A set of directories inherited from the RI5CY project have fallen into disuse
and were deleted.  Since nothing is ever gone in GitHub, if you _must_ have
this content, it is available in any hash of this repo older than
11ffa1577abfff2f7dce8afed6047b0c86ad335c.   The deleted directories are:

* dm
* scripts
* serDiv
* tb_MPU
* verilator-model
