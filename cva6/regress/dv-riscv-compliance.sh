# Copyright 2021 Thales DIS design services SAS
#
# Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
# You may obtain a copy of the License at https://solderpad.org/licenses/
#
# Original Author: Jean-Roch COULON (jean-roch.coulon@thalesgroup.fr)

# where are the tools
if ! [ -n "$RISCV" ]; then
  echo "Error: RISCV variable undefined"
  return
fi

# install the required tools
source ./cva6/regress/install-cva6.sh
source ./cva6/regress/install-riscv-dv.sh
source ./cva6/regress/install-riscv-compliance.sh

if ! [ -n "$DV_TARGET" ]; then
  DV_TARGET=rv64gc
fi

if ! [ -n "$DV_SIMULATORS" ]; then
  DV_SIMULATORS=veri-uvm,spike
fi

# If no compiler was specified, assume GCC for now.
if ! [  -n "$RISCV_GCC" ]; then
  RISCV_GCC=$RISCV/bin/riscv-none-elf-gcc
fi

# If using CLang and no user-speficied DV_OPTS, set the default option values.
COMPILER=`basename $RISCV_GCC`
if [ "${COMPILER:0:5}" = "clang" -a -z "$DV_OPTS" ]; then
  # CLang requires separate options for 64 and 32 bits.
  if [ "${DV_TARGET:0:4}" = "rv64" ]; then
    DV_OPTS=--gcc_opts="--target=riscv64 -mno-relax --sysroot=${RISCV}/riscv-none-elf -Wl,-melf64lriscv -fuse-ld=${RISCV}/bin/riscv-none-elf-ld"
  else
    DV_OPTS=--gcc_opts="--target=riscv32 -mno-relax --sysroot=${RISCV}/riscv-none-elf -Wl,-melf32lriscv -fuse-ld=${RISCV}/bin/riscv-none-elf-ld"
  fi
fi

cd cva6/sim/riscv-dv
# DV_OPTS must either be empty or wrapped in double quotes.
python3 run.py --testlist=../../tests/testlist_riscv-compliance-$DV_TARGET.yaml --target $DV_TARGET --iss=$DV_SIMULATORS ${DV_OPTS:+"$DV_OPTS"}
cd ../../..
