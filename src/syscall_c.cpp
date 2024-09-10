//
// Created by os on 8/19/24.
//

#include "../h/syscall_c.hpp"

class _thread;
typedef _thread* thread_t;

void* mem_alloc(size_t size) {
    uint64 volatile ptr = 0;
    size = (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE ? 1 : 0);
    __asm__ volatile ("mv a1, %0" : : "r" (size));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::MEMALLOC));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ptr));
    return (void*)ptr;
}

int mem_free(void* ptr) {
    int volatile ret = 0;
    __asm__ volatile ("mv a1, %0" : : "r" (ptr));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::MEMFREE));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}

int thread_create(thread_t *handle, void (*start_routine)(void *), void *arg){
    int volatile ret = 0;
    uint64 stack;
    stack = (uint64)mem_alloc(DEFAULT_STACK_SIZE);
    __asm__ volatile ("mv a4, %0" : : "r" (stack));
    __asm__ volatile ("mv a3, %0" : : "r" (arg));
    __asm__ volatile ("mv a2, %0" : : "r" (start_routine));
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::THREADCREATE));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}

int thread_exit(){
    int volatile ret = 0;
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::THREADEXIT));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}

void thread_dispatch(){
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::DISPATCH));
    __asm__ volatile ("ecall");
}


char getc(){
    uint64 volatile ret = 0;
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::GETC));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return (char)ret;
}


void putc(char c){
    __asm__ volatile ("mv a1, %0" : : "r" (c));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::PUTC));
    __asm__ volatile ("ecall");
}


int sem_open (sem_t* handle, uint64 init){
    int volatile ret = 0;
    __asm__ volatile ("mv a2, %0" : : "r" (init));
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMOPEN));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}

int sem_close (sem_t handle){
    int volatile ret = 0;
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMCLOSE));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}

int sem_wait (sem_t handle){
    int volatile ret = 0;
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMWAIT));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}

int sem_signal (sem_t handle){
    int volatile ret = 0;
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMSIGNAL));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}

int sem_trywait (sem_t handle){
    int volatile ret = 0;
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMTRYWAIT));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    return ret;
}