//
// Created by os on 8/25/24.
//

#ifndef PROJECT_BASE_SYSCALL_CPP_HPP
#define PROJECT_BASE_SYSCALL_CPP_HPP

#include "syscall_c.hpp"

void* operator new (size_t);
void operator delete (void*) noexcept;

class Thread {
public:
    Thread (void (*body)(void*), void* arg);
    virtual ~Thread();

    int start();

    static void dispatch ();

protected:

    Thread();
    virtual void run() {};

private:
    static void runWrapper(void* thread_p) {
        ((Thread*)thread_p)->run();
    }
    thread_t myHandle;
    void (*body)(void*);
    void* arg;
};

class Semaphore {
public:
    Semaphore(unsigned init = 1);

    virtual ~Semaphore();

    int wait();

    int signal();

    int tryWait();

private:
    sem_t myHandle;
};

class Console {
public:
    static char getc();

    static void putc(char);
};

#endif //PROJECT_BASE_SYSCALL_CPP_HPP
