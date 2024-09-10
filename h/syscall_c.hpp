//
// Created by os on 8/19/24.
//

#ifndef PROJECT_BASE_SYSCALL_C_HPP
#define PROJECT_BASE_SYSCALL_C_HPP

#include "../lib/hw.h"

class _thread;
typedef _thread* thread_t;

class _sem;
typedef _sem* sem_t;

void* mem_alloc(size_t size);
int mem_free(void* ptr);

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg);
int thread_exit ();
void thread_dispatch();

int sem_open(sem_t* handle, uint64 init);
int sem_close(sem_t handle);
int sem_wait (sem_t handle);
int sem_signal (sem_t handle);
int sem_trywait (sem_t handle);

char getc();
void putc(char c);

class SyscallC {
public:

    static constexpr uint64 MEMALLOC = 0x01;
    static constexpr uint64 MEMFREE = 0x02;

    static constexpr uint64 THREADCREATE = 0x11;
    static constexpr uint64 THREADEXIT = 0x12;
    static constexpr uint64 DISPATCH = 0x13;

    static constexpr uint64 SEMOPEN = 0x21;
    static constexpr uint64 SEMCLOSE = 0x22;
    static constexpr uint64 SEMWAIT = 0x23;
    static constexpr uint64 SEMSIGNAL = 0x24;
    static constexpr uint64 SEMTRYWAIT = 0x26;


    static constexpr uint64 GETC = 0x41;
    static constexpr uint64 PUTC = 0x42;

};


#endif //PROJECT_BASE_SYSCALL_C_HPP
