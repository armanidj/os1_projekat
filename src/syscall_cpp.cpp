//
// Created by os on 8/25/24.
//

#include "../h/syscall_cpp.hpp"


void *operator new(size_t n)
{
    return mem_alloc(n);
}

void *operator new[](size_t n)
{
    return mem_alloc(n);
}

void operator delete(void *p) noexcept
{
    mem_free(p);
}

void operator delete[](void *p) noexcept
{
    mem_free(p);
}

Thread::Thread(void (*body)(void *), void *arg) : body(body), arg(arg) {
}


Thread::~Thread(){

}

int Thread::start() {
    return thread_create(&myHandle, body, arg);
}

void Thread::dispatch() {
    thread_dispatch();
}

Thread::Thread() : body(&runWrapper), arg(this){

}

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    sem_close(myHandle);
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

int Semaphore::tryWait() {
    return sem_trywait(myHandle);
}


char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}
