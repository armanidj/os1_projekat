//
// Created by os on 8/22/24.
//

#ifndef PROJECT_BASE_SCHEDULER_HPP
#define PROJECT_BASE_SCHEDULER_HPP

#include "list.hpp"

class TCB;

class Scheduler {

public:
    static TCB* get();
    static void put(TCB* curr);

private:
    static List queue;
};


#endif //PROJECT_BASE_SCHEDULER_HPP
