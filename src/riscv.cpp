//
// Created by os on 8/18/24.
//

#include "../h/riscv.hpp"
#include "../lib/console.h"
#include "../lib/mem.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.hpp"
#include "../h/tcb.hpp"
#include "../h/semaphore.hpp"

void Riscv::popSPPSPIE() {
    maskClearSSTATUS(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}

void Riscv::handleSupervisorTrap() {
    uint64 scause = readSCAUSE();
    if (scause == 0x0000000000000008ULL || scause == 0x0000000000000009ULL) //ecall iz user ili supervisor mode-a
    {

        volatile uint64 sepc = readSEPC() + 4;
        volatile uint64 sstatus = readSSTATUS();

        uint64 ecallReason;

        __asm__ volatile ("ld %0, 10 * 8(fp)" : "=r" (ecallReason));

        switch (ecallReason) {

            case  SyscallC::MEMALLOC : {
                uint64 size;
                uint64 ptr;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r"(size));
                size = size * MEM_BLOCK_SIZE;
                ptr = (uint64)MemoryAllocator::mem_alloc((size_t)size);
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r"(ptr));
                break;
            }

            case  SyscallC::MEMFREE : {
                uint64  ptr;
                uint64 ret;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (ptr));
                ret = MemoryAllocator::mem_free((void*)ptr);
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }

            case SyscallC::THREADCREATE : {
                uint64 handle, start_routine, arg, stack_space;
                uint64 ret = 0;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
                __asm__ volatile ("ld %0, 12 * 8(fp)" : "=r" (start_routine));
                __asm__ volatile ("ld %0, 13 * 8(fp)" : "=r" (arg));
                __asm__ volatile ("ld %0, 14 * 8(fp)" : "=r" (stack_space));
                TCB* newThread = TCB::createThread((TCB::Body)start_routine, (void*)arg, (char*)stack_space);
                *((TCB**)handle) = newThread;
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }

            case SyscallC::THREADEXIT : {
                uint64 ret = 0;
                TCB::running->setFinished(true);
                TCB::dispatch();
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }

            case SyscallC::DISPATCH : {
                TCB::dispatch();
                break;
            }

            case SyscallC::GETC : {
                char c = __getc();
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (c));
                break;
            }
            case SyscallC::PUTC : {
                char c;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (c));
                __putc(c);
                break;
            }

            case SyscallC::SEMOPEN : {
                uint64 handle, init;
                uint64 ret = 0;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
                __asm__ volatile ("ld %0, 12 * 8(fp)" : "=r" (init));
                Sem* newSem = Sem::sem_open(init);
                *((Sem**)handle) = newSem;
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }

            case SyscallC::SEMCLOSE : {
                uint64 handle;
                uint64 ret = 0;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
                ((Sem*)handle)->sem_close();
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }

            case SyscallC::SEMWAIT : {
                uint64 handle;
                uint64 ret = 0;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
                ((Sem*)handle)->sem_wait();
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }

            case SyscallC::SEMSIGNAL : {
                uint64 handle;
                uint64 ret = 0;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
                ((Sem*)handle)->sem_signal();
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }

            case SyscallC::SEMTRYWAIT : {
                uint64 handle;
                uint64 ret = 0;
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
                ((Sem*)handle)->sem_trywait();
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
                break;
            }
        }

        writeSSTATUS(sstatus);
        writeSEPC(sepc);
    }
    else if (scause == 0x8000000000000001ULL)
    {
        maskClearSIP(SIP_SSIE);
    }
    else if (scause == 0x8000000000000009ULL)
    {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        console_handler();
    }
    else
    {
        char chScause = scause + '0';
        __putc('F');__putc('A');__putc('T');__putc('A');__putc('L');__putc(' ');
        __putc('E');__putc('R');__putc('R');__putc('O');__putc('R');__putc('\n');
        __putc('S');__putc('C');__putc('A');__putc('U');__putc('S');__putc('E');__putc(' ');__putc(chScause);__putc('\n');

        *(int*)0x100000 = 0x5555;
    }
}