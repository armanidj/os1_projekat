//
// Created by os on 9/3/24.
//

#ifndef PROJECT_BASE_SEMAPHORE_HPP
#define PROJECT_BASE_SEMAPHORE_HPP

#include "../h/list.hpp"
#include "../h/scheduler.hpp"
#include "../h/tcb.hpp"


class Sem {
public:
    static Sem* sem_open(uint64 val);
    void sem_close();

    void sem_wait();
    void sem_signal();

    int sem_trywait();

private:

    int val;
    List blocked;

    Sem(uint64 val) : val(val) {}
};


#endif //PROJECT_BASE_SEMAPHORE_HPP
