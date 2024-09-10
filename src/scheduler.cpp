//
// Created by os on 8/22/24.
//

#include "../h/scheduler.hpp"
#include "../h/tcb.hpp"

List Scheduler::queue;

TCB* Scheduler::get(){
//    TCB* curr = 0;
//    while (!(queue.peekFront() -> getActive())) {
//        curr = queue.popFront();
//        queue.addRear(curr);
//    }
    return queue.popFront();
}

void Scheduler::put(TCB* tcb){
    queue.addRear(tcb);
}