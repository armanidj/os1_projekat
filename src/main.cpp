//
// Created by os on 6/4/24.
//


#include "../lib/hw.h"
#include "../h/riscv.hpp"
#include "../h/tcb.hpp"

extern void userMain();


int main() {

    Riscv::writeSTVEC((uint64)&Riscv::supervisorTrap);

    TCB::running = new TCB(0, 0, 0);

    userMain();

    *(int*)0x100000 = 0x5555;

    return 0;
}