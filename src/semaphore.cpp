//
// Created by os on 9/3/24.
//

#include "../h/semaphore.hpp"

Sem* Sem::sem_open(uint64 val){
    return new Sem(val);
}

void Sem::sem_close() {
    TCB* curr = 0;
    while (blocked.peekFront()){
        curr = blocked.popFront();
        Scheduler::put(curr);
    }
}

void Sem::sem_wait() {
    TCB* curr = TCB::running;
    if (--val < 0) {
        curr->setActive(0);
        blocked.addRear(curr);
        TCB::dispatch();
    }
}

void Sem::sem_signal() {
    if (++val <= 0 && blocked.peekFront()){
        blocked.peekFront()->setActive(1);
        Scheduler::put(blocked.popFront());
    }
}

int Sem::sem_trywait() {
    val--;
    if (val < 0) {
        val++;
        return 1;
    }
    else return 0;
}


