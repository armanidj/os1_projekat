//
// Created by os on 8/20/24.
//

#include "../h/syscall_c.hpp"
#include "../h/tcb.hpp"
#include "../h/riscv.hpp"

TCB *TCB::running = 0;

TCB *TCB::createThread(Body body, void* arg, char* stack) {
    return new TCB(body, arg, stack);
}

void TCB::dispatch() {
    TCB* old = running;
    if(!old->getFinished() && old->getActive()) {Scheduler::put(old);}
    running = Scheduler::get();

    TCB::contextSwitch(&old->context, &running->context);
}

void TCB::threadWrapper() {
    Riscv::popSPPSPIE();
    running->body(running->arg);
    thread_exit();
}
