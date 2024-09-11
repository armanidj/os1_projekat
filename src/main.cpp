//
// Created by os on 6/4/24.
//


#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/riscv.hpp"
#include "../h/syscall_c.hpp"
#include "../h/tcb.hpp"
#include "../h/userMain.hpp"

extern void userMain();

volatile bool finished = false;

void userMainExecutor(void*)
{
    userMain();
    finished = true;
}
int main() {

    Riscv::writeSTVEC((uint64)&Riscv::supervisorTrap);

    TCB::running = new TCB(0, 0, 0);

    userMain();

    *(int*)0x100000 = 0x5555;

    return 0;
}