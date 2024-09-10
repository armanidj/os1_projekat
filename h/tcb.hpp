//
// Created by os on 8/20/24.
//

#ifndef PROJECT_BASE_TCB_HPP
#define PROJECT_BASE_TCB_HPP

#include "scheduler.hpp"


class TCB {

public:

    bool getFinished () const { return finished; }
    void setFinished (bool val) { finished = val; }

    bool getActive () const { return active; }
    void setActive (bool val) { active = val; }

    using Body = void (*)(void*);

    static TCB *createThread (Body body, void* arg, char* stack);
    static TCB* running;

    static void threadWrapper();
    static void threadExit();

    TCB (Body body, void* arg, char* stack) : body(body), arg(arg), stack(stack),
                                              context({stack != nullptr ? (uint64) stack + DEFAULT_STACK_SIZE: 0, (uint64)&threadWrapper}),
                                              active(true), finished(false)
    {
        if (body != nullptr) {Scheduler::put(this);}
    }

    static void dispatch();

private:

    struct Context {
        uint64 sp;
        uint64 ra;
    };

    Body body;
    void* arg;
    char* stack;
    Context context;
    bool active;
    bool finished;

    static void contextSwitch (Context* oldC, Context* newC);


};


#endif //PROJECT_BASE_TCB_HPP
