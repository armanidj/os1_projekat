//
// Created by os on 8/18/24.
//

#ifndef PROJECT_BASE_RISCV_HPP
#define PROJECT_BASE_RISCV_HPP

#include "../lib/hw.h"

class Riscv {

public:

    static void popSPPSPIE();

    static void pushAllRegs();
    static void popAllRegs();

    static uint64 readSCAUSE();
    static void writeSCAUSE(uint64 scause);

    static uint64 readSEPC();
    static void writeSEPC(uint64 sepc);

    static void writeSTVEC(uint64 stvec);

    static constexpr uint64 SIP_SSIE = (1 << 1);
    static constexpr uint64 SIP_STIE = (1 << 5);
    static constexpr uint64 SIP_SEIE = (1 << 9);

    static void maskSetSIP(uint64 mask);
    static void maskClearSIP(uint64 mask);
    static uint64 readSIP ();
    static void writeSIP (uint64 sip);

    static constexpr uint64 SSTATUS_SIE = (1 << 1);
    static constexpr uint64 SSTATUS_SPIE = (1 << 5);
    static constexpr uint64 SSTATUS_SPP = (1 << 8);

    static void maskSetSSTATUS(uint64 mask);
    static void maskClearSSTATUS(uint64 mask);
    static uint64 readSSTATUS ();
    static void writeSSTATUS (uint64 sstatus);

    static void supervisorTrap();

private:

    static void handleSupervisorTrap();
};

inline uint64 Riscv::readSCAUSE() {
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    return scause;
}

inline void Riscv::writeSCAUSE(uint64 scause) {
    __asm__ volatile ("csrw scause, %[scause]" : : [scause] "r"(scause));
}

inline uint64 Riscv::readSEPC() {
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    return sepc;
}

inline void Riscv::writeSEPC(uint64 sepc) {
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
}

inline void Riscv::writeSTVEC(uint64 stvec) {
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
}

inline void Riscv::maskSetSIP(uint64 mask) {
    __asm__ volatile ("csrs sip, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::maskClearSIP(uint64 mask) {
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
}

inline uint64 Riscv::readSIP() {
    uint64 volatile sip;
    __asm__ volatile ("csrr %[sip], sip" : [sip] "=r"(sip));
    return sip;
}

inline void Riscv::writeSIP(uint64 sip) {
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::maskSetSSTATUS(uint64 mask) {
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::maskClearSSTATUS(uint64 mask) {
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
}

inline uint64 Riscv::readSSTATUS() {
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    return sstatus;
}

inline void Riscv::writeSSTATUS(uint64 sstatus) {
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
}
#endif //PROJECT_BASE_RISCV_HPP
