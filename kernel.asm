
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	ef013103          	ld	sp,-272(sp) # 80009ef0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	160050ef          	jal	ra,8000517c <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:

    # pushovanje svih registara na stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    sd x1, 1 * 8(sp)
    80001024:	00113423          	sd	ra,8(sp)
    sd x2, 2 * 8(sp)
    80001028:	00213823          	sd	sp,16(sp)
    sd x3, 3 * 8(sp)
    8000102c:	00313c23          	sd	gp,24(sp)
    sd x4, 4 * 8(sp)
    80001030:	02413023          	sd	tp,32(sp)
    sd x5, 5 * 8(sp)
    80001034:	02513423          	sd	t0,40(sp)
    sd x6, 6 * 8(sp)
    80001038:	02613823          	sd	t1,48(sp)
    sd x7, 7 * 8(sp)
    8000103c:	02713c23          	sd	t2,56(sp)
    sd x8, 8 * 8(sp)
    80001040:	04813023          	sd	s0,64(sp)
    sd x9, 9 * 8(sp)
    80001044:	04913423          	sd	s1,72(sp)
    sd x10, 10 * 8(sp)
    80001048:	04a13823          	sd	a0,80(sp)
    sd x11, 11 * 8(sp)
    8000104c:	04b13c23          	sd	a1,88(sp)
    sd x12, 12 * 8(sp)
    80001050:	06c13023          	sd	a2,96(sp)
    sd x13, 13 * 8(sp)
    80001054:	06d13423          	sd	a3,104(sp)
    sd x14, 14 * 8(sp)
    80001058:	06e13823          	sd	a4,112(sp)
    sd x15, 15 * 8(sp)
    8000105c:	06f13c23          	sd	a5,120(sp)
    sd x16, 16 * 8(sp)
    80001060:	09013023          	sd	a6,128(sp)
    sd x17, 17 * 8(sp)
    80001064:	09113423          	sd	a7,136(sp)
    sd x18, 18 * 8(sp)
    80001068:	09213823          	sd	s2,144(sp)
    sd x19, 19 * 8(sp)
    8000106c:	09313c23          	sd	s3,152(sp)
    sd x20, 20 * 8(sp)
    80001070:	0b413023          	sd	s4,160(sp)
    sd x21, 21 * 8(sp)
    80001074:	0b513423          	sd	s5,168(sp)
    sd x22, 22 * 8(sp)
    80001078:	0b613823          	sd	s6,176(sp)
    sd x23, 23 * 8(sp)
    8000107c:	0b713c23          	sd	s7,184(sp)
    sd x24, 24 * 8(sp)
    80001080:	0d813023          	sd	s8,192(sp)
    sd x25, 25 * 8(sp)
    80001084:	0d913423          	sd	s9,200(sp)
    sd x26, 26 * 8(sp)
    80001088:	0da13823          	sd	s10,208(sp)
    sd x27, 27 * 8(sp)
    8000108c:	0db13c23          	sd	s11,216(sp)
    sd x28, 28 * 8(sp)
    80001090:	0fc13023          	sd	t3,224(sp)
    sd x29, 29 * 8(sp)
    80001094:	0fd13423          	sd	t4,232(sp)
    sd x30, 30 * 8(sp)
    80001098:	0fe13823          	sd	t5,240(sp)
    sd x31, 31 * 8(sp)
    8000109c:	0ff13c23          	sd	t6,248(sp)


    call _ZN5Riscv20handleSupervisorTrapEv
    800010a0:	170030ef          	jal	ra,80004210 <_ZN5Riscv20handleSupervisorTrapEv>


    # popovanje svih registara sa stack-a nakon
    # handlovanja prekidne rutine

    ld x1, 1 * 8(sp)
    800010a4:	00813083          	ld	ra,8(sp)
    ld x2, 2 * 8(sp)
    800010a8:	01013103          	ld	sp,16(sp)
    ld x3, 3 * 8(sp)
    800010ac:	01813183          	ld	gp,24(sp)
    ld x4, 4 * 8(sp)
    800010b0:	02013203          	ld	tp,32(sp)
    ld x5, 5 * 8(sp)
    800010b4:	02813283          	ld	t0,40(sp)
    ld x6, 6 * 8(sp)
    800010b8:	03013303          	ld	t1,48(sp)
    ld x7, 7 * 8(sp)
    800010bc:	03813383          	ld	t2,56(sp)
    ld x8, 8 * 8(sp)
    800010c0:	04013403          	ld	s0,64(sp)
    ld x9, 9 * 8(sp)
    800010c4:	04813483          	ld	s1,72(sp)
    ld x10, 10 * 8(sp)
    800010c8:	05013503          	ld	a0,80(sp)
    ld x11, 11 * 8(sp)
    800010cc:	05813583          	ld	a1,88(sp)
    ld x12, 12 * 8(sp)
    800010d0:	06013603          	ld	a2,96(sp)
    ld x13, 13 * 8(sp)
    800010d4:	06813683          	ld	a3,104(sp)
    ld x14, 14 * 8(sp)
    800010d8:	07013703          	ld	a4,112(sp)
    ld x15, 15 * 8(sp)
    800010dc:	07813783          	ld	a5,120(sp)
    ld x16, 16 * 8(sp)
    800010e0:	08013803          	ld	a6,128(sp)
    ld x17, 17 * 8(sp)
    800010e4:	08813883          	ld	a7,136(sp)
    ld x18, 18 * 8(sp)
    800010e8:	09013903          	ld	s2,144(sp)
    ld x19, 19 * 8(sp)
    800010ec:	09813983          	ld	s3,152(sp)
    ld x20, 20 * 8(sp)
    800010f0:	0a013a03          	ld	s4,160(sp)
    ld x21, 21 * 8(sp)
    800010f4:	0a813a83          	ld	s5,168(sp)
    ld x22, 22 * 8(sp)
    800010f8:	0b013b03          	ld	s6,176(sp)
    ld x23, 23 * 8(sp)
    800010fc:	0b813b83          	ld	s7,184(sp)
    ld x24, 24 * 8(sp)
    80001100:	0c013c03          	ld	s8,192(sp)
    ld x25, 25 * 8(sp)
    80001104:	0c813c83          	ld	s9,200(sp)
    ld x26, 26 * 8(sp)
    80001108:	0d013d03          	ld	s10,208(sp)
    ld x27, 27 * 8(sp)
    8000110c:	0d813d83          	ld	s11,216(sp)
    ld x28, 28 * 8(sp)
    80001110:	0e013e03          	ld	t3,224(sp)
    ld x29, 29 * 8(sp)
    80001114:	0e813e83          	ld	t4,232(sp)
    ld x30, 30 * 8(sp)
    80001118:	0f013f03          	ld	t5,240(sp)
    ld x31, 31 * 8(sp)
    8000111c:	0f813f83          	ld	t6,248(sp)

    addi sp, sp, 256
    80001120:	10010113          	addi	sp,sp,256

    80001124:	10200073          	sret
	...

0000000080001130 <_ZN5Riscv11pushAllRegsEv>:
.global _ZN5Riscv11pushAllRegsEv
.type _ZN5Riscv11pushAllRegsEv, @function
_ZN5Riscv11pushAllRegsEv:
    addi sp, sp, -256
    80001130:	f0010113          	addi	sp,sp,-256
    sd x3, 3 * 8(sp)
    80001134:	00313c23          	sd	gp,24(sp)
    sd x4, 4 * 8(sp)
    80001138:	02413023          	sd	tp,32(sp)
    sd x5, 5 * 8(sp)
    8000113c:	02513423          	sd	t0,40(sp)
    sd x6, 6 * 8(sp)
    80001140:	02613823          	sd	t1,48(sp)
    sd x7, 7 * 8(sp)
    80001144:	02713c23          	sd	t2,56(sp)
    sd x8, 8 * 8(sp)
    80001148:	04813023          	sd	s0,64(sp)
    sd x9, 9 * 8(sp)
    8000114c:	04913423          	sd	s1,72(sp)
    sd x10, 10 * 8(sp)
    80001150:	04a13823          	sd	a0,80(sp)
    sd x11, 11 * 8(sp)
    80001154:	04b13c23          	sd	a1,88(sp)
    sd x12, 12 * 8(sp)
    80001158:	06c13023          	sd	a2,96(sp)
    sd x13, 13 * 8(sp)
    8000115c:	06d13423          	sd	a3,104(sp)
    sd x14, 14 * 8(sp)
    80001160:	06e13823          	sd	a4,112(sp)
    sd x15, 15 * 8(sp)
    80001164:	06f13c23          	sd	a5,120(sp)
    sd x16, 16 * 8(sp)
    80001168:	09013023          	sd	a6,128(sp)
    sd x17, 17 * 8(sp)
    8000116c:	09113423          	sd	a7,136(sp)
    sd x18, 18 * 8(sp)
    80001170:	09213823          	sd	s2,144(sp)
    sd x19, 19 * 8(sp)
    80001174:	09313c23          	sd	s3,152(sp)
    sd x20, 20 * 8(sp)
    80001178:	0b413023          	sd	s4,160(sp)
    sd x21, 21 * 8(sp)
    8000117c:	0b513423          	sd	s5,168(sp)
    sd x22, 22 * 8(sp)
    80001180:	0b613823          	sd	s6,176(sp)
    sd x23, 23 * 8(sp)
    80001184:	0b713c23          	sd	s7,184(sp)
    sd x24, 24 * 8(sp)
    80001188:	0d813023          	sd	s8,192(sp)
    sd x25, 25 * 8(sp)
    8000118c:	0d913423          	sd	s9,200(sp)
    sd x26, 26 * 8(sp)
    80001190:	0da13823          	sd	s10,208(sp)
    sd x27, 27 * 8(sp)
    80001194:	0db13c23          	sd	s11,216(sp)
    sd x28, 28 * 8(sp)
    80001198:	0fc13023          	sd	t3,224(sp)
    sd x29, 29 * 8(sp)
    8000119c:	0fd13423          	sd	t4,232(sp)
    sd x30, 30 * 8(sp)
    800011a0:	0fe13823          	sd	t5,240(sp)
    sd x31, 31 * 8(sp)
    800011a4:	0ff13c23          	sd	t6,248(sp)

    ret
    800011a8:	00008067          	ret

00000000800011ac <_ZN5Riscv10popAllRegsEv>:

.global _ZN5Riscv10popAllRegsEv
.type _ZN5Riscv10popAllRegsEv, @function
_ZN5Riscv10popAllRegsEv:

    ld x3, 3 * 8(sp)
    800011ac:	01813183          	ld	gp,24(sp)
    ld x4, 4 * 8(sp)
    800011b0:	02013203          	ld	tp,32(sp)
    ld x5, 5 * 8(sp)
    800011b4:	02813283          	ld	t0,40(sp)
    ld x6, 6 * 8(sp)
    800011b8:	03013303          	ld	t1,48(sp)
    ld x7, 7 * 8(sp)
    800011bc:	03813383          	ld	t2,56(sp)
    ld x8, 8 * 8(sp)
    800011c0:	04013403          	ld	s0,64(sp)
    ld x9, 9 * 8(sp)
    800011c4:	04813483          	ld	s1,72(sp)
    ld x10, 10 * 8(sp)
    800011c8:	05013503          	ld	a0,80(sp)
    ld x11, 11 * 8(sp)
    800011cc:	05813583          	ld	a1,88(sp)
    ld x12, 12 * 8(sp)
    800011d0:	06013603          	ld	a2,96(sp)
    ld x13, 13 * 8(sp)
    800011d4:	06813683          	ld	a3,104(sp)
    ld x14, 14 * 8(sp)
    800011d8:	07013703          	ld	a4,112(sp)
    ld x15, 15 * 8(sp)
    800011dc:	07813783          	ld	a5,120(sp)
    ld x16, 16 * 8(sp)
    800011e0:	08013803          	ld	a6,128(sp)
    ld x17, 17 * 8(sp)
    800011e4:	08813883          	ld	a7,136(sp)
    ld x18, 18 * 8(sp)
    800011e8:	09013903          	ld	s2,144(sp)
    ld x19, 19 * 8(sp)
    800011ec:	09813983          	ld	s3,152(sp)
    ld x20, 20 * 8(sp)
    800011f0:	0a013a03          	ld	s4,160(sp)
    ld x21, 21 * 8(sp)
    800011f4:	0a813a83          	ld	s5,168(sp)
    ld x22, 22 * 8(sp)
    800011f8:	0b013b03          	ld	s6,176(sp)
    ld x23, 23 * 8(sp)
    800011fc:	0b813b83          	ld	s7,184(sp)
    ld x24, 24 * 8(sp)
    80001200:	0c013c03          	ld	s8,192(sp)
    ld x25, 25 * 8(sp)
    80001204:	0c813c83          	ld	s9,200(sp)
    ld x26, 26 * 8(sp)
    80001208:	0d013d03          	ld	s10,208(sp)
    ld x27, 27 * 8(sp)
    8000120c:	0d813d83          	ld	s11,216(sp)
    ld x28, 28 * 8(sp)
    80001210:	0e013e03          	ld	t3,224(sp)
    ld x29, 29 * 8(sp)
    80001214:	0e813e83          	ld	t4,232(sp)
    ld x30, 30 * 8(sp)
    80001218:	0f013f03          	ld	t5,240(sp)
    ld x31, 31 * 8(sp)
    8000121c:	0f813f83          	ld	t6,248(sp)

    addi sp, sp, 256
    80001220:	10010113          	addi	sp,sp,256

    80001224:	00008067          	ret

0000000080001228 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd sp, 0 * 8(a0)
    80001228:	00253023          	sd	sp,0(a0) # 1000 <_entry-0x7ffff000>
    sd ra, 1 * 8(a0)
    8000122c:	00153423          	sd	ra,8(a0)

    ld sp, 0 * 8(a1)
    80001230:	0005b103          	ld	sp,0(a1)
    ld ra, 1 * 8(a1)
    80001234:	0085b083          	ld	ra,8(a1)

    80001238:	00008067          	ret

000000008000123c <_Z9mem_allocm>:
#include "../h/syscall_c.hpp"

class _thread;
typedef _thread* thread_t;

void* mem_alloc(size_t size) {
    8000123c:	fe010113          	addi	sp,sp,-32
    80001240:	00813c23          	sd	s0,24(sp)
    80001244:	02010413          	addi	s0,sp,32
    uint64 volatile ptr = 0;
    80001248:	fe043423          	sd	zero,-24(s0)
    size = (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE ? 1 : 0);
    8000124c:	00655793          	srli	a5,a0,0x6
    80001250:	03f57513          	andi	a0,a0,63
    80001254:	00050463          	beqz	a0,8000125c <_Z9mem_allocm+0x20>
    80001258:	00100513          	li	a0,1
    8000125c:	00a78533          	add	a0,a5,a0
    __asm__ volatile ("mv a1, %0" : : "r" (size));
    80001260:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::MEMALLOC));
    80001264:	00100793          	li	a5,1
    80001268:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    8000126c:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ptr));
    80001270:	00050793          	mv	a5,a0
    80001274:	fef43423          	sd	a5,-24(s0)
    return (void*)ptr;
    80001278:	fe843503          	ld	a0,-24(s0)
}
    8000127c:	01813403          	ld	s0,24(sp)
    80001280:	02010113          	addi	sp,sp,32
    80001284:	00008067          	ret

0000000080001288 <_Z8mem_freePv>:

int mem_free(void* ptr) {
    80001288:	fe010113          	addi	sp,sp,-32
    8000128c:	00813c23          	sd	s0,24(sp)
    80001290:	02010413          	addi	s0,sp,32
    int volatile ret = 0;
    80001294:	fe042623          	sw	zero,-20(s0)
    __asm__ volatile ("mv a1, %0" : : "r" (ptr));
    80001298:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::MEMFREE));
    8000129c:	00200793          	li	a5,2
    800012a0:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800012a4:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    800012a8:	00050793          	mv	a5,a0
    800012ac:	fef42623          	sw	a5,-20(s0)
    return ret;
    800012b0:	fec42503          	lw	a0,-20(s0)
}
    800012b4:	0005051b          	sext.w	a0,a0
    800012b8:	01813403          	ld	s0,24(sp)
    800012bc:	02010113          	addi	sp,sp,32
    800012c0:	00008067          	ret

00000000800012c4 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t *handle, void (*start_routine)(void *), void *arg){
    800012c4:	fc010113          	addi	sp,sp,-64
    800012c8:	02113c23          	sd	ra,56(sp)
    800012cc:	02813823          	sd	s0,48(sp)
    800012d0:	02913423          	sd	s1,40(sp)
    800012d4:	03213023          	sd	s2,32(sp)
    800012d8:	01313c23          	sd	s3,24(sp)
    800012dc:	04010413          	addi	s0,sp,64
    800012e0:	00050493          	mv	s1,a0
    800012e4:	00058913          	mv	s2,a1
    800012e8:	00060993          	mv	s3,a2
    int volatile ret = 0;
    800012ec:	fc042623          	sw	zero,-52(s0)
    uint64 stack;
    stack = (uint64)mem_alloc(DEFAULT_STACK_SIZE);
    800012f0:	00001537          	lui	a0,0x1
    800012f4:	00000097          	auipc	ra,0x0
    800012f8:	f48080e7          	jalr	-184(ra) # 8000123c <_Z9mem_allocm>
    __asm__ volatile ("mv a4, %0" : : "r" (stack));
    800012fc:	00050713          	mv	a4,a0
    __asm__ volatile ("mv a3, %0" : : "r" (arg));
    80001300:	00098693          	mv	a3,s3
    __asm__ volatile ("mv a2, %0" : : "r" (start_routine));
    80001304:	00090613          	mv	a2,s2
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    80001308:	00048593          	mv	a1,s1
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::THREADCREATE));
    8000130c:	01100793          	li	a5,17
    80001310:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001314:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001318:	00050793          	mv	a5,a0
    8000131c:	fcf42623          	sw	a5,-52(s0)
    return ret;
    80001320:	fcc42503          	lw	a0,-52(s0)
}
    80001324:	0005051b          	sext.w	a0,a0
    80001328:	03813083          	ld	ra,56(sp)
    8000132c:	03013403          	ld	s0,48(sp)
    80001330:	02813483          	ld	s1,40(sp)
    80001334:	02013903          	ld	s2,32(sp)
    80001338:	01813983          	ld	s3,24(sp)
    8000133c:	04010113          	addi	sp,sp,64
    80001340:	00008067          	ret

0000000080001344 <_Z11thread_exitv>:

int thread_exit(){
    80001344:	fe010113          	addi	sp,sp,-32
    80001348:	00813c23          	sd	s0,24(sp)
    8000134c:	02010413          	addi	s0,sp,32
    int volatile ret = 0;
    80001350:	fe042623          	sw	zero,-20(s0)
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::THREADEXIT));
    80001354:	01200793          	li	a5,18
    80001358:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    8000135c:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001360:	00050793          	mv	a5,a0
    80001364:	fef42623          	sw	a5,-20(s0)
    return ret;
    80001368:	fec42503          	lw	a0,-20(s0)
}
    8000136c:	0005051b          	sext.w	a0,a0
    80001370:	01813403          	ld	s0,24(sp)
    80001374:	02010113          	addi	sp,sp,32
    80001378:	00008067          	ret

000000008000137c <_Z15thread_dispatchv>:

void thread_dispatch(){
    8000137c:	ff010113          	addi	sp,sp,-16
    80001380:	00813423          	sd	s0,8(sp)
    80001384:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::DISPATCH));
    80001388:	01300793          	li	a5,19
    8000138c:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001390:	00000073          	ecall
}
    80001394:	00813403          	ld	s0,8(sp)
    80001398:	01010113          	addi	sp,sp,16
    8000139c:	00008067          	ret

00000000800013a0 <_Z4getcv>:


char getc(){
    800013a0:	fe010113          	addi	sp,sp,-32
    800013a4:	00813c23          	sd	s0,24(sp)
    800013a8:	02010413          	addi	s0,sp,32
    uint64 volatile ret = 0;
    800013ac:	fe043423          	sd	zero,-24(s0)
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::GETC));
    800013b0:	04100793          	li	a5,65
    800013b4:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800013b8:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    800013bc:	00050793          	mv	a5,a0
    800013c0:	fef43423          	sd	a5,-24(s0)
    return (char)ret;
    800013c4:	fe843503          	ld	a0,-24(s0)
}
    800013c8:	0ff57513          	andi	a0,a0,255
    800013cc:	01813403          	ld	s0,24(sp)
    800013d0:	02010113          	addi	sp,sp,32
    800013d4:	00008067          	ret

00000000800013d8 <_Z4putcc>:


void putc(char c){
    800013d8:	ff010113          	addi	sp,sp,-16
    800013dc:	00813423          	sd	s0,8(sp)
    800013e0:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0" : : "r" (c));
    800013e4:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::PUTC));
    800013e8:	04200793          	li	a5,66
    800013ec:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800013f0:	00000073          	ecall
}
    800013f4:	00813403          	ld	s0,8(sp)
    800013f8:	01010113          	addi	sp,sp,16
    800013fc:	00008067          	ret

0000000080001400 <_Z8sem_openPP4_semm>:


int sem_open (sem_t* handle, uint64 init){
    80001400:	fe010113          	addi	sp,sp,-32
    80001404:	00813c23          	sd	s0,24(sp)
    80001408:	02010413          	addi	s0,sp,32
    int volatile ret = 0;
    8000140c:	fe042623          	sw	zero,-20(s0)
    __asm__ volatile ("mv a2, %0" : : "r" (init));
    80001410:	00058613          	mv	a2,a1
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    80001414:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMOPEN));
    80001418:	02100793          	li	a5,33
    8000141c:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001420:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001424:	00050793          	mv	a5,a0
    80001428:	fef42623          	sw	a5,-20(s0)
    return ret;
    8000142c:	fec42503          	lw	a0,-20(s0)
}
    80001430:	0005051b          	sext.w	a0,a0
    80001434:	01813403          	ld	s0,24(sp)
    80001438:	02010113          	addi	sp,sp,32
    8000143c:	00008067          	ret

0000000080001440 <_Z9sem_closeP4_sem>:

int sem_close (sem_t handle){
    80001440:	fe010113          	addi	sp,sp,-32
    80001444:	00813c23          	sd	s0,24(sp)
    80001448:	02010413          	addi	s0,sp,32
    int volatile ret = 0;
    8000144c:	fe042623          	sw	zero,-20(s0)
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    80001450:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMCLOSE));
    80001454:	02200793          	li	a5,34
    80001458:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    8000145c:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001460:	00050793          	mv	a5,a0
    80001464:	fef42623          	sw	a5,-20(s0)
    return ret;
    80001468:	fec42503          	lw	a0,-20(s0)
}
    8000146c:	0005051b          	sext.w	a0,a0
    80001470:	01813403          	ld	s0,24(sp)
    80001474:	02010113          	addi	sp,sp,32
    80001478:	00008067          	ret

000000008000147c <_Z8sem_waitP4_sem>:

int sem_wait (sem_t handle){
    8000147c:	fe010113          	addi	sp,sp,-32
    80001480:	00813c23          	sd	s0,24(sp)
    80001484:	02010413          	addi	s0,sp,32
    int volatile ret = 0;
    80001488:	fe042623          	sw	zero,-20(s0)
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    8000148c:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMWAIT));
    80001490:	02300793          	li	a5,35
    80001494:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001498:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    8000149c:	00050793          	mv	a5,a0
    800014a0:	fef42623          	sw	a5,-20(s0)
    return ret;
    800014a4:	fec42503          	lw	a0,-20(s0)
}
    800014a8:	0005051b          	sext.w	a0,a0
    800014ac:	01813403          	ld	s0,24(sp)
    800014b0:	02010113          	addi	sp,sp,32
    800014b4:	00008067          	ret

00000000800014b8 <_Z10sem_signalP4_sem>:

int sem_signal (sem_t handle){
    800014b8:	fe010113          	addi	sp,sp,-32
    800014bc:	00813c23          	sd	s0,24(sp)
    800014c0:	02010413          	addi	s0,sp,32
    int volatile ret = 0;
    800014c4:	fe042623          	sw	zero,-20(s0)
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    800014c8:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMSIGNAL));
    800014cc:	02400793          	li	a5,36
    800014d0:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800014d4:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    800014d8:	00050793          	mv	a5,a0
    800014dc:	fef42623          	sw	a5,-20(s0)
    return ret;
    800014e0:	fec42503          	lw	a0,-20(s0)
}
    800014e4:	0005051b          	sext.w	a0,a0
    800014e8:	01813403          	ld	s0,24(sp)
    800014ec:	02010113          	addi	sp,sp,32
    800014f0:	00008067          	ret

00000000800014f4 <_Z11sem_trywaitP4_sem>:

int sem_trywait (sem_t handle){
    800014f4:	fe010113          	addi	sp,sp,-32
    800014f8:	00813c23          	sd	s0,24(sp)
    800014fc:	02010413          	addi	s0,sp,32
    int volatile ret = 0;
    80001500:	fe042623          	sw	zero,-20(s0)
    __asm__ volatile ("mv a1, %0" : : "r" (handle));
    80001504:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0" : : "r" (SyscallC::SEMTRYWAIT));
    80001508:	02600793          	li	a5,38
    8000150c:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001510:	00000073          	ecall
    __asm__ volatile ("mv %0, a0" : "=r" (ret));
    80001514:	00050793          	mv	a5,a0
    80001518:	fef42623          	sw	a5,-20(s0)
    return ret;
    8000151c:	fec42503          	lw	a0,-20(s0)
    80001520:	0005051b          	sext.w	a0,a0
    80001524:	01813403          	ld	s0,24(sp)
    80001528:	02010113          	addi	sp,sp,32
    8000152c:	00008067          	ret

0000000080001530 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80001530:	fe010113          	addi	sp,sp,-32
    80001534:	00113c23          	sd	ra,24(sp)
    80001538:	00813823          	sd	s0,16(sp)
    8000153c:	00913423          	sd	s1,8(sp)
    80001540:	01213023          	sd	s2,0(sp)
    80001544:	02010413          	addi	s0,sp,32
    80001548:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000154c:	00000913          	li	s2,0
    80001550:	00c0006f          	j	8000155c <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80001554:	00000097          	auipc	ra,0x0
    80001558:	e28080e7          	jalr	-472(ra) # 8000137c <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    8000155c:	00000097          	auipc	ra,0x0
    80001560:	e44080e7          	jalr	-444(ra) # 800013a0 <_Z4getcv>
    80001564:	0005059b          	sext.w	a1,a0
    80001568:	01b00793          	li	a5,27
    8000156c:	02f58a63          	beq	a1,a5,800015a0 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80001570:	0084b503          	ld	a0,8(s1)
    80001574:	00004097          	auipc	ra,0x4
    80001578:	984080e7          	jalr	-1660(ra) # 80004ef8 <_ZN6Buffer3putEi>
        i++;
    8000157c:	0019071b          	addiw	a4,s2,1
    80001580:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001584:	0004a683          	lw	a3,0(s1)
    80001588:	0026979b          	slliw	a5,a3,0x2
    8000158c:	00d787bb          	addw	a5,a5,a3
    80001590:	0017979b          	slliw	a5,a5,0x1
    80001594:	02f767bb          	remw	a5,a4,a5
    80001598:	fc0792e3          	bnez	a5,8000155c <_ZL16producerKeyboardPv+0x2c>
    8000159c:	fb9ff06f          	j	80001554 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    800015a0:	00100793          	li	a5,1
    800015a4:	00009717          	auipc	a4,0x9
    800015a8:	9af72623          	sw	a5,-1620(a4) # 80009f50 <_ZL9threadEnd>
    data->buffer->put('!');
    800015ac:	02100593          	li	a1,33
    800015b0:	0084b503          	ld	a0,8(s1)
    800015b4:	00004097          	auipc	ra,0x4
    800015b8:	944080e7          	jalr	-1724(ra) # 80004ef8 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    800015bc:	0104b503          	ld	a0,16(s1)
    800015c0:	00000097          	auipc	ra,0x0
    800015c4:	ef8080e7          	jalr	-264(ra) # 800014b8 <_Z10sem_signalP4_sem>
}
    800015c8:	01813083          	ld	ra,24(sp)
    800015cc:	01013403          	ld	s0,16(sp)
    800015d0:	00813483          	ld	s1,8(sp)
    800015d4:	00013903          	ld	s2,0(sp)
    800015d8:	02010113          	addi	sp,sp,32
    800015dc:	00008067          	ret

00000000800015e0 <_ZL8producerPv>:

static void producer(void *arg) {
    800015e0:	fe010113          	addi	sp,sp,-32
    800015e4:	00113c23          	sd	ra,24(sp)
    800015e8:	00813823          	sd	s0,16(sp)
    800015ec:	00913423          	sd	s1,8(sp)
    800015f0:	01213023          	sd	s2,0(sp)
    800015f4:	02010413          	addi	s0,sp,32
    800015f8:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800015fc:	00000913          	li	s2,0
    80001600:	00c0006f          	j	8000160c <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80001604:	00000097          	auipc	ra,0x0
    80001608:	d78080e7          	jalr	-648(ra) # 8000137c <_Z15thread_dispatchv>
    while (!threadEnd) {
    8000160c:	00009797          	auipc	a5,0x9
    80001610:	9447a783          	lw	a5,-1724(a5) # 80009f50 <_ZL9threadEnd>
    80001614:	02079e63          	bnez	a5,80001650 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80001618:	0004a583          	lw	a1,0(s1)
    8000161c:	0305859b          	addiw	a1,a1,48
    80001620:	0084b503          	ld	a0,8(s1)
    80001624:	00004097          	auipc	ra,0x4
    80001628:	8d4080e7          	jalr	-1836(ra) # 80004ef8 <_ZN6Buffer3putEi>
        i++;
    8000162c:	0019071b          	addiw	a4,s2,1
    80001630:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001634:	0004a683          	lw	a3,0(s1)
    80001638:	0026979b          	slliw	a5,a3,0x2
    8000163c:	00d787bb          	addw	a5,a5,a3
    80001640:	0017979b          	slliw	a5,a5,0x1
    80001644:	02f767bb          	remw	a5,a4,a5
    80001648:	fc0792e3          	bnez	a5,8000160c <_ZL8producerPv+0x2c>
    8000164c:	fb9ff06f          	j	80001604 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80001650:	0104b503          	ld	a0,16(s1)
    80001654:	00000097          	auipc	ra,0x0
    80001658:	e64080e7          	jalr	-412(ra) # 800014b8 <_Z10sem_signalP4_sem>
}
    8000165c:	01813083          	ld	ra,24(sp)
    80001660:	01013403          	ld	s0,16(sp)
    80001664:	00813483          	ld	s1,8(sp)
    80001668:	00013903          	ld	s2,0(sp)
    8000166c:	02010113          	addi	sp,sp,32
    80001670:	00008067          	ret

0000000080001674 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80001674:	fd010113          	addi	sp,sp,-48
    80001678:	02113423          	sd	ra,40(sp)
    8000167c:	02813023          	sd	s0,32(sp)
    80001680:	00913c23          	sd	s1,24(sp)
    80001684:	01213823          	sd	s2,16(sp)
    80001688:	01313423          	sd	s3,8(sp)
    8000168c:	03010413          	addi	s0,sp,48
    80001690:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80001694:	00000993          	li	s3,0
    80001698:	01c0006f          	j	800016b4 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    8000169c:	00000097          	auipc	ra,0x0
    800016a0:	ce0080e7          	jalr	-800(ra) # 8000137c <_Z15thread_dispatchv>
    800016a4:	0500006f          	j	800016f4 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800016a8:	00a00513          	li	a0,10
    800016ac:	00000097          	auipc	ra,0x0
    800016b0:	d2c080e7          	jalr	-724(ra) # 800013d8 <_Z4putcc>
    while (!threadEnd) {
    800016b4:	00009797          	auipc	a5,0x9
    800016b8:	89c7a783          	lw	a5,-1892(a5) # 80009f50 <_ZL9threadEnd>
    800016bc:	06079063          	bnez	a5,8000171c <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    800016c0:	00893503          	ld	a0,8(s2)
    800016c4:	00004097          	auipc	ra,0x4
    800016c8:	8c4080e7          	jalr	-1852(ra) # 80004f88 <_ZN6Buffer3getEv>
        i++;
    800016cc:	0019849b          	addiw	s1,s3,1
    800016d0:	0004899b          	sext.w	s3,s1
        putc(key);
    800016d4:	0ff57513          	andi	a0,a0,255
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	d00080e7          	jalr	-768(ra) # 800013d8 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800016e0:	00092703          	lw	a4,0(s2)
    800016e4:	0027179b          	slliw	a5,a4,0x2
    800016e8:	00e787bb          	addw	a5,a5,a4
    800016ec:	02f4e7bb          	remw	a5,s1,a5
    800016f0:	fa0786e3          	beqz	a5,8000169c <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    800016f4:	05000793          	li	a5,80
    800016f8:	02f4e4bb          	remw	s1,s1,a5
    800016fc:	fa049ce3          	bnez	s1,800016b4 <_ZL8consumerPv+0x40>
    80001700:	fa9ff06f          	j	800016a8 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80001704:	00893503          	ld	a0,8(s2)
    80001708:	00004097          	auipc	ra,0x4
    8000170c:	880080e7          	jalr	-1920(ra) # 80004f88 <_ZN6Buffer3getEv>
        putc(key);
    80001710:	0ff57513          	andi	a0,a0,255
    80001714:	00000097          	auipc	ra,0x0
    80001718:	cc4080e7          	jalr	-828(ra) # 800013d8 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    8000171c:	00893503          	ld	a0,8(s2)
    80001720:	00004097          	auipc	ra,0x4
    80001724:	8f4080e7          	jalr	-1804(ra) # 80005014 <_ZN6Buffer6getCntEv>
    80001728:	fca04ee3          	bgtz	a0,80001704 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    8000172c:	01093503          	ld	a0,16(s2)
    80001730:	00000097          	auipc	ra,0x0
    80001734:	d88080e7          	jalr	-632(ra) # 800014b8 <_Z10sem_signalP4_sem>
}
    80001738:	02813083          	ld	ra,40(sp)
    8000173c:	02013403          	ld	s0,32(sp)
    80001740:	01813483          	ld	s1,24(sp)
    80001744:	01013903          	ld	s2,16(sp)
    80001748:	00813983          	ld	s3,8(sp)
    8000174c:	03010113          	addi	sp,sp,48
    80001750:	00008067          	ret

0000000080001754 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80001754:	f9010113          	addi	sp,sp,-112
    80001758:	06113423          	sd	ra,104(sp)
    8000175c:	06813023          	sd	s0,96(sp)
    80001760:	04913c23          	sd	s1,88(sp)
    80001764:	05213823          	sd	s2,80(sp)
    80001768:	05313423          	sd	s3,72(sp)
    8000176c:	05413023          	sd	s4,64(sp)
    80001770:	03513c23          	sd	s5,56(sp)
    80001774:	03613823          	sd	s6,48(sp)
    80001778:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    8000177c:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80001780:	00007517          	auipc	a0,0x7
    80001784:	8a050513          	addi	a0,a0,-1888 # 80008020 <CONSOLE_STATUS+0x10>
    80001788:	00002097          	auipc	ra,0x2
    8000178c:	ca0080e7          	jalr	-864(ra) # 80003428 <_Z11printStringPKc>
    getString(input, 30);
    80001790:	01e00593          	li	a1,30
    80001794:	fa040493          	addi	s1,s0,-96
    80001798:	00048513          	mv	a0,s1
    8000179c:	00002097          	auipc	ra,0x2
    800017a0:	d14080e7          	jalr	-748(ra) # 800034b0 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800017a4:	00048513          	mv	a0,s1
    800017a8:	00002097          	auipc	ra,0x2
    800017ac:	de0080e7          	jalr	-544(ra) # 80003588 <_Z11stringToIntPKc>
    800017b0:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800017b4:	00007517          	auipc	a0,0x7
    800017b8:	88c50513          	addi	a0,a0,-1908 # 80008040 <CONSOLE_STATUS+0x30>
    800017bc:	00002097          	auipc	ra,0x2
    800017c0:	c6c080e7          	jalr	-916(ra) # 80003428 <_Z11printStringPKc>
    getString(input, 30);
    800017c4:	01e00593          	li	a1,30
    800017c8:	00048513          	mv	a0,s1
    800017cc:	00002097          	auipc	ra,0x2
    800017d0:	ce4080e7          	jalr	-796(ra) # 800034b0 <_Z9getStringPci>
    n = stringToInt(input);
    800017d4:	00048513          	mv	a0,s1
    800017d8:	00002097          	auipc	ra,0x2
    800017dc:	db0080e7          	jalr	-592(ra) # 80003588 <_Z11stringToIntPKc>
    800017e0:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800017e4:	00007517          	auipc	a0,0x7
    800017e8:	87c50513          	addi	a0,a0,-1924 # 80008060 <CONSOLE_STATUS+0x50>
    800017ec:	00002097          	auipc	ra,0x2
    800017f0:	c3c080e7          	jalr	-964(ra) # 80003428 <_Z11printStringPKc>
    800017f4:	00000613          	li	a2,0
    800017f8:	00a00593          	li	a1,10
    800017fc:	00090513          	mv	a0,s2
    80001800:	00002097          	auipc	ra,0x2
    80001804:	dd8080e7          	jalr	-552(ra) # 800035d8 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80001808:	00007517          	auipc	a0,0x7
    8000180c:	87050513          	addi	a0,a0,-1936 # 80008078 <CONSOLE_STATUS+0x68>
    80001810:	00002097          	auipc	ra,0x2
    80001814:	c18080e7          	jalr	-1000(ra) # 80003428 <_Z11printStringPKc>
    80001818:	00000613          	li	a2,0
    8000181c:	00a00593          	li	a1,10
    80001820:	00048513          	mv	a0,s1
    80001824:	00002097          	auipc	ra,0x2
    80001828:	db4080e7          	jalr	-588(ra) # 800035d8 <_Z8printIntiii>
    printString(".\n");
    8000182c:	00007517          	auipc	a0,0x7
    80001830:	86450513          	addi	a0,a0,-1948 # 80008090 <CONSOLE_STATUS+0x80>
    80001834:	00002097          	auipc	ra,0x2
    80001838:	bf4080e7          	jalr	-1036(ra) # 80003428 <_Z11printStringPKc>
    if(threadNum > n) {
    8000183c:	0324c463          	blt	s1,s2,80001864 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80001840:	03205c63          	blez	s2,80001878 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80001844:	03800513          	li	a0,56
    80001848:	00002097          	auipc	ra,0x2
    8000184c:	67c080e7          	jalr	1660(ra) # 80003ec4 <_Znwm>
    80001850:	00050a13          	mv	s4,a0
    80001854:	00048593          	mv	a1,s1
    80001858:	00003097          	auipc	ra,0x3
    8000185c:	604080e7          	jalr	1540(ra) # 80004e5c <_ZN6BufferC1Ei>
    80001860:	0300006f          	j	80001890 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80001864:	00007517          	auipc	a0,0x7
    80001868:	83450513          	addi	a0,a0,-1996 # 80008098 <CONSOLE_STATUS+0x88>
    8000186c:	00002097          	auipc	ra,0x2
    80001870:	bbc080e7          	jalr	-1092(ra) # 80003428 <_Z11printStringPKc>
        return;
    80001874:	0140006f          	j	80001888 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80001878:	00007517          	auipc	a0,0x7
    8000187c:	86050513          	addi	a0,a0,-1952 # 800080d8 <CONSOLE_STATUS+0xc8>
    80001880:	00002097          	auipc	ra,0x2
    80001884:	ba8080e7          	jalr	-1112(ra) # 80003428 <_Z11printStringPKc>
        return;
    80001888:	000b0113          	mv	sp,s6
    8000188c:	1500006f          	j	800019dc <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80001890:	00000593          	li	a1,0
    80001894:	00008517          	auipc	a0,0x8
    80001898:	6c450513          	addi	a0,a0,1732 # 80009f58 <_ZL10waitForAll>
    8000189c:	00000097          	auipc	ra,0x0
    800018a0:	b64080e7          	jalr	-1180(ra) # 80001400 <_Z8sem_openPP4_semm>
    thread_t threads[threadNum];
    800018a4:	00391793          	slli	a5,s2,0x3
    800018a8:	00f78793          	addi	a5,a5,15
    800018ac:	ff07f793          	andi	a5,a5,-16
    800018b0:	40f10133          	sub	sp,sp,a5
    800018b4:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800018b8:	0019071b          	addiw	a4,s2,1
    800018bc:	00171793          	slli	a5,a4,0x1
    800018c0:	00e787b3          	add	a5,a5,a4
    800018c4:	00379793          	slli	a5,a5,0x3
    800018c8:	00f78793          	addi	a5,a5,15
    800018cc:	ff07f793          	andi	a5,a5,-16
    800018d0:	40f10133          	sub	sp,sp,a5
    800018d4:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    800018d8:	00191613          	slli	a2,s2,0x1
    800018dc:	012607b3          	add	a5,a2,s2
    800018e0:	00379793          	slli	a5,a5,0x3
    800018e4:	00f987b3          	add	a5,s3,a5
    800018e8:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800018ec:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    800018f0:	00008717          	auipc	a4,0x8
    800018f4:	66873703          	ld	a4,1640(a4) # 80009f58 <_ZL10waitForAll>
    800018f8:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800018fc:	00078613          	mv	a2,a5
    80001900:	00000597          	auipc	a1,0x0
    80001904:	d7458593          	addi	a1,a1,-652 # 80001674 <_ZL8consumerPv>
    80001908:	f9840513          	addi	a0,s0,-104
    8000190c:	00000097          	auipc	ra,0x0
    80001910:	9b8080e7          	jalr	-1608(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80001914:	00000493          	li	s1,0
    80001918:	0280006f          	j	80001940 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    8000191c:	00000597          	auipc	a1,0x0
    80001920:	c1458593          	addi	a1,a1,-1004 # 80001530 <_ZL16producerKeyboardPv>
                      data + i);
    80001924:	00179613          	slli	a2,a5,0x1
    80001928:	00f60633          	add	a2,a2,a5
    8000192c:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80001930:	00c98633          	add	a2,s3,a2
    80001934:	00000097          	auipc	ra,0x0
    80001938:	990080e7          	jalr	-1648(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    8000193c:	0014849b          	addiw	s1,s1,1
    80001940:	0524d263          	bge	s1,s2,80001984 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80001944:	00149793          	slli	a5,s1,0x1
    80001948:	009787b3          	add	a5,a5,s1
    8000194c:	00379793          	slli	a5,a5,0x3
    80001950:	00f987b3          	add	a5,s3,a5
    80001954:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80001958:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    8000195c:	00008717          	auipc	a4,0x8
    80001960:	5fc73703          	ld	a4,1532(a4) # 80009f58 <_ZL10waitForAll>
    80001964:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80001968:	00048793          	mv	a5,s1
    8000196c:	00349513          	slli	a0,s1,0x3
    80001970:	00aa8533          	add	a0,s5,a0
    80001974:	fa9054e3          	blez	s1,8000191c <_Z22producerConsumer_C_APIv+0x1c8>
    80001978:	00000597          	auipc	a1,0x0
    8000197c:	c6858593          	addi	a1,a1,-920 # 800015e0 <_ZL8producerPv>
    80001980:	fa5ff06f          	j	80001924 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80001984:	00000097          	auipc	ra,0x0
    80001988:	9f8080e7          	jalr	-1544(ra) # 8000137c <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    8000198c:	00000493          	li	s1,0
    80001990:	00994e63          	blt	s2,s1,800019ac <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80001994:	00008517          	auipc	a0,0x8
    80001998:	5c453503          	ld	a0,1476(a0) # 80009f58 <_ZL10waitForAll>
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	ae0080e7          	jalr	-1312(ra) # 8000147c <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    800019a4:	0014849b          	addiw	s1,s1,1
    800019a8:	fe9ff06f          	j	80001990 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    800019ac:	00008517          	auipc	a0,0x8
    800019b0:	5ac53503          	ld	a0,1452(a0) # 80009f58 <_ZL10waitForAll>
    800019b4:	00000097          	auipc	ra,0x0
    800019b8:	a8c080e7          	jalr	-1396(ra) # 80001440 <_Z9sem_closeP4_sem>
    delete buffer;
    800019bc:	000a0e63          	beqz	s4,800019d8 <_Z22producerConsumer_C_APIv+0x284>
    800019c0:	000a0513          	mv	a0,s4
    800019c4:	00003097          	auipc	ra,0x3
    800019c8:	6d8080e7          	jalr	1752(ra) # 8000509c <_ZN6BufferD1Ev>
    800019cc:	000a0513          	mv	a0,s4
    800019d0:	00002097          	auipc	ra,0x2
    800019d4:	544080e7          	jalr	1348(ra) # 80003f14 <_ZdlPv>
    800019d8:	000b0113          	mv	sp,s6

}
    800019dc:	f9040113          	addi	sp,s0,-112
    800019e0:	06813083          	ld	ra,104(sp)
    800019e4:	06013403          	ld	s0,96(sp)
    800019e8:	05813483          	ld	s1,88(sp)
    800019ec:	05013903          	ld	s2,80(sp)
    800019f0:	04813983          	ld	s3,72(sp)
    800019f4:	04013a03          	ld	s4,64(sp)
    800019f8:	03813a83          	ld	s5,56(sp)
    800019fc:	03013b03          	ld	s6,48(sp)
    80001a00:	07010113          	addi	sp,sp,112
    80001a04:	00008067          	ret
    80001a08:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80001a0c:	000a0513          	mv	a0,s4
    80001a10:	00002097          	auipc	ra,0x2
    80001a14:	504080e7          	jalr	1284(ra) # 80003f14 <_ZdlPv>
    80001a18:	00048513          	mv	a0,s1
    80001a1c:	00009097          	auipc	ra,0x9
    80001a20:	65c080e7          	jalr	1628(ra) # 8000b078 <_Unwind_Resume>

0000000080001a24 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80001a24:	fe010113          	addi	sp,sp,-32
    80001a28:	00113c23          	sd	ra,24(sp)
    80001a2c:	00813823          	sd	s0,16(sp)
    80001a30:	00913423          	sd	s1,8(sp)
    80001a34:	01213023          	sd	s2,0(sp)
    80001a38:	02010413          	addi	s0,sp,32
    80001a3c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001a40:	00100793          	li	a5,1
    80001a44:	02a7f863          	bgeu	a5,a0,80001a74 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80001a48:	00a00793          	li	a5,10
    80001a4c:	02f577b3          	remu	a5,a0,a5
    80001a50:	02078e63          	beqz	a5,80001a8c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001a54:	fff48513          	addi	a0,s1,-1
    80001a58:	00000097          	auipc	ra,0x0
    80001a5c:	fcc080e7          	jalr	-52(ra) # 80001a24 <_ZL9fibonaccim>
    80001a60:	00050913          	mv	s2,a0
    80001a64:	ffe48513          	addi	a0,s1,-2
    80001a68:	00000097          	auipc	ra,0x0
    80001a6c:	fbc080e7          	jalr	-68(ra) # 80001a24 <_ZL9fibonaccim>
    80001a70:	00a90533          	add	a0,s2,a0
}
    80001a74:	01813083          	ld	ra,24(sp)
    80001a78:	01013403          	ld	s0,16(sp)
    80001a7c:	00813483          	ld	s1,8(sp)
    80001a80:	00013903          	ld	s2,0(sp)
    80001a84:	02010113          	addi	sp,sp,32
    80001a88:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001a8c:	00000097          	auipc	ra,0x0
    80001a90:	8f0080e7          	jalr	-1808(ra) # 8000137c <_Z15thread_dispatchv>
    80001a94:	fc1ff06f          	j	80001a54 <_ZL9fibonaccim+0x30>

0000000080001a98 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80001a98:	fe010113          	addi	sp,sp,-32
    80001a9c:	00113c23          	sd	ra,24(sp)
    80001aa0:	00813823          	sd	s0,16(sp)
    80001aa4:	00913423          	sd	s1,8(sp)
    80001aa8:	01213023          	sd	s2,0(sp)
    80001aac:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001ab0:	00000913          	li	s2,0
    80001ab4:	0380006f          	j	80001aec <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001ab8:	00000097          	auipc	ra,0x0
    80001abc:	8c4080e7          	jalr	-1852(ra) # 8000137c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001ac0:	00148493          	addi	s1,s1,1
    80001ac4:	000027b7          	lui	a5,0x2
    80001ac8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001acc:	0097ee63          	bltu	a5,s1,80001ae8 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001ad0:	00000713          	li	a4,0
    80001ad4:	000077b7          	lui	a5,0x7
    80001ad8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001adc:	fce7eee3          	bltu	a5,a4,80001ab8 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80001ae0:	00170713          	addi	a4,a4,1
    80001ae4:	ff1ff06f          	j	80001ad4 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001ae8:	00190913          	addi	s2,s2,1
    80001aec:	00900793          	li	a5,9
    80001af0:	0527e063          	bltu	a5,s2,80001b30 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001af4:	00006517          	auipc	a0,0x6
    80001af8:	61450513          	addi	a0,a0,1556 # 80008108 <CONSOLE_STATUS+0xf8>
    80001afc:	00002097          	auipc	ra,0x2
    80001b00:	92c080e7          	jalr	-1748(ra) # 80003428 <_Z11printStringPKc>
    80001b04:	00000613          	li	a2,0
    80001b08:	00a00593          	li	a1,10
    80001b0c:	0009051b          	sext.w	a0,s2
    80001b10:	00002097          	auipc	ra,0x2
    80001b14:	ac8080e7          	jalr	-1336(ra) # 800035d8 <_Z8printIntiii>
    80001b18:	00007517          	auipc	a0,0x7
    80001b1c:	87050513          	addi	a0,a0,-1936 # 80008388 <CONSOLE_STATUS+0x378>
    80001b20:	00002097          	auipc	ra,0x2
    80001b24:	908080e7          	jalr	-1784(ra) # 80003428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001b28:	00000493          	li	s1,0
    80001b2c:	f99ff06f          	j	80001ac4 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80001b30:	00006517          	auipc	a0,0x6
    80001b34:	5e050513          	addi	a0,a0,1504 # 80008110 <CONSOLE_STATUS+0x100>
    80001b38:	00002097          	auipc	ra,0x2
    80001b3c:	8f0080e7          	jalr	-1808(ra) # 80003428 <_Z11printStringPKc>
    finishedA = true;
    80001b40:	00100793          	li	a5,1
    80001b44:	00008717          	auipc	a4,0x8
    80001b48:	40f70e23          	sb	a5,1052(a4) # 80009f60 <_ZL9finishedA>
}
    80001b4c:	01813083          	ld	ra,24(sp)
    80001b50:	01013403          	ld	s0,16(sp)
    80001b54:	00813483          	ld	s1,8(sp)
    80001b58:	00013903          	ld	s2,0(sp)
    80001b5c:	02010113          	addi	sp,sp,32
    80001b60:	00008067          	ret

0000000080001b64 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80001b64:	fe010113          	addi	sp,sp,-32
    80001b68:	00113c23          	sd	ra,24(sp)
    80001b6c:	00813823          	sd	s0,16(sp)
    80001b70:	00913423          	sd	s1,8(sp)
    80001b74:	01213023          	sd	s2,0(sp)
    80001b78:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001b7c:	00000913          	li	s2,0
    80001b80:	0380006f          	j	80001bb8 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001b84:	fffff097          	auipc	ra,0xfffff
    80001b88:	7f8080e7          	jalr	2040(ra) # 8000137c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001b8c:	00148493          	addi	s1,s1,1
    80001b90:	000027b7          	lui	a5,0x2
    80001b94:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001b98:	0097ee63          	bltu	a5,s1,80001bb4 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001b9c:	00000713          	li	a4,0
    80001ba0:	000077b7          	lui	a5,0x7
    80001ba4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001ba8:	fce7eee3          	bltu	a5,a4,80001b84 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80001bac:	00170713          	addi	a4,a4,1
    80001bb0:	ff1ff06f          	j	80001ba0 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80001bb4:	00190913          	addi	s2,s2,1
    80001bb8:	00f00793          	li	a5,15
    80001bbc:	0527e063          	bltu	a5,s2,80001bfc <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80001bc0:	00006517          	auipc	a0,0x6
    80001bc4:	56050513          	addi	a0,a0,1376 # 80008120 <CONSOLE_STATUS+0x110>
    80001bc8:	00002097          	auipc	ra,0x2
    80001bcc:	860080e7          	jalr	-1952(ra) # 80003428 <_Z11printStringPKc>
    80001bd0:	00000613          	li	a2,0
    80001bd4:	00a00593          	li	a1,10
    80001bd8:	0009051b          	sext.w	a0,s2
    80001bdc:	00002097          	auipc	ra,0x2
    80001be0:	9fc080e7          	jalr	-1540(ra) # 800035d8 <_Z8printIntiii>
    80001be4:	00006517          	auipc	a0,0x6
    80001be8:	7a450513          	addi	a0,a0,1956 # 80008388 <CONSOLE_STATUS+0x378>
    80001bec:	00002097          	auipc	ra,0x2
    80001bf0:	83c080e7          	jalr	-1988(ra) # 80003428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001bf4:	00000493          	li	s1,0
    80001bf8:	f99ff06f          	j	80001b90 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80001bfc:	00006517          	auipc	a0,0x6
    80001c00:	52c50513          	addi	a0,a0,1324 # 80008128 <CONSOLE_STATUS+0x118>
    80001c04:	00002097          	auipc	ra,0x2
    80001c08:	824080e7          	jalr	-2012(ra) # 80003428 <_Z11printStringPKc>
    finishedB = true;
    80001c0c:	00100793          	li	a5,1
    80001c10:	00008717          	auipc	a4,0x8
    80001c14:	34f708a3          	sb	a5,849(a4) # 80009f61 <_ZL9finishedB>
    thread_dispatch();
    80001c18:	fffff097          	auipc	ra,0xfffff
    80001c1c:	764080e7          	jalr	1892(ra) # 8000137c <_Z15thread_dispatchv>
}
    80001c20:	01813083          	ld	ra,24(sp)
    80001c24:	01013403          	ld	s0,16(sp)
    80001c28:	00813483          	ld	s1,8(sp)
    80001c2c:	00013903          	ld	s2,0(sp)
    80001c30:	02010113          	addi	sp,sp,32
    80001c34:	00008067          	ret

0000000080001c38 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80001c38:	fe010113          	addi	sp,sp,-32
    80001c3c:	00113c23          	sd	ra,24(sp)
    80001c40:	00813823          	sd	s0,16(sp)
    80001c44:	00913423          	sd	s1,8(sp)
    80001c48:	01213023          	sd	s2,0(sp)
    80001c4c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001c50:	00000493          	li	s1,0
    80001c54:	0400006f          	j	80001c94 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001c58:	00006517          	auipc	a0,0x6
    80001c5c:	4e050513          	addi	a0,a0,1248 # 80008138 <CONSOLE_STATUS+0x128>
    80001c60:	00001097          	auipc	ra,0x1
    80001c64:	7c8080e7          	jalr	1992(ra) # 80003428 <_Z11printStringPKc>
    80001c68:	00000613          	li	a2,0
    80001c6c:	00a00593          	li	a1,10
    80001c70:	00048513          	mv	a0,s1
    80001c74:	00002097          	auipc	ra,0x2
    80001c78:	964080e7          	jalr	-1692(ra) # 800035d8 <_Z8printIntiii>
    80001c7c:	00006517          	auipc	a0,0x6
    80001c80:	70c50513          	addi	a0,a0,1804 # 80008388 <CONSOLE_STATUS+0x378>
    80001c84:	00001097          	auipc	ra,0x1
    80001c88:	7a4080e7          	jalr	1956(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001c8c:	0014849b          	addiw	s1,s1,1
    80001c90:	0ff4f493          	andi	s1,s1,255
    80001c94:	00200793          	li	a5,2
    80001c98:	fc97f0e3          	bgeu	a5,s1,80001c58 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80001c9c:	00006517          	auipc	a0,0x6
    80001ca0:	4a450513          	addi	a0,a0,1188 # 80008140 <CONSOLE_STATUS+0x130>
    80001ca4:	00001097          	auipc	ra,0x1
    80001ca8:	784080e7          	jalr	1924(ra) # 80003428 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001cac:	00700313          	li	t1,7
    thread_dispatch();
    80001cb0:	fffff097          	auipc	ra,0xfffff
    80001cb4:	6cc080e7          	jalr	1740(ra) # 8000137c <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001cb8:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80001cbc:	00006517          	auipc	a0,0x6
    80001cc0:	49450513          	addi	a0,a0,1172 # 80008150 <CONSOLE_STATUS+0x140>
    80001cc4:	00001097          	auipc	ra,0x1
    80001cc8:	764080e7          	jalr	1892(ra) # 80003428 <_Z11printStringPKc>
    80001ccc:	00000613          	li	a2,0
    80001cd0:	00a00593          	li	a1,10
    80001cd4:	0009051b          	sext.w	a0,s2
    80001cd8:	00002097          	auipc	ra,0x2
    80001cdc:	900080e7          	jalr	-1792(ra) # 800035d8 <_Z8printIntiii>
    80001ce0:	00006517          	auipc	a0,0x6
    80001ce4:	6a850513          	addi	a0,a0,1704 # 80008388 <CONSOLE_STATUS+0x378>
    80001ce8:	00001097          	auipc	ra,0x1
    80001cec:	740080e7          	jalr	1856(ra) # 80003428 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80001cf0:	00c00513          	li	a0,12
    80001cf4:	00000097          	auipc	ra,0x0
    80001cf8:	d30080e7          	jalr	-720(ra) # 80001a24 <_ZL9fibonaccim>
    80001cfc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001d00:	00006517          	auipc	a0,0x6
    80001d04:	45850513          	addi	a0,a0,1112 # 80008158 <CONSOLE_STATUS+0x148>
    80001d08:	00001097          	auipc	ra,0x1
    80001d0c:	720080e7          	jalr	1824(ra) # 80003428 <_Z11printStringPKc>
    80001d10:	00000613          	li	a2,0
    80001d14:	00a00593          	li	a1,10
    80001d18:	0009051b          	sext.w	a0,s2
    80001d1c:	00002097          	auipc	ra,0x2
    80001d20:	8bc080e7          	jalr	-1860(ra) # 800035d8 <_Z8printIntiii>
    80001d24:	00006517          	auipc	a0,0x6
    80001d28:	66450513          	addi	a0,a0,1636 # 80008388 <CONSOLE_STATUS+0x378>
    80001d2c:	00001097          	auipc	ra,0x1
    80001d30:	6fc080e7          	jalr	1788(ra) # 80003428 <_Z11printStringPKc>
    80001d34:	0400006f          	j	80001d74 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001d38:	00006517          	auipc	a0,0x6
    80001d3c:	40050513          	addi	a0,a0,1024 # 80008138 <CONSOLE_STATUS+0x128>
    80001d40:	00001097          	auipc	ra,0x1
    80001d44:	6e8080e7          	jalr	1768(ra) # 80003428 <_Z11printStringPKc>
    80001d48:	00000613          	li	a2,0
    80001d4c:	00a00593          	li	a1,10
    80001d50:	00048513          	mv	a0,s1
    80001d54:	00002097          	auipc	ra,0x2
    80001d58:	884080e7          	jalr	-1916(ra) # 800035d8 <_Z8printIntiii>
    80001d5c:	00006517          	auipc	a0,0x6
    80001d60:	62c50513          	addi	a0,a0,1580 # 80008388 <CONSOLE_STATUS+0x378>
    80001d64:	00001097          	auipc	ra,0x1
    80001d68:	6c4080e7          	jalr	1732(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001d6c:	0014849b          	addiw	s1,s1,1
    80001d70:	0ff4f493          	andi	s1,s1,255
    80001d74:	00500793          	li	a5,5
    80001d78:	fc97f0e3          	bgeu	a5,s1,80001d38 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80001d7c:	00006517          	auipc	a0,0x6
    80001d80:	39450513          	addi	a0,a0,916 # 80008110 <CONSOLE_STATUS+0x100>
    80001d84:	00001097          	auipc	ra,0x1
    80001d88:	6a4080e7          	jalr	1700(ra) # 80003428 <_Z11printStringPKc>
    finishedC = true;
    80001d8c:	00100793          	li	a5,1
    80001d90:	00008717          	auipc	a4,0x8
    80001d94:	1cf70923          	sb	a5,466(a4) # 80009f62 <_ZL9finishedC>
    thread_dispatch();
    80001d98:	fffff097          	auipc	ra,0xfffff
    80001d9c:	5e4080e7          	jalr	1508(ra) # 8000137c <_Z15thread_dispatchv>
}
    80001da0:	01813083          	ld	ra,24(sp)
    80001da4:	01013403          	ld	s0,16(sp)
    80001da8:	00813483          	ld	s1,8(sp)
    80001dac:	00013903          	ld	s2,0(sp)
    80001db0:	02010113          	addi	sp,sp,32
    80001db4:	00008067          	ret

0000000080001db8 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80001db8:	fe010113          	addi	sp,sp,-32
    80001dbc:	00113c23          	sd	ra,24(sp)
    80001dc0:	00813823          	sd	s0,16(sp)
    80001dc4:	00913423          	sd	s1,8(sp)
    80001dc8:	01213023          	sd	s2,0(sp)
    80001dcc:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001dd0:	00a00493          	li	s1,10
    80001dd4:	0400006f          	j	80001e14 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001dd8:	00006517          	auipc	a0,0x6
    80001ddc:	39050513          	addi	a0,a0,912 # 80008168 <CONSOLE_STATUS+0x158>
    80001de0:	00001097          	auipc	ra,0x1
    80001de4:	648080e7          	jalr	1608(ra) # 80003428 <_Z11printStringPKc>
    80001de8:	00000613          	li	a2,0
    80001dec:	00a00593          	li	a1,10
    80001df0:	00048513          	mv	a0,s1
    80001df4:	00001097          	auipc	ra,0x1
    80001df8:	7e4080e7          	jalr	2020(ra) # 800035d8 <_Z8printIntiii>
    80001dfc:	00006517          	auipc	a0,0x6
    80001e00:	58c50513          	addi	a0,a0,1420 # 80008388 <CONSOLE_STATUS+0x378>
    80001e04:	00001097          	auipc	ra,0x1
    80001e08:	624080e7          	jalr	1572(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001e0c:	0014849b          	addiw	s1,s1,1
    80001e10:	0ff4f493          	andi	s1,s1,255
    80001e14:	00c00793          	li	a5,12
    80001e18:	fc97f0e3          	bgeu	a5,s1,80001dd8 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80001e1c:	00006517          	auipc	a0,0x6
    80001e20:	35450513          	addi	a0,a0,852 # 80008170 <CONSOLE_STATUS+0x160>
    80001e24:	00001097          	auipc	ra,0x1
    80001e28:	604080e7          	jalr	1540(ra) # 80003428 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001e2c:	00500313          	li	t1,5
    thread_dispatch();
    80001e30:	fffff097          	auipc	ra,0xfffff
    80001e34:	54c080e7          	jalr	1356(ra) # 8000137c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001e38:	01000513          	li	a0,16
    80001e3c:	00000097          	auipc	ra,0x0
    80001e40:	be8080e7          	jalr	-1048(ra) # 80001a24 <_ZL9fibonaccim>
    80001e44:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80001e48:	00006517          	auipc	a0,0x6
    80001e4c:	33850513          	addi	a0,a0,824 # 80008180 <CONSOLE_STATUS+0x170>
    80001e50:	00001097          	auipc	ra,0x1
    80001e54:	5d8080e7          	jalr	1496(ra) # 80003428 <_Z11printStringPKc>
    80001e58:	00000613          	li	a2,0
    80001e5c:	00a00593          	li	a1,10
    80001e60:	0009051b          	sext.w	a0,s2
    80001e64:	00001097          	auipc	ra,0x1
    80001e68:	774080e7          	jalr	1908(ra) # 800035d8 <_Z8printIntiii>
    80001e6c:	00006517          	auipc	a0,0x6
    80001e70:	51c50513          	addi	a0,a0,1308 # 80008388 <CONSOLE_STATUS+0x378>
    80001e74:	00001097          	auipc	ra,0x1
    80001e78:	5b4080e7          	jalr	1460(ra) # 80003428 <_Z11printStringPKc>
    80001e7c:	0400006f          	j	80001ebc <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001e80:	00006517          	auipc	a0,0x6
    80001e84:	2e850513          	addi	a0,a0,744 # 80008168 <CONSOLE_STATUS+0x158>
    80001e88:	00001097          	auipc	ra,0x1
    80001e8c:	5a0080e7          	jalr	1440(ra) # 80003428 <_Z11printStringPKc>
    80001e90:	00000613          	li	a2,0
    80001e94:	00a00593          	li	a1,10
    80001e98:	00048513          	mv	a0,s1
    80001e9c:	00001097          	auipc	ra,0x1
    80001ea0:	73c080e7          	jalr	1852(ra) # 800035d8 <_Z8printIntiii>
    80001ea4:	00006517          	auipc	a0,0x6
    80001ea8:	4e450513          	addi	a0,a0,1252 # 80008388 <CONSOLE_STATUS+0x378>
    80001eac:	00001097          	auipc	ra,0x1
    80001eb0:	57c080e7          	jalr	1404(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80001eb4:	0014849b          	addiw	s1,s1,1
    80001eb8:	0ff4f493          	andi	s1,s1,255
    80001ebc:	00f00793          	li	a5,15
    80001ec0:	fc97f0e3          	bgeu	a5,s1,80001e80 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80001ec4:	00006517          	auipc	a0,0x6
    80001ec8:	2cc50513          	addi	a0,a0,716 # 80008190 <CONSOLE_STATUS+0x180>
    80001ecc:	00001097          	auipc	ra,0x1
    80001ed0:	55c080e7          	jalr	1372(ra) # 80003428 <_Z11printStringPKc>
    finishedD = true;
    80001ed4:	00100793          	li	a5,1
    80001ed8:	00008717          	auipc	a4,0x8
    80001edc:	08f705a3          	sb	a5,139(a4) # 80009f63 <_ZL9finishedD>
    thread_dispatch();
    80001ee0:	fffff097          	auipc	ra,0xfffff
    80001ee4:	49c080e7          	jalr	1180(ra) # 8000137c <_Z15thread_dispatchv>
}
    80001ee8:	01813083          	ld	ra,24(sp)
    80001eec:	01013403          	ld	s0,16(sp)
    80001ef0:	00813483          	ld	s1,8(sp)
    80001ef4:	00013903          	ld	s2,0(sp)
    80001ef8:	02010113          	addi	sp,sp,32
    80001efc:	00008067          	ret

0000000080001f00 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80001f00:	fc010113          	addi	sp,sp,-64
    80001f04:	02113c23          	sd	ra,56(sp)
    80001f08:	02813823          	sd	s0,48(sp)
    80001f0c:	02913423          	sd	s1,40(sp)
    80001f10:	03213023          	sd	s2,32(sp)
    80001f14:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80001f18:	02000513          	li	a0,32
    80001f1c:	00002097          	auipc	ra,0x2
    80001f20:	fa8080e7          	jalr	-88(ra) # 80003ec4 <_Znwm>
    80001f24:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80001f28:	00002097          	auipc	ra,0x2
    80001f2c:	12c080e7          	jalr	300(ra) # 80004054 <_ZN6ThreadC1Ev>
    80001f30:	00008797          	auipc	a5,0x8
    80001f34:	e3878793          	addi	a5,a5,-456 # 80009d68 <_ZTV7WorkerA+0x10>
    80001f38:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80001f3c:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80001f40:	00006517          	auipc	a0,0x6
    80001f44:	26050513          	addi	a0,a0,608 # 800081a0 <CONSOLE_STATUS+0x190>
    80001f48:	00001097          	auipc	ra,0x1
    80001f4c:	4e0080e7          	jalr	1248(ra) # 80003428 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80001f50:	02000513          	li	a0,32
    80001f54:	00002097          	auipc	ra,0x2
    80001f58:	f70080e7          	jalr	-144(ra) # 80003ec4 <_Znwm>
    80001f5c:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80001f60:	00002097          	auipc	ra,0x2
    80001f64:	0f4080e7          	jalr	244(ra) # 80004054 <_ZN6ThreadC1Ev>
    80001f68:	00008797          	auipc	a5,0x8
    80001f6c:	e2878793          	addi	a5,a5,-472 # 80009d90 <_ZTV7WorkerB+0x10>
    80001f70:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80001f74:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80001f78:	00006517          	auipc	a0,0x6
    80001f7c:	24050513          	addi	a0,a0,576 # 800081b8 <CONSOLE_STATUS+0x1a8>
    80001f80:	00001097          	auipc	ra,0x1
    80001f84:	4a8080e7          	jalr	1192(ra) # 80003428 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80001f88:	02000513          	li	a0,32
    80001f8c:	00002097          	auipc	ra,0x2
    80001f90:	f38080e7          	jalr	-200(ra) # 80003ec4 <_Znwm>
    80001f94:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80001f98:	00002097          	auipc	ra,0x2
    80001f9c:	0bc080e7          	jalr	188(ra) # 80004054 <_ZN6ThreadC1Ev>
    80001fa0:	00008797          	auipc	a5,0x8
    80001fa4:	e1878793          	addi	a5,a5,-488 # 80009db8 <_ZTV7WorkerC+0x10>
    80001fa8:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80001fac:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80001fb0:	00006517          	auipc	a0,0x6
    80001fb4:	22050513          	addi	a0,a0,544 # 800081d0 <CONSOLE_STATUS+0x1c0>
    80001fb8:	00001097          	auipc	ra,0x1
    80001fbc:	470080e7          	jalr	1136(ra) # 80003428 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80001fc0:	02000513          	li	a0,32
    80001fc4:	00002097          	auipc	ra,0x2
    80001fc8:	f00080e7          	jalr	-256(ra) # 80003ec4 <_Znwm>
    80001fcc:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80001fd0:	00002097          	auipc	ra,0x2
    80001fd4:	084080e7          	jalr	132(ra) # 80004054 <_ZN6ThreadC1Ev>
    80001fd8:	00008797          	auipc	a5,0x8
    80001fdc:	e0878793          	addi	a5,a5,-504 # 80009de0 <_ZTV7WorkerD+0x10>
    80001fe0:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80001fe4:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80001fe8:	00006517          	auipc	a0,0x6
    80001fec:	20050513          	addi	a0,a0,512 # 800081e8 <CONSOLE_STATUS+0x1d8>
    80001ff0:	00001097          	auipc	ra,0x1
    80001ff4:	438080e7          	jalr	1080(ra) # 80003428 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80001ff8:	00000493          	li	s1,0
    80001ffc:	00300793          	li	a5,3
    80002000:	0297c663          	blt	a5,s1,8000202c <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80002004:	00349793          	slli	a5,s1,0x3
    80002008:	fe040713          	addi	a4,s0,-32
    8000200c:	00f707b3          	add	a5,a4,a5
    80002010:	fe07b503          	ld	a0,-32(a5)
    80002014:	00002097          	auipc	ra,0x2
    80002018:	fe4080e7          	jalr	-28(ra) # 80003ff8 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    8000201c:	0014849b          	addiw	s1,s1,1
    80002020:	fddff06f          	j	80001ffc <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80002024:	00002097          	auipc	ra,0x2
    80002028:	008080e7          	jalr	8(ra) # 8000402c <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000202c:	00008797          	auipc	a5,0x8
    80002030:	f347c783          	lbu	a5,-204(a5) # 80009f60 <_ZL9finishedA>
    80002034:	fe0788e3          	beqz	a5,80002024 <_Z20Threads_CPP_API_testv+0x124>
    80002038:	00008797          	auipc	a5,0x8
    8000203c:	f297c783          	lbu	a5,-215(a5) # 80009f61 <_ZL9finishedB>
    80002040:	fe0782e3          	beqz	a5,80002024 <_Z20Threads_CPP_API_testv+0x124>
    80002044:	00008797          	auipc	a5,0x8
    80002048:	f1e7c783          	lbu	a5,-226(a5) # 80009f62 <_ZL9finishedC>
    8000204c:	fc078ce3          	beqz	a5,80002024 <_Z20Threads_CPP_API_testv+0x124>
    80002050:	00008797          	auipc	a5,0x8
    80002054:	f137c783          	lbu	a5,-237(a5) # 80009f63 <_ZL9finishedD>
    80002058:	fc0786e3          	beqz	a5,80002024 <_Z20Threads_CPP_API_testv+0x124>
    8000205c:	fc040493          	addi	s1,s0,-64
    80002060:	0080006f          	j	80002068 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002064:	00848493          	addi	s1,s1,8
    80002068:	fe040793          	addi	a5,s0,-32
    8000206c:	08f48663          	beq	s1,a5,800020f8 <_Z20Threads_CPP_API_testv+0x1f8>
    80002070:	0004b503          	ld	a0,0(s1)
    80002074:	fe0508e3          	beqz	a0,80002064 <_Z20Threads_CPP_API_testv+0x164>
    80002078:	00053783          	ld	a5,0(a0)
    8000207c:	0087b783          	ld	a5,8(a5)
    80002080:	000780e7          	jalr	a5
    80002084:	fe1ff06f          	j	80002064 <_Z20Threads_CPP_API_testv+0x164>
    80002088:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    8000208c:	00048513          	mv	a0,s1
    80002090:	00002097          	auipc	ra,0x2
    80002094:	e84080e7          	jalr	-380(ra) # 80003f14 <_ZdlPv>
    80002098:	00090513          	mv	a0,s2
    8000209c:	00009097          	auipc	ra,0x9
    800020a0:	fdc080e7          	jalr	-36(ra) # 8000b078 <_Unwind_Resume>
    800020a4:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    800020a8:	00048513          	mv	a0,s1
    800020ac:	00002097          	auipc	ra,0x2
    800020b0:	e68080e7          	jalr	-408(ra) # 80003f14 <_ZdlPv>
    800020b4:	00090513          	mv	a0,s2
    800020b8:	00009097          	auipc	ra,0x9
    800020bc:	fc0080e7          	jalr	-64(ra) # 8000b078 <_Unwind_Resume>
    800020c0:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    800020c4:	00048513          	mv	a0,s1
    800020c8:	00002097          	auipc	ra,0x2
    800020cc:	e4c080e7          	jalr	-436(ra) # 80003f14 <_ZdlPv>
    800020d0:	00090513          	mv	a0,s2
    800020d4:	00009097          	auipc	ra,0x9
    800020d8:	fa4080e7          	jalr	-92(ra) # 8000b078 <_Unwind_Resume>
    800020dc:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    800020e0:	00048513          	mv	a0,s1
    800020e4:	00002097          	auipc	ra,0x2
    800020e8:	e30080e7          	jalr	-464(ra) # 80003f14 <_ZdlPv>
    800020ec:	00090513          	mv	a0,s2
    800020f0:	00009097          	auipc	ra,0x9
    800020f4:	f88080e7          	jalr	-120(ra) # 8000b078 <_Unwind_Resume>
}
    800020f8:	03813083          	ld	ra,56(sp)
    800020fc:	03013403          	ld	s0,48(sp)
    80002100:	02813483          	ld	s1,40(sp)
    80002104:	02013903          	ld	s2,32(sp)
    80002108:	04010113          	addi	sp,sp,64
    8000210c:	00008067          	ret

0000000080002110 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80002110:	ff010113          	addi	sp,sp,-16
    80002114:	00113423          	sd	ra,8(sp)
    80002118:	00813023          	sd	s0,0(sp)
    8000211c:	01010413          	addi	s0,sp,16
    80002120:	00008797          	auipc	a5,0x8
    80002124:	c4878793          	addi	a5,a5,-952 # 80009d68 <_ZTV7WorkerA+0x10>
    80002128:	00f53023          	sd	a5,0(a0)
    8000212c:	00002097          	auipc	ra,0x2
    80002130:	d48080e7          	jalr	-696(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80002134:	00813083          	ld	ra,8(sp)
    80002138:	00013403          	ld	s0,0(sp)
    8000213c:	01010113          	addi	sp,sp,16
    80002140:	00008067          	ret

0000000080002144 <_ZN7WorkerAD0Ev>:
    80002144:	fe010113          	addi	sp,sp,-32
    80002148:	00113c23          	sd	ra,24(sp)
    8000214c:	00813823          	sd	s0,16(sp)
    80002150:	00913423          	sd	s1,8(sp)
    80002154:	02010413          	addi	s0,sp,32
    80002158:	00050493          	mv	s1,a0
    8000215c:	00008797          	auipc	a5,0x8
    80002160:	c0c78793          	addi	a5,a5,-1012 # 80009d68 <_ZTV7WorkerA+0x10>
    80002164:	00f53023          	sd	a5,0(a0)
    80002168:	00002097          	auipc	ra,0x2
    8000216c:	d0c080e7          	jalr	-756(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80002170:	00048513          	mv	a0,s1
    80002174:	00002097          	auipc	ra,0x2
    80002178:	da0080e7          	jalr	-608(ra) # 80003f14 <_ZdlPv>
    8000217c:	01813083          	ld	ra,24(sp)
    80002180:	01013403          	ld	s0,16(sp)
    80002184:	00813483          	ld	s1,8(sp)
    80002188:	02010113          	addi	sp,sp,32
    8000218c:	00008067          	ret

0000000080002190 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002190:	ff010113          	addi	sp,sp,-16
    80002194:	00113423          	sd	ra,8(sp)
    80002198:	00813023          	sd	s0,0(sp)
    8000219c:	01010413          	addi	s0,sp,16
    800021a0:	00008797          	auipc	a5,0x8
    800021a4:	bf078793          	addi	a5,a5,-1040 # 80009d90 <_ZTV7WorkerB+0x10>
    800021a8:	00f53023          	sd	a5,0(a0)
    800021ac:	00002097          	auipc	ra,0x2
    800021b0:	cc8080e7          	jalr	-824(ra) # 80003e74 <_ZN6ThreadD1Ev>
    800021b4:	00813083          	ld	ra,8(sp)
    800021b8:	00013403          	ld	s0,0(sp)
    800021bc:	01010113          	addi	sp,sp,16
    800021c0:	00008067          	ret

00000000800021c4 <_ZN7WorkerBD0Ev>:
    800021c4:	fe010113          	addi	sp,sp,-32
    800021c8:	00113c23          	sd	ra,24(sp)
    800021cc:	00813823          	sd	s0,16(sp)
    800021d0:	00913423          	sd	s1,8(sp)
    800021d4:	02010413          	addi	s0,sp,32
    800021d8:	00050493          	mv	s1,a0
    800021dc:	00008797          	auipc	a5,0x8
    800021e0:	bb478793          	addi	a5,a5,-1100 # 80009d90 <_ZTV7WorkerB+0x10>
    800021e4:	00f53023          	sd	a5,0(a0)
    800021e8:	00002097          	auipc	ra,0x2
    800021ec:	c8c080e7          	jalr	-884(ra) # 80003e74 <_ZN6ThreadD1Ev>
    800021f0:	00048513          	mv	a0,s1
    800021f4:	00002097          	auipc	ra,0x2
    800021f8:	d20080e7          	jalr	-736(ra) # 80003f14 <_ZdlPv>
    800021fc:	01813083          	ld	ra,24(sp)
    80002200:	01013403          	ld	s0,16(sp)
    80002204:	00813483          	ld	s1,8(sp)
    80002208:	02010113          	addi	sp,sp,32
    8000220c:	00008067          	ret

0000000080002210 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80002210:	ff010113          	addi	sp,sp,-16
    80002214:	00113423          	sd	ra,8(sp)
    80002218:	00813023          	sd	s0,0(sp)
    8000221c:	01010413          	addi	s0,sp,16
    80002220:	00008797          	auipc	a5,0x8
    80002224:	b9878793          	addi	a5,a5,-1128 # 80009db8 <_ZTV7WorkerC+0x10>
    80002228:	00f53023          	sd	a5,0(a0)
    8000222c:	00002097          	auipc	ra,0x2
    80002230:	c48080e7          	jalr	-952(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80002234:	00813083          	ld	ra,8(sp)
    80002238:	00013403          	ld	s0,0(sp)
    8000223c:	01010113          	addi	sp,sp,16
    80002240:	00008067          	ret

0000000080002244 <_ZN7WorkerCD0Ev>:
    80002244:	fe010113          	addi	sp,sp,-32
    80002248:	00113c23          	sd	ra,24(sp)
    8000224c:	00813823          	sd	s0,16(sp)
    80002250:	00913423          	sd	s1,8(sp)
    80002254:	02010413          	addi	s0,sp,32
    80002258:	00050493          	mv	s1,a0
    8000225c:	00008797          	auipc	a5,0x8
    80002260:	b5c78793          	addi	a5,a5,-1188 # 80009db8 <_ZTV7WorkerC+0x10>
    80002264:	00f53023          	sd	a5,0(a0)
    80002268:	00002097          	auipc	ra,0x2
    8000226c:	c0c080e7          	jalr	-1012(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80002270:	00048513          	mv	a0,s1
    80002274:	00002097          	auipc	ra,0x2
    80002278:	ca0080e7          	jalr	-864(ra) # 80003f14 <_ZdlPv>
    8000227c:	01813083          	ld	ra,24(sp)
    80002280:	01013403          	ld	s0,16(sp)
    80002284:	00813483          	ld	s1,8(sp)
    80002288:	02010113          	addi	sp,sp,32
    8000228c:	00008067          	ret

0000000080002290 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002290:	ff010113          	addi	sp,sp,-16
    80002294:	00113423          	sd	ra,8(sp)
    80002298:	00813023          	sd	s0,0(sp)
    8000229c:	01010413          	addi	s0,sp,16
    800022a0:	00008797          	auipc	a5,0x8
    800022a4:	b4078793          	addi	a5,a5,-1216 # 80009de0 <_ZTV7WorkerD+0x10>
    800022a8:	00f53023          	sd	a5,0(a0)
    800022ac:	00002097          	auipc	ra,0x2
    800022b0:	bc8080e7          	jalr	-1080(ra) # 80003e74 <_ZN6ThreadD1Ev>
    800022b4:	00813083          	ld	ra,8(sp)
    800022b8:	00013403          	ld	s0,0(sp)
    800022bc:	01010113          	addi	sp,sp,16
    800022c0:	00008067          	ret

00000000800022c4 <_ZN7WorkerDD0Ev>:
    800022c4:	fe010113          	addi	sp,sp,-32
    800022c8:	00113c23          	sd	ra,24(sp)
    800022cc:	00813823          	sd	s0,16(sp)
    800022d0:	00913423          	sd	s1,8(sp)
    800022d4:	02010413          	addi	s0,sp,32
    800022d8:	00050493          	mv	s1,a0
    800022dc:	00008797          	auipc	a5,0x8
    800022e0:	b0478793          	addi	a5,a5,-1276 # 80009de0 <_ZTV7WorkerD+0x10>
    800022e4:	00f53023          	sd	a5,0(a0)
    800022e8:	00002097          	auipc	ra,0x2
    800022ec:	b8c080e7          	jalr	-1140(ra) # 80003e74 <_ZN6ThreadD1Ev>
    800022f0:	00048513          	mv	a0,s1
    800022f4:	00002097          	auipc	ra,0x2
    800022f8:	c20080e7          	jalr	-992(ra) # 80003f14 <_ZdlPv>
    800022fc:	01813083          	ld	ra,24(sp)
    80002300:	01013403          	ld	s0,16(sp)
    80002304:	00813483          	ld	s1,8(sp)
    80002308:	02010113          	addi	sp,sp,32
    8000230c:	00008067          	ret

0000000080002310 <_ZN7WorkerA3runEv>:
    void run() override {
    80002310:	ff010113          	addi	sp,sp,-16
    80002314:	00113423          	sd	ra,8(sp)
    80002318:	00813023          	sd	s0,0(sp)
    8000231c:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002320:	00000593          	li	a1,0
    80002324:	fffff097          	auipc	ra,0xfffff
    80002328:	774080e7          	jalr	1908(ra) # 80001a98 <_ZN7WorkerA11workerBodyAEPv>
    }
    8000232c:	00813083          	ld	ra,8(sp)
    80002330:	00013403          	ld	s0,0(sp)
    80002334:	01010113          	addi	sp,sp,16
    80002338:	00008067          	ret

000000008000233c <_ZN7WorkerB3runEv>:
    void run() override {
    8000233c:	ff010113          	addi	sp,sp,-16
    80002340:	00113423          	sd	ra,8(sp)
    80002344:	00813023          	sd	s0,0(sp)
    80002348:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    8000234c:	00000593          	li	a1,0
    80002350:	00000097          	auipc	ra,0x0
    80002354:	814080e7          	jalr	-2028(ra) # 80001b64 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002358:	00813083          	ld	ra,8(sp)
    8000235c:	00013403          	ld	s0,0(sp)
    80002360:	01010113          	addi	sp,sp,16
    80002364:	00008067          	ret

0000000080002368 <_ZN7WorkerC3runEv>:
    void run() override {
    80002368:	ff010113          	addi	sp,sp,-16
    8000236c:	00113423          	sd	ra,8(sp)
    80002370:	00813023          	sd	s0,0(sp)
    80002374:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002378:	00000593          	li	a1,0
    8000237c:	00000097          	auipc	ra,0x0
    80002380:	8bc080e7          	jalr	-1860(ra) # 80001c38 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002384:	00813083          	ld	ra,8(sp)
    80002388:	00013403          	ld	s0,0(sp)
    8000238c:	01010113          	addi	sp,sp,16
    80002390:	00008067          	ret

0000000080002394 <_ZN7WorkerD3runEv>:
    void run() override {
    80002394:	ff010113          	addi	sp,sp,-16
    80002398:	00113423          	sd	ra,8(sp)
    8000239c:	00813023          	sd	s0,0(sp)
    800023a0:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800023a4:	00000593          	li	a1,0
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	a10080e7          	jalr	-1520(ra) # 80001db8 <_ZN7WorkerD11workerBodyDEPv>
    }
    800023b0:	00813083          	ld	ra,8(sp)
    800023b4:	00013403          	ld	s0,0(sp)
    800023b8:	01010113          	addi	sp,sp,16
    800023bc:	00008067          	ret

00000000800023c0 <_ZN3Sem8sem_openEm>:
// Created by os on 9/3/24.
//

#include "../h/semaphore.hpp"

Sem* Sem::sem_open(uint64 val){
    800023c0:	fe010113          	addi	sp,sp,-32
    800023c4:	00113c23          	sd	ra,24(sp)
    800023c8:	00813823          	sd	s0,16(sp)
    800023cc:	00913423          	sd	s1,8(sp)
    800023d0:	02010413          	addi	s0,sp,32
    800023d4:	00050493          	mv	s1,a0
    return new Sem(val);
    800023d8:	01000513          	li	a0,16
    800023dc:	00002097          	auipc	ra,0x2
    800023e0:	ae8080e7          	jalr	-1304(ra) # 80003ec4 <_Znwm>
private:

    int val;
    List blocked;

    Sem(uint64 val) : val(val) {}
    800023e4:	00952023          	sw	s1,0(a0)
        elem* next;
    }Elem;

    Elem* head;

    List () : head(0) {};
    800023e8:	00053423          	sd	zero,8(a0)
}
    800023ec:	01813083          	ld	ra,24(sp)
    800023f0:	01013403          	ld	s0,16(sp)
    800023f4:	00813483          	ld	s1,8(sp)
    800023f8:	02010113          	addi	sp,sp,32
    800023fc:	00008067          	ret

0000000080002400 <_ZN3Sem9sem_closeEv>:

void Sem::sem_close() {
    80002400:	fe010113          	addi	sp,sp,-32
    80002404:	00113c23          	sd	ra,24(sp)
    80002408:	00813823          	sd	s0,16(sp)
    8000240c:	00913423          	sd	s1,8(sp)
    80002410:	01213023          	sd	s2,0(sp)
    80002414:	02010413          	addi	s0,sp,32
    80002418:	00050913          	mv	s2,a0
        tmpElem = 0;
        return tmpTCB;
    }

    TCB* peekFront () {
        if (head == 0) return 0;
    8000241c:	00893503          	ld	a0,8(s2)
    80002420:	02050663          	beqz	a0,8000244c <_ZN3Sem9sem_closeEv+0x4c>
        return head->data;
    80002424:	00053483          	ld	s1,0(a0)
    TCB* curr = 0;
    while (blocked.peekFront()){
    80002428:	02048263          	beqz	s1,8000244c <_ZN3Sem9sem_closeEv+0x4c>
        head = head->next;
    8000242c:	00853783          	ld	a5,8(a0)
    80002430:	00f93423          	sd	a5,8(s2)
        if(mem_free(tmpElem)) {};
    80002434:	fffff097          	auipc	ra,0xfffff
    80002438:	e54080e7          	jalr	-428(ra) # 80001288 <_Z8mem_freePv>
        curr = blocked.popFront();
        Scheduler::put(curr);
    8000243c:	00048513          	mv	a0,s1
    80002440:	00002097          	auipc	ra,0x2
    80002444:	178080e7          	jalr	376(ra) # 800045b8 <_ZN9Scheduler3putEP3TCB>
    while (blocked.peekFront()){
    80002448:	fd5ff06f          	j	8000241c <_ZN3Sem9sem_closeEv+0x1c>
    }
}
    8000244c:	01813083          	ld	ra,24(sp)
    80002450:	01013403          	ld	s0,16(sp)
    80002454:	00813483          	ld	s1,8(sp)
    80002458:	00013903          	ld	s2,0(sp)
    8000245c:	02010113          	addi	sp,sp,32
    80002460:	00008067          	ret

0000000080002464 <_ZN3Sem8sem_waitEv>:

void Sem::sem_wait() {
    80002464:	fe010113          	addi	sp,sp,-32
    80002468:	00113c23          	sd	ra,24(sp)
    8000246c:	00813823          	sd	s0,16(sp)
    80002470:	00913423          	sd	s1,8(sp)
    80002474:	01213023          	sd	s2,0(sp)
    80002478:	02010413          	addi	s0,sp,32
    TCB* curr = TCB::running;
    8000247c:	00008797          	auipc	a5,0x8
    80002480:	a7c7b783          	ld	a5,-1412(a5) # 80009ef8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002484:	0007b903          	ld	s2,0(a5)
    if (--val < 0) {
    80002488:	00052783          	lw	a5,0(a0)
    8000248c:	fff7879b          	addiw	a5,a5,-1
    80002490:	00f52023          	sw	a5,0(a0)
    80002494:	02079713          	slli	a4,a5,0x20
    80002498:	00074e63          	bltz	a4,800024b4 <_ZN3Sem8sem_waitEv+0x50>
        curr->setActive(0);
        blocked.addRear(curr);
        TCB::dispatch();
    }
}
    8000249c:	01813083          	ld	ra,24(sp)
    800024a0:	01013403          	ld	s0,16(sp)
    800024a4:	00813483          	ld	s1,8(sp)
    800024a8:	00013903          	ld	s2,0(sp)
    800024ac:	02010113          	addi	sp,sp,32
    800024b0:	00008067          	ret
    800024b4:	00050493          	mv	s1,a0

    bool getFinished () const { return finished; }
    void setFinished (bool val) { finished = val; }

    bool getActive () const { return active; }
    void setActive (bool val) { active = val; }
    800024b8:	02090423          	sb	zero,40(s2)
        Elem* newElem = (Elem*)mem_alloc(sizeof(Elem));
    800024bc:	01000513          	li	a0,16
    800024c0:	fffff097          	auipc	ra,0xfffff
    800024c4:	d7c080e7          	jalr	-644(ra) # 8000123c <_Z9mem_allocm>
        newElem->data = data;
    800024c8:	01253023          	sd	s2,0(a0)
        newElem->next = 0;
    800024cc:	00053423          	sd	zero,8(a0)
        if (head) {
    800024d0:	0084b783          	ld	a5,8(s1)
    800024d4:	02078063          	beqz	a5,800024f4 <_ZN3Sem8sem_waitEv+0x90>
            for (curr = head; curr->next != 0; curr = curr->next);
    800024d8:	00078713          	mv	a4,a5
    800024dc:	0087b783          	ld	a5,8(a5)
    800024e0:	fe079ce3          	bnez	a5,800024d8 <_ZN3Sem8sem_waitEv+0x74>
            curr->next = newElem;
    800024e4:	00a73423          	sd	a0,8(a4)
        TCB::dispatch();
    800024e8:	00002097          	auipc	ra,0x2
    800024ec:	91c080e7          	jalr	-1764(ra) # 80003e04 <_ZN3TCB8dispatchEv>
}
    800024f0:	fadff06f          	j	8000249c <_ZN3Sem8sem_waitEv+0x38>
        else head = newElem;
    800024f4:	00a4b423          	sd	a0,8(s1)
    800024f8:	ff1ff06f          	j	800024e8 <_ZN3Sem8sem_waitEv+0x84>

00000000800024fc <_ZN3Sem10sem_signalEv>:

void Sem::sem_signal() {
    if (++val <= 0 && blocked.peekFront()){
    800024fc:	00052783          	lw	a5,0(a0)
    80002500:	0017879b          	addiw	a5,a5,1
    80002504:	0007871b          	sext.w	a4,a5
    80002508:	00f52023          	sw	a5,0(a0)
    8000250c:	00e05463          	blez	a4,80002514 <_ZN3Sem10sem_signalEv+0x18>
    80002510:	00008067          	ret
        if (head == 0) return 0;
    80002514:	00853783          	ld	a5,8(a0)
    80002518:	fe078ce3          	beqz	a5,80002510 <_ZN3Sem10sem_signalEv+0x14>
        return head->data;
    8000251c:	0007b783          	ld	a5,0(a5)
    80002520:	fe0788e3          	beqz	a5,80002510 <_ZN3Sem10sem_signalEv+0x14>
void Sem::sem_signal() {
    80002524:	fe010113          	addi	sp,sp,-32
    80002528:	00113c23          	sd	ra,24(sp)
    8000252c:	00813823          	sd	s0,16(sp)
    80002530:	00913423          	sd	s1,8(sp)
    80002534:	02010413          	addi	s0,sp,32
    80002538:	00100713          	li	a4,1
    8000253c:	02e78423          	sb	a4,40(a5)
        if (head == 0) return 0;
    80002540:	00853783          	ld	a5,8(a0)
    80002544:	02078e63          	beqz	a5,80002580 <_ZN3Sem10sem_signalEv+0x84>
        TCB* tmpTCB = head->data;
    80002548:	0007b483          	ld	s1,0(a5)
        head = head->next;
    8000254c:	0087b703          	ld	a4,8(a5)
    80002550:	00e53423          	sd	a4,8(a0)
        if(mem_free(tmpElem)) {};
    80002554:	00078513          	mv	a0,a5
    80002558:	fffff097          	auipc	ra,0xfffff
    8000255c:	d30080e7          	jalr	-720(ra) # 80001288 <_Z8mem_freePv>
        blocked.peekFront()->setActive(1);
        Scheduler::put(blocked.popFront());
    80002560:	00048513          	mv	a0,s1
    80002564:	00002097          	auipc	ra,0x2
    80002568:	054080e7          	jalr	84(ra) # 800045b8 <_ZN9Scheduler3putEP3TCB>
    }
}
    8000256c:	01813083          	ld	ra,24(sp)
    80002570:	01013403          	ld	s0,16(sp)
    80002574:	00813483          	ld	s1,8(sp)
    80002578:	02010113          	addi	sp,sp,32
    8000257c:	00008067          	ret
        if (head == 0) return 0;
    80002580:	00078493          	mv	s1,a5
    80002584:	fddff06f          	j	80002560 <_ZN3Sem10sem_signalEv+0x64>

0000000080002588 <_ZN3Sem11sem_trywaitEv>:

int Sem::sem_trywait() {
    80002588:	ff010113          	addi	sp,sp,-16
    8000258c:	00813423          	sd	s0,8(sp)
    80002590:	01010413          	addi	s0,sp,16
    val--;
    80002594:	00052703          	lw	a4,0(a0)
    80002598:	fff7079b          	addiw	a5,a4,-1
    8000259c:	00f52023          	sw	a5,0(a0)
    if (val < 0)
    800025a0:	02079693          	slli	a3,a5,0x20
    800025a4:	0006ca63          	bltz	a3,800025b8 <_ZN3Sem11sem_trywaitEv+0x30>
    {
        val++;
        return 1;
    }
    else return 0;
    800025a8:	00000513          	li	a0,0
}
    800025ac:	00813403          	ld	s0,8(sp)
    800025b0:	01010113          	addi	sp,sp,16
    800025b4:	00008067          	ret
        val++;
    800025b8:	00e52023          	sw	a4,0(a0)
        return 1;
    800025bc:	00100513          	li	a0,1
    800025c0:	fedff06f          	j	800025ac <_ZN3Sem11sem_trywaitEv+0x24>

00000000800025c4 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800025c4:	fe010113          	addi	sp,sp,-32
    800025c8:	00113c23          	sd	ra,24(sp)
    800025cc:	00813823          	sd	s0,16(sp)
    800025d0:	00913423          	sd	s1,8(sp)
    800025d4:	01213023          	sd	s2,0(sp)
    800025d8:	02010413          	addi	s0,sp,32
    800025dc:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800025e0:	00100793          	li	a5,1
    800025e4:	02a7f863          	bgeu	a5,a0,80002614 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800025e8:	00a00793          	li	a5,10
    800025ec:	02f577b3          	remu	a5,a0,a5
    800025f0:	02078e63          	beqz	a5,8000262c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800025f4:	fff48513          	addi	a0,s1,-1
    800025f8:	00000097          	auipc	ra,0x0
    800025fc:	fcc080e7          	jalr	-52(ra) # 800025c4 <_ZL9fibonaccim>
    80002600:	00050913          	mv	s2,a0
    80002604:	ffe48513          	addi	a0,s1,-2
    80002608:	00000097          	auipc	ra,0x0
    8000260c:	fbc080e7          	jalr	-68(ra) # 800025c4 <_ZL9fibonaccim>
    80002610:	00a90533          	add	a0,s2,a0
}
    80002614:	01813083          	ld	ra,24(sp)
    80002618:	01013403          	ld	s0,16(sp)
    8000261c:	00813483          	ld	s1,8(sp)
    80002620:	00013903          	ld	s2,0(sp)
    80002624:	02010113          	addi	sp,sp,32
    80002628:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000262c:	fffff097          	auipc	ra,0xfffff
    80002630:	d50080e7          	jalr	-688(ra) # 8000137c <_Z15thread_dispatchv>
    80002634:	fc1ff06f          	j	800025f4 <_ZL9fibonaccim+0x30>

0000000080002638 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002638:	fe010113          	addi	sp,sp,-32
    8000263c:	00113c23          	sd	ra,24(sp)
    80002640:	00813823          	sd	s0,16(sp)
    80002644:	00913423          	sd	s1,8(sp)
    80002648:	01213023          	sd	s2,0(sp)
    8000264c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002650:	00a00493          	li	s1,10
    80002654:	0400006f          	j	80002694 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002658:	00006517          	auipc	a0,0x6
    8000265c:	b1050513          	addi	a0,a0,-1264 # 80008168 <CONSOLE_STATUS+0x158>
    80002660:	00001097          	auipc	ra,0x1
    80002664:	dc8080e7          	jalr	-568(ra) # 80003428 <_Z11printStringPKc>
    80002668:	00000613          	li	a2,0
    8000266c:	00a00593          	li	a1,10
    80002670:	00048513          	mv	a0,s1
    80002674:	00001097          	auipc	ra,0x1
    80002678:	f64080e7          	jalr	-156(ra) # 800035d8 <_Z8printIntiii>
    8000267c:	00006517          	auipc	a0,0x6
    80002680:	d0c50513          	addi	a0,a0,-756 # 80008388 <CONSOLE_STATUS+0x378>
    80002684:	00001097          	auipc	ra,0x1
    80002688:	da4080e7          	jalr	-604(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000268c:	0014849b          	addiw	s1,s1,1
    80002690:	0ff4f493          	andi	s1,s1,255
    80002694:	00c00793          	li	a5,12
    80002698:	fc97f0e3          	bgeu	a5,s1,80002658 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000269c:	00006517          	auipc	a0,0x6
    800026a0:	ad450513          	addi	a0,a0,-1324 # 80008170 <CONSOLE_STATUS+0x160>
    800026a4:	00001097          	auipc	ra,0x1
    800026a8:	d84080e7          	jalr	-636(ra) # 80003428 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800026ac:	00500313          	li	t1,5
    thread_dispatch();
    800026b0:	fffff097          	auipc	ra,0xfffff
    800026b4:	ccc080e7          	jalr	-820(ra) # 8000137c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800026b8:	01000513          	li	a0,16
    800026bc:	00000097          	auipc	ra,0x0
    800026c0:	f08080e7          	jalr	-248(ra) # 800025c4 <_ZL9fibonaccim>
    800026c4:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800026c8:	00006517          	auipc	a0,0x6
    800026cc:	ab850513          	addi	a0,a0,-1352 # 80008180 <CONSOLE_STATUS+0x170>
    800026d0:	00001097          	auipc	ra,0x1
    800026d4:	d58080e7          	jalr	-680(ra) # 80003428 <_Z11printStringPKc>
    800026d8:	00000613          	li	a2,0
    800026dc:	00a00593          	li	a1,10
    800026e0:	0009051b          	sext.w	a0,s2
    800026e4:	00001097          	auipc	ra,0x1
    800026e8:	ef4080e7          	jalr	-268(ra) # 800035d8 <_Z8printIntiii>
    800026ec:	00006517          	auipc	a0,0x6
    800026f0:	c9c50513          	addi	a0,a0,-868 # 80008388 <CONSOLE_STATUS+0x378>
    800026f4:	00001097          	auipc	ra,0x1
    800026f8:	d34080e7          	jalr	-716(ra) # 80003428 <_Z11printStringPKc>
    800026fc:	0400006f          	j	8000273c <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002700:	00006517          	auipc	a0,0x6
    80002704:	a6850513          	addi	a0,a0,-1432 # 80008168 <CONSOLE_STATUS+0x158>
    80002708:	00001097          	auipc	ra,0x1
    8000270c:	d20080e7          	jalr	-736(ra) # 80003428 <_Z11printStringPKc>
    80002710:	00000613          	li	a2,0
    80002714:	00a00593          	li	a1,10
    80002718:	00048513          	mv	a0,s1
    8000271c:	00001097          	auipc	ra,0x1
    80002720:	ebc080e7          	jalr	-324(ra) # 800035d8 <_Z8printIntiii>
    80002724:	00006517          	auipc	a0,0x6
    80002728:	c6450513          	addi	a0,a0,-924 # 80008388 <CONSOLE_STATUS+0x378>
    8000272c:	00001097          	auipc	ra,0x1
    80002730:	cfc080e7          	jalr	-772(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002734:	0014849b          	addiw	s1,s1,1
    80002738:	0ff4f493          	andi	s1,s1,255
    8000273c:	00f00793          	li	a5,15
    80002740:	fc97f0e3          	bgeu	a5,s1,80002700 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002744:	00006517          	auipc	a0,0x6
    80002748:	a4c50513          	addi	a0,a0,-1460 # 80008190 <CONSOLE_STATUS+0x180>
    8000274c:	00001097          	auipc	ra,0x1
    80002750:	cdc080e7          	jalr	-804(ra) # 80003428 <_Z11printStringPKc>
    finishedD = true;
    80002754:	00100793          	li	a5,1
    80002758:	00008717          	auipc	a4,0x8
    8000275c:	80f70623          	sb	a5,-2036(a4) # 80009f64 <_ZL9finishedD>
    thread_dispatch();
    80002760:	fffff097          	auipc	ra,0xfffff
    80002764:	c1c080e7          	jalr	-996(ra) # 8000137c <_Z15thread_dispatchv>
}
    80002768:	01813083          	ld	ra,24(sp)
    8000276c:	01013403          	ld	s0,16(sp)
    80002770:	00813483          	ld	s1,8(sp)
    80002774:	00013903          	ld	s2,0(sp)
    80002778:	02010113          	addi	sp,sp,32
    8000277c:	00008067          	ret

0000000080002780 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80002780:	fe010113          	addi	sp,sp,-32
    80002784:	00113c23          	sd	ra,24(sp)
    80002788:	00813823          	sd	s0,16(sp)
    8000278c:	00913423          	sd	s1,8(sp)
    80002790:	01213023          	sd	s2,0(sp)
    80002794:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002798:	00000493          	li	s1,0
    8000279c:	0400006f          	j	800027dc <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800027a0:	00006517          	auipc	a0,0x6
    800027a4:	99850513          	addi	a0,a0,-1640 # 80008138 <CONSOLE_STATUS+0x128>
    800027a8:	00001097          	auipc	ra,0x1
    800027ac:	c80080e7          	jalr	-896(ra) # 80003428 <_Z11printStringPKc>
    800027b0:	00000613          	li	a2,0
    800027b4:	00a00593          	li	a1,10
    800027b8:	00048513          	mv	a0,s1
    800027bc:	00001097          	auipc	ra,0x1
    800027c0:	e1c080e7          	jalr	-484(ra) # 800035d8 <_Z8printIntiii>
    800027c4:	00006517          	auipc	a0,0x6
    800027c8:	bc450513          	addi	a0,a0,-1084 # 80008388 <CONSOLE_STATUS+0x378>
    800027cc:	00001097          	auipc	ra,0x1
    800027d0:	c5c080e7          	jalr	-932(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800027d4:	0014849b          	addiw	s1,s1,1
    800027d8:	0ff4f493          	andi	s1,s1,255
    800027dc:	00200793          	li	a5,2
    800027e0:	fc97f0e3          	bgeu	a5,s1,800027a0 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800027e4:	00006517          	auipc	a0,0x6
    800027e8:	95c50513          	addi	a0,a0,-1700 # 80008140 <CONSOLE_STATUS+0x130>
    800027ec:	00001097          	auipc	ra,0x1
    800027f0:	c3c080e7          	jalr	-964(ra) # 80003428 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800027f4:	00700313          	li	t1,7
    thread_dispatch();
    800027f8:	fffff097          	auipc	ra,0xfffff
    800027fc:	b84080e7          	jalr	-1148(ra) # 8000137c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002800:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80002804:	00006517          	auipc	a0,0x6
    80002808:	94c50513          	addi	a0,a0,-1716 # 80008150 <CONSOLE_STATUS+0x140>
    8000280c:	00001097          	auipc	ra,0x1
    80002810:	c1c080e7          	jalr	-996(ra) # 80003428 <_Z11printStringPKc>
    80002814:	00000613          	li	a2,0
    80002818:	00a00593          	li	a1,10
    8000281c:	0009051b          	sext.w	a0,s2
    80002820:	00001097          	auipc	ra,0x1
    80002824:	db8080e7          	jalr	-584(ra) # 800035d8 <_Z8printIntiii>
    80002828:	00006517          	auipc	a0,0x6
    8000282c:	b6050513          	addi	a0,a0,-1184 # 80008388 <CONSOLE_STATUS+0x378>
    80002830:	00001097          	auipc	ra,0x1
    80002834:	bf8080e7          	jalr	-1032(ra) # 80003428 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80002838:	00c00513          	li	a0,12
    8000283c:	00000097          	auipc	ra,0x0
    80002840:	d88080e7          	jalr	-632(ra) # 800025c4 <_ZL9fibonaccim>
    80002844:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002848:	00006517          	auipc	a0,0x6
    8000284c:	91050513          	addi	a0,a0,-1776 # 80008158 <CONSOLE_STATUS+0x148>
    80002850:	00001097          	auipc	ra,0x1
    80002854:	bd8080e7          	jalr	-1064(ra) # 80003428 <_Z11printStringPKc>
    80002858:	00000613          	li	a2,0
    8000285c:	00a00593          	li	a1,10
    80002860:	0009051b          	sext.w	a0,s2
    80002864:	00001097          	auipc	ra,0x1
    80002868:	d74080e7          	jalr	-652(ra) # 800035d8 <_Z8printIntiii>
    8000286c:	00006517          	auipc	a0,0x6
    80002870:	b1c50513          	addi	a0,a0,-1252 # 80008388 <CONSOLE_STATUS+0x378>
    80002874:	00001097          	auipc	ra,0x1
    80002878:	bb4080e7          	jalr	-1100(ra) # 80003428 <_Z11printStringPKc>
    8000287c:	0400006f          	j	800028bc <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80002880:	00006517          	auipc	a0,0x6
    80002884:	8b850513          	addi	a0,a0,-1864 # 80008138 <CONSOLE_STATUS+0x128>
    80002888:	00001097          	auipc	ra,0x1
    8000288c:	ba0080e7          	jalr	-1120(ra) # 80003428 <_Z11printStringPKc>
    80002890:	00000613          	li	a2,0
    80002894:	00a00593          	li	a1,10
    80002898:	00048513          	mv	a0,s1
    8000289c:	00001097          	auipc	ra,0x1
    800028a0:	d3c080e7          	jalr	-708(ra) # 800035d8 <_Z8printIntiii>
    800028a4:	00006517          	auipc	a0,0x6
    800028a8:	ae450513          	addi	a0,a0,-1308 # 80008388 <CONSOLE_STATUS+0x378>
    800028ac:	00001097          	auipc	ra,0x1
    800028b0:	b7c080e7          	jalr	-1156(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800028b4:	0014849b          	addiw	s1,s1,1
    800028b8:	0ff4f493          	andi	s1,s1,255
    800028bc:	00500793          	li	a5,5
    800028c0:	fc97f0e3          	bgeu	a5,s1,80002880 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    800028c4:	00006517          	auipc	a0,0x6
    800028c8:	84c50513          	addi	a0,a0,-1972 # 80008110 <CONSOLE_STATUS+0x100>
    800028cc:	00001097          	auipc	ra,0x1
    800028d0:	b5c080e7          	jalr	-1188(ra) # 80003428 <_Z11printStringPKc>
    finishedC = true;
    800028d4:	00100793          	li	a5,1
    800028d8:	00007717          	auipc	a4,0x7
    800028dc:	68f706a3          	sb	a5,1677(a4) # 80009f65 <_ZL9finishedC>
    thread_dispatch();
    800028e0:	fffff097          	auipc	ra,0xfffff
    800028e4:	a9c080e7          	jalr	-1380(ra) # 8000137c <_Z15thread_dispatchv>
}
    800028e8:	01813083          	ld	ra,24(sp)
    800028ec:	01013403          	ld	s0,16(sp)
    800028f0:	00813483          	ld	s1,8(sp)
    800028f4:	00013903          	ld	s2,0(sp)
    800028f8:	02010113          	addi	sp,sp,32
    800028fc:	00008067          	ret

0000000080002900 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80002900:	fe010113          	addi	sp,sp,-32
    80002904:	00113c23          	sd	ra,24(sp)
    80002908:	00813823          	sd	s0,16(sp)
    8000290c:	00913423          	sd	s1,8(sp)
    80002910:	01213023          	sd	s2,0(sp)
    80002914:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002918:	00000913          	li	s2,0
    8000291c:	0380006f          	j	80002954 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80002920:	fffff097          	auipc	ra,0xfffff
    80002924:	a5c080e7          	jalr	-1444(ra) # 8000137c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002928:	00148493          	addi	s1,s1,1
    8000292c:	000027b7          	lui	a5,0x2
    80002930:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002934:	0097ee63          	bltu	a5,s1,80002950 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002938:	00000713          	li	a4,0
    8000293c:	000077b7          	lui	a5,0x7
    80002940:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002944:	fce7eee3          	bltu	a5,a4,80002920 <_ZL11workerBodyBPv+0x20>
    80002948:	00170713          	addi	a4,a4,1
    8000294c:	ff1ff06f          	j	8000293c <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002950:	00190913          	addi	s2,s2,1
    80002954:	00f00793          	li	a5,15
    80002958:	0527e063          	bltu	a5,s2,80002998 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000295c:	00005517          	auipc	a0,0x5
    80002960:	7c450513          	addi	a0,a0,1988 # 80008120 <CONSOLE_STATUS+0x110>
    80002964:	00001097          	auipc	ra,0x1
    80002968:	ac4080e7          	jalr	-1340(ra) # 80003428 <_Z11printStringPKc>
    8000296c:	00000613          	li	a2,0
    80002970:	00a00593          	li	a1,10
    80002974:	0009051b          	sext.w	a0,s2
    80002978:	00001097          	auipc	ra,0x1
    8000297c:	c60080e7          	jalr	-928(ra) # 800035d8 <_Z8printIntiii>
    80002980:	00006517          	auipc	a0,0x6
    80002984:	a0850513          	addi	a0,a0,-1528 # 80008388 <CONSOLE_STATUS+0x378>
    80002988:	00001097          	auipc	ra,0x1
    8000298c:	aa0080e7          	jalr	-1376(ra) # 80003428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002990:	00000493          	li	s1,0
    80002994:	f99ff06f          	j	8000292c <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80002998:	00005517          	auipc	a0,0x5
    8000299c:	79050513          	addi	a0,a0,1936 # 80008128 <CONSOLE_STATUS+0x118>
    800029a0:	00001097          	auipc	ra,0x1
    800029a4:	a88080e7          	jalr	-1400(ra) # 80003428 <_Z11printStringPKc>
    finishedB = true;
    800029a8:	00100793          	li	a5,1
    800029ac:	00007717          	auipc	a4,0x7
    800029b0:	5af70d23          	sb	a5,1466(a4) # 80009f66 <_ZL9finishedB>
    thread_dispatch();
    800029b4:	fffff097          	auipc	ra,0xfffff
    800029b8:	9c8080e7          	jalr	-1592(ra) # 8000137c <_Z15thread_dispatchv>
}
    800029bc:	01813083          	ld	ra,24(sp)
    800029c0:	01013403          	ld	s0,16(sp)
    800029c4:	00813483          	ld	s1,8(sp)
    800029c8:	00013903          	ld	s2,0(sp)
    800029cc:	02010113          	addi	sp,sp,32
    800029d0:	00008067          	ret

00000000800029d4 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800029d4:	fe010113          	addi	sp,sp,-32
    800029d8:	00113c23          	sd	ra,24(sp)
    800029dc:	00813823          	sd	s0,16(sp)
    800029e0:	00913423          	sd	s1,8(sp)
    800029e4:	01213023          	sd	s2,0(sp)
    800029e8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800029ec:	00000913          	li	s2,0
    800029f0:	0380006f          	j	80002a28 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800029f4:	fffff097          	auipc	ra,0xfffff
    800029f8:	988080e7          	jalr	-1656(ra) # 8000137c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800029fc:	00148493          	addi	s1,s1,1
    80002a00:	000027b7          	lui	a5,0x2
    80002a04:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002a08:	0097ee63          	bltu	a5,s1,80002a24 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002a0c:	00000713          	li	a4,0
    80002a10:	000077b7          	lui	a5,0x7
    80002a14:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002a18:	fce7eee3          	bltu	a5,a4,800029f4 <_ZL11workerBodyAPv+0x20>
    80002a1c:	00170713          	addi	a4,a4,1
    80002a20:	ff1ff06f          	j	80002a10 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002a24:	00190913          	addi	s2,s2,1
    80002a28:	00900793          	li	a5,9
    80002a2c:	0527e063          	bltu	a5,s2,80002a6c <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80002a30:	00005517          	auipc	a0,0x5
    80002a34:	6d850513          	addi	a0,a0,1752 # 80008108 <CONSOLE_STATUS+0xf8>
    80002a38:	00001097          	auipc	ra,0x1
    80002a3c:	9f0080e7          	jalr	-1552(ra) # 80003428 <_Z11printStringPKc>
    80002a40:	00000613          	li	a2,0
    80002a44:	00a00593          	li	a1,10
    80002a48:	0009051b          	sext.w	a0,s2
    80002a4c:	00001097          	auipc	ra,0x1
    80002a50:	b8c080e7          	jalr	-1140(ra) # 800035d8 <_Z8printIntiii>
    80002a54:	00006517          	auipc	a0,0x6
    80002a58:	93450513          	addi	a0,a0,-1740 # 80008388 <CONSOLE_STATUS+0x378>
    80002a5c:	00001097          	auipc	ra,0x1
    80002a60:	9cc080e7          	jalr	-1588(ra) # 80003428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002a64:	00000493          	li	s1,0
    80002a68:	f99ff06f          	j	80002a00 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80002a6c:	00005517          	auipc	a0,0x5
    80002a70:	6a450513          	addi	a0,a0,1700 # 80008110 <CONSOLE_STATUS+0x100>
    80002a74:	00001097          	auipc	ra,0x1
    80002a78:	9b4080e7          	jalr	-1612(ra) # 80003428 <_Z11printStringPKc>
    finishedA = true;
    80002a7c:	00100793          	li	a5,1
    80002a80:	00007717          	auipc	a4,0x7
    80002a84:	4ef703a3          	sb	a5,1255(a4) # 80009f67 <_ZL9finishedA>
}
    80002a88:	01813083          	ld	ra,24(sp)
    80002a8c:	01013403          	ld	s0,16(sp)
    80002a90:	00813483          	ld	s1,8(sp)
    80002a94:	00013903          	ld	s2,0(sp)
    80002a98:	02010113          	addi	sp,sp,32
    80002a9c:	00008067          	ret

0000000080002aa0 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80002aa0:	fd010113          	addi	sp,sp,-48
    80002aa4:	02113423          	sd	ra,40(sp)
    80002aa8:	02813023          	sd	s0,32(sp)
    80002aac:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80002ab0:	00000613          	li	a2,0
    80002ab4:	00000597          	auipc	a1,0x0
    80002ab8:	f2058593          	addi	a1,a1,-224 # 800029d4 <_ZL11workerBodyAPv>
    80002abc:	fd040513          	addi	a0,s0,-48
    80002ac0:	fffff097          	auipc	ra,0xfffff
    80002ac4:	804080e7          	jalr	-2044(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80002ac8:	00005517          	auipc	a0,0x5
    80002acc:	6d850513          	addi	a0,a0,1752 # 800081a0 <CONSOLE_STATUS+0x190>
    80002ad0:	00001097          	auipc	ra,0x1
    80002ad4:	958080e7          	jalr	-1704(ra) # 80003428 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80002ad8:	00000613          	li	a2,0
    80002adc:	00000597          	auipc	a1,0x0
    80002ae0:	e2458593          	addi	a1,a1,-476 # 80002900 <_ZL11workerBodyBPv>
    80002ae4:	fd840513          	addi	a0,s0,-40
    80002ae8:	ffffe097          	auipc	ra,0xffffe
    80002aec:	7dc080e7          	jalr	2012(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80002af0:	00005517          	auipc	a0,0x5
    80002af4:	6c850513          	addi	a0,a0,1736 # 800081b8 <CONSOLE_STATUS+0x1a8>
    80002af8:	00001097          	auipc	ra,0x1
    80002afc:	930080e7          	jalr	-1744(ra) # 80003428 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80002b00:	00000613          	li	a2,0
    80002b04:	00000597          	auipc	a1,0x0
    80002b08:	c7c58593          	addi	a1,a1,-900 # 80002780 <_ZL11workerBodyCPv>
    80002b0c:	fe040513          	addi	a0,s0,-32
    80002b10:	ffffe097          	auipc	ra,0xffffe
    80002b14:	7b4080e7          	jalr	1972(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80002b18:	00005517          	auipc	a0,0x5
    80002b1c:	6b850513          	addi	a0,a0,1720 # 800081d0 <CONSOLE_STATUS+0x1c0>
    80002b20:	00001097          	auipc	ra,0x1
    80002b24:	908080e7          	jalr	-1784(ra) # 80003428 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80002b28:	00000613          	li	a2,0
    80002b2c:	00000597          	auipc	a1,0x0
    80002b30:	b0c58593          	addi	a1,a1,-1268 # 80002638 <_ZL11workerBodyDPv>
    80002b34:	fe840513          	addi	a0,s0,-24
    80002b38:	ffffe097          	auipc	ra,0xffffe
    80002b3c:	78c080e7          	jalr	1932(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80002b40:	00005517          	auipc	a0,0x5
    80002b44:	6a850513          	addi	a0,a0,1704 # 800081e8 <CONSOLE_STATUS+0x1d8>
    80002b48:	00001097          	auipc	ra,0x1
    80002b4c:	8e0080e7          	jalr	-1824(ra) # 80003428 <_Z11printStringPKc>
    80002b50:	00c0006f          	j	80002b5c <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80002b54:	fffff097          	auipc	ra,0xfffff
    80002b58:	828080e7          	jalr	-2008(ra) # 8000137c <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002b5c:	00007797          	auipc	a5,0x7
    80002b60:	40b7c783          	lbu	a5,1035(a5) # 80009f67 <_ZL9finishedA>
    80002b64:	fe0788e3          	beqz	a5,80002b54 <_Z18Threads_C_API_testv+0xb4>
    80002b68:	00007797          	auipc	a5,0x7
    80002b6c:	3fe7c783          	lbu	a5,1022(a5) # 80009f66 <_ZL9finishedB>
    80002b70:	fe0782e3          	beqz	a5,80002b54 <_Z18Threads_C_API_testv+0xb4>
    80002b74:	00007797          	auipc	a5,0x7
    80002b78:	3f17c783          	lbu	a5,1009(a5) # 80009f65 <_ZL9finishedC>
    80002b7c:	fc078ce3          	beqz	a5,80002b54 <_Z18Threads_C_API_testv+0xb4>
    80002b80:	00007797          	auipc	a5,0x7
    80002b84:	3e47c783          	lbu	a5,996(a5) # 80009f64 <_ZL9finishedD>
    80002b88:	fc0786e3          	beqz	a5,80002b54 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80002b8c:	02813083          	ld	ra,40(sp)
    80002b90:	02013403          	ld	s0,32(sp)
    80002b94:	03010113          	addi	sp,sp,48
    80002b98:	00008067          	ret

0000000080002b9c <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80002b9c:	fd010113          	addi	sp,sp,-48
    80002ba0:	02113423          	sd	ra,40(sp)
    80002ba4:	02813023          	sd	s0,32(sp)
    80002ba8:	00913c23          	sd	s1,24(sp)
    80002bac:	01213823          	sd	s2,16(sp)
    80002bb0:	01313423          	sd	s3,8(sp)
    80002bb4:	03010413          	addi	s0,sp,48
    80002bb8:	00050993          	mv	s3,a0
    80002bbc:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002bc0:	00000913          	li	s2,0
    80002bc4:	00c0006f          	j	80002bd0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80002bc8:	00001097          	auipc	ra,0x1
    80002bcc:	464080e7          	jalr	1124(ra) # 8000402c <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80002bd0:	ffffe097          	auipc	ra,0xffffe
    80002bd4:	7d0080e7          	jalr	2000(ra) # 800013a0 <_Z4getcv>
    80002bd8:	0005059b          	sext.w	a1,a0
    80002bdc:	01b00793          	li	a5,27
    80002be0:	02f58a63          	beq	a1,a5,80002c14 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80002be4:	0084b503          	ld	a0,8(s1)
    80002be8:	00001097          	auipc	ra,0x1
    80002bec:	c64080e7          	jalr	-924(ra) # 8000384c <_ZN9BufferCPP3putEi>
        i++;
    80002bf0:	0019071b          	addiw	a4,s2,1
    80002bf4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002bf8:	0004a683          	lw	a3,0(s1)
    80002bfc:	0026979b          	slliw	a5,a3,0x2
    80002c00:	00d787bb          	addw	a5,a5,a3
    80002c04:	0017979b          	slliw	a5,a5,0x1
    80002c08:	02f767bb          	remw	a5,a4,a5
    80002c0c:	fc0792e3          	bnez	a5,80002bd0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80002c10:	fb9ff06f          	j	80002bc8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80002c14:	00100793          	li	a5,1
    80002c18:	00007717          	auipc	a4,0x7
    80002c1c:	34f72823          	sw	a5,848(a4) # 80009f68 <_ZL9threadEnd>
    td->buffer->put('!');
    80002c20:	0209b783          	ld	a5,32(s3)
    80002c24:	02100593          	li	a1,33
    80002c28:	0087b503          	ld	a0,8(a5)
    80002c2c:	00001097          	auipc	ra,0x1
    80002c30:	c20080e7          	jalr	-992(ra) # 8000384c <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80002c34:	0104b503          	ld	a0,16(s1)
    80002c38:	00001097          	auipc	ra,0x1
    80002c3c:	4bc080e7          	jalr	1212(ra) # 800040f4 <_ZN9Semaphore6signalEv>
}
    80002c40:	02813083          	ld	ra,40(sp)
    80002c44:	02013403          	ld	s0,32(sp)
    80002c48:	01813483          	ld	s1,24(sp)
    80002c4c:	01013903          	ld	s2,16(sp)
    80002c50:	00813983          	ld	s3,8(sp)
    80002c54:	03010113          	addi	sp,sp,48
    80002c58:	00008067          	ret

0000000080002c5c <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80002c5c:	fe010113          	addi	sp,sp,-32
    80002c60:	00113c23          	sd	ra,24(sp)
    80002c64:	00813823          	sd	s0,16(sp)
    80002c68:	00913423          	sd	s1,8(sp)
    80002c6c:	01213023          	sd	s2,0(sp)
    80002c70:	02010413          	addi	s0,sp,32
    80002c74:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002c78:	00000913          	li	s2,0
    80002c7c:	00c0006f          	j	80002c88 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80002c80:	00001097          	auipc	ra,0x1
    80002c84:	3ac080e7          	jalr	940(ra) # 8000402c <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80002c88:	00007797          	auipc	a5,0x7
    80002c8c:	2e07a783          	lw	a5,736(a5) # 80009f68 <_ZL9threadEnd>
    80002c90:	02079e63          	bnez	a5,80002ccc <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80002c94:	0004a583          	lw	a1,0(s1)
    80002c98:	0305859b          	addiw	a1,a1,48
    80002c9c:	0084b503          	ld	a0,8(s1)
    80002ca0:	00001097          	auipc	ra,0x1
    80002ca4:	bac080e7          	jalr	-1108(ra) # 8000384c <_ZN9BufferCPP3putEi>
        i++;
    80002ca8:	0019071b          	addiw	a4,s2,1
    80002cac:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002cb0:	0004a683          	lw	a3,0(s1)
    80002cb4:	0026979b          	slliw	a5,a3,0x2
    80002cb8:	00d787bb          	addw	a5,a5,a3
    80002cbc:	0017979b          	slliw	a5,a5,0x1
    80002cc0:	02f767bb          	remw	a5,a4,a5
    80002cc4:	fc0792e3          	bnez	a5,80002c88 <_ZN12ProducerSync8producerEPv+0x2c>
    80002cc8:	fb9ff06f          	j	80002c80 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80002ccc:	0104b503          	ld	a0,16(s1)
    80002cd0:	00001097          	auipc	ra,0x1
    80002cd4:	424080e7          	jalr	1060(ra) # 800040f4 <_ZN9Semaphore6signalEv>
}
    80002cd8:	01813083          	ld	ra,24(sp)
    80002cdc:	01013403          	ld	s0,16(sp)
    80002ce0:	00813483          	ld	s1,8(sp)
    80002ce4:	00013903          	ld	s2,0(sp)
    80002ce8:	02010113          	addi	sp,sp,32
    80002cec:	00008067          	ret

0000000080002cf0 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80002cf0:	fd010113          	addi	sp,sp,-48
    80002cf4:	02113423          	sd	ra,40(sp)
    80002cf8:	02813023          	sd	s0,32(sp)
    80002cfc:	00913c23          	sd	s1,24(sp)
    80002d00:	01213823          	sd	s2,16(sp)
    80002d04:	01313423          	sd	s3,8(sp)
    80002d08:	01413023          	sd	s4,0(sp)
    80002d0c:	03010413          	addi	s0,sp,48
    80002d10:	00050993          	mv	s3,a0
    80002d14:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002d18:	00000a13          	li	s4,0
    80002d1c:	01c0006f          	j	80002d38 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80002d20:	00001097          	auipc	ra,0x1
    80002d24:	30c080e7          	jalr	780(ra) # 8000402c <_ZN6Thread8dispatchEv>
    80002d28:	0500006f          	j	80002d78 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80002d2c:	00a00513          	li	a0,10
    80002d30:	ffffe097          	auipc	ra,0xffffe
    80002d34:	6a8080e7          	jalr	1704(ra) # 800013d8 <_Z4putcc>
    while (!threadEnd) {
    80002d38:	00007797          	auipc	a5,0x7
    80002d3c:	2307a783          	lw	a5,560(a5) # 80009f68 <_ZL9threadEnd>
    80002d40:	06079263          	bnez	a5,80002da4 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80002d44:	00893503          	ld	a0,8(s2)
    80002d48:	00001097          	auipc	ra,0x1
    80002d4c:	b94080e7          	jalr	-1132(ra) # 800038dc <_ZN9BufferCPP3getEv>
        i++;
    80002d50:	001a049b          	addiw	s1,s4,1
    80002d54:	00048a1b          	sext.w	s4,s1
        putc(key);
    80002d58:	0ff57513          	andi	a0,a0,255
    80002d5c:	ffffe097          	auipc	ra,0xffffe
    80002d60:	67c080e7          	jalr	1660(ra) # 800013d8 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002d64:	00092703          	lw	a4,0(s2)
    80002d68:	0027179b          	slliw	a5,a4,0x2
    80002d6c:	00e787bb          	addw	a5,a5,a4
    80002d70:	02f4e7bb          	remw	a5,s1,a5
    80002d74:	fa0786e3          	beqz	a5,80002d20 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80002d78:	05000793          	li	a5,80
    80002d7c:	02f4e4bb          	remw	s1,s1,a5
    80002d80:	fa049ce3          	bnez	s1,80002d38 <_ZN12ConsumerSync8consumerEPv+0x48>
    80002d84:	fa9ff06f          	j	80002d2c <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80002d88:	0209b783          	ld	a5,32(s3)
    80002d8c:	0087b503          	ld	a0,8(a5)
    80002d90:	00001097          	auipc	ra,0x1
    80002d94:	b4c080e7          	jalr	-1204(ra) # 800038dc <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80002d98:	0ff57513          	andi	a0,a0,255
    80002d9c:	00001097          	auipc	ra,0x1
    80002da0:	3d8080e7          	jalr	984(ra) # 80004174 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80002da4:	0209b783          	ld	a5,32(s3)
    80002da8:	0087b503          	ld	a0,8(a5)
    80002dac:	00001097          	auipc	ra,0x1
    80002db0:	bbc080e7          	jalr	-1092(ra) # 80003968 <_ZN9BufferCPP6getCntEv>
    80002db4:	fca04ae3          	bgtz	a0,80002d88 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80002db8:	01093503          	ld	a0,16(s2)
    80002dbc:	00001097          	auipc	ra,0x1
    80002dc0:	338080e7          	jalr	824(ra) # 800040f4 <_ZN9Semaphore6signalEv>
}
    80002dc4:	02813083          	ld	ra,40(sp)
    80002dc8:	02013403          	ld	s0,32(sp)
    80002dcc:	01813483          	ld	s1,24(sp)
    80002dd0:	01013903          	ld	s2,16(sp)
    80002dd4:	00813983          	ld	s3,8(sp)
    80002dd8:	00013a03          	ld	s4,0(sp)
    80002ddc:	03010113          	addi	sp,sp,48
    80002de0:	00008067          	ret

0000000080002de4 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80002de4:	f8010113          	addi	sp,sp,-128
    80002de8:	06113c23          	sd	ra,120(sp)
    80002dec:	06813823          	sd	s0,112(sp)
    80002df0:	06913423          	sd	s1,104(sp)
    80002df4:	07213023          	sd	s2,96(sp)
    80002df8:	05313c23          	sd	s3,88(sp)
    80002dfc:	05413823          	sd	s4,80(sp)
    80002e00:	05513423          	sd	s5,72(sp)
    80002e04:	05613023          	sd	s6,64(sp)
    80002e08:	03713c23          	sd	s7,56(sp)
    80002e0c:	03813823          	sd	s8,48(sp)
    80002e10:	03913423          	sd	s9,40(sp)
    80002e14:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80002e18:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80002e1c:	00005517          	auipc	a0,0x5
    80002e20:	20450513          	addi	a0,a0,516 # 80008020 <CONSOLE_STATUS+0x10>
    80002e24:	00000097          	auipc	ra,0x0
    80002e28:	604080e7          	jalr	1540(ra) # 80003428 <_Z11printStringPKc>
    getString(input, 30);
    80002e2c:	01e00593          	li	a1,30
    80002e30:	f8040493          	addi	s1,s0,-128
    80002e34:	00048513          	mv	a0,s1
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	678080e7          	jalr	1656(ra) # 800034b0 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002e40:	00048513          	mv	a0,s1
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	744080e7          	jalr	1860(ra) # 80003588 <_Z11stringToIntPKc>
    80002e4c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002e50:	00005517          	auipc	a0,0x5
    80002e54:	1f050513          	addi	a0,a0,496 # 80008040 <CONSOLE_STATUS+0x30>
    80002e58:	00000097          	auipc	ra,0x0
    80002e5c:	5d0080e7          	jalr	1488(ra) # 80003428 <_Z11printStringPKc>
    getString(input, 30);
    80002e60:	01e00593          	li	a1,30
    80002e64:	00048513          	mv	a0,s1
    80002e68:	00000097          	auipc	ra,0x0
    80002e6c:	648080e7          	jalr	1608(ra) # 800034b0 <_Z9getStringPci>
    n = stringToInt(input);
    80002e70:	00048513          	mv	a0,s1
    80002e74:	00000097          	auipc	ra,0x0
    80002e78:	714080e7          	jalr	1812(ra) # 80003588 <_Z11stringToIntPKc>
    80002e7c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002e80:	00005517          	auipc	a0,0x5
    80002e84:	1e050513          	addi	a0,a0,480 # 80008060 <CONSOLE_STATUS+0x50>
    80002e88:	00000097          	auipc	ra,0x0
    80002e8c:	5a0080e7          	jalr	1440(ra) # 80003428 <_Z11printStringPKc>
    80002e90:	00000613          	li	a2,0
    80002e94:	00a00593          	li	a1,10
    80002e98:	00090513          	mv	a0,s2
    80002e9c:	00000097          	auipc	ra,0x0
    80002ea0:	73c080e7          	jalr	1852(ra) # 800035d8 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002ea4:	00005517          	auipc	a0,0x5
    80002ea8:	1d450513          	addi	a0,a0,468 # 80008078 <CONSOLE_STATUS+0x68>
    80002eac:	00000097          	auipc	ra,0x0
    80002eb0:	57c080e7          	jalr	1404(ra) # 80003428 <_Z11printStringPKc>
    80002eb4:	00000613          	li	a2,0
    80002eb8:	00a00593          	li	a1,10
    80002ebc:	00048513          	mv	a0,s1
    80002ec0:	00000097          	auipc	ra,0x0
    80002ec4:	718080e7          	jalr	1816(ra) # 800035d8 <_Z8printIntiii>
    printString(".\n");
    80002ec8:	00005517          	auipc	a0,0x5
    80002ecc:	1c850513          	addi	a0,a0,456 # 80008090 <CONSOLE_STATUS+0x80>
    80002ed0:	00000097          	auipc	ra,0x0
    80002ed4:	558080e7          	jalr	1368(ra) # 80003428 <_Z11printStringPKc>
    if(threadNum > n) {
    80002ed8:	0324c463          	blt	s1,s2,80002f00 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80002edc:	03205c63          	blez	s2,80002f14 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80002ee0:	03800513          	li	a0,56
    80002ee4:	00001097          	auipc	ra,0x1
    80002ee8:	fe0080e7          	jalr	-32(ra) # 80003ec4 <_Znwm>
    80002eec:	00050a93          	mv	s5,a0
    80002ef0:	00048593          	mv	a1,s1
    80002ef4:	00001097          	auipc	ra,0x1
    80002ef8:	804080e7          	jalr	-2044(ra) # 800036f8 <_ZN9BufferCPPC1Ei>
    80002efc:	0300006f          	j	80002f2c <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002f00:	00005517          	auipc	a0,0x5
    80002f04:	19850513          	addi	a0,a0,408 # 80008098 <CONSOLE_STATUS+0x88>
    80002f08:	00000097          	auipc	ra,0x0
    80002f0c:	520080e7          	jalr	1312(ra) # 80003428 <_Z11printStringPKc>
        return;
    80002f10:	0140006f          	j	80002f24 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002f14:	00005517          	auipc	a0,0x5
    80002f18:	1c450513          	addi	a0,a0,452 # 800080d8 <CONSOLE_STATUS+0xc8>
    80002f1c:	00000097          	auipc	ra,0x0
    80002f20:	50c080e7          	jalr	1292(ra) # 80003428 <_Z11printStringPKc>
        return;
    80002f24:	000b8113          	mv	sp,s7
    80002f28:	2380006f          	j	80003160 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80002f2c:	01000513          	li	a0,16
    80002f30:	00001097          	auipc	ra,0x1
    80002f34:	f94080e7          	jalr	-108(ra) # 80003ec4 <_Znwm>
    80002f38:	00050493          	mv	s1,a0
    80002f3c:	00000593          	li	a1,0
    80002f40:	00001097          	auipc	ra,0x1
    80002f44:	148080e7          	jalr	328(ra) # 80004088 <_ZN9SemaphoreC1Ej>
    80002f48:	00007797          	auipc	a5,0x7
    80002f4c:	0297b423          	sd	s1,40(a5) # 80009f70 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80002f50:	00391793          	slli	a5,s2,0x3
    80002f54:	00f78793          	addi	a5,a5,15
    80002f58:	ff07f793          	andi	a5,a5,-16
    80002f5c:	40f10133          	sub	sp,sp,a5
    80002f60:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80002f64:	0019071b          	addiw	a4,s2,1
    80002f68:	00171793          	slli	a5,a4,0x1
    80002f6c:	00e787b3          	add	a5,a5,a4
    80002f70:	00379793          	slli	a5,a5,0x3
    80002f74:	00f78793          	addi	a5,a5,15
    80002f78:	ff07f793          	andi	a5,a5,-16
    80002f7c:	40f10133          	sub	sp,sp,a5
    80002f80:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80002f84:	00191c13          	slli	s8,s2,0x1
    80002f88:	012c07b3          	add	a5,s8,s2
    80002f8c:	00379793          	slli	a5,a5,0x3
    80002f90:	00fa07b3          	add	a5,s4,a5
    80002f94:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002f98:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80002f9c:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80002fa0:	02800513          	li	a0,40
    80002fa4:	00001097          	auipc	ra,0x1
    80002fa8:	f20080e7          	jalr	-224(ra) # 80003ec4 <_Znwm>
    80002fac:	00050b13          	mv	s6,a0
    80002fb0:	012c0c33          	add	s8,s8,s2
    80002fb4:	003c1c13          	slli	s8,s8,0x3
    80002fb8:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80002fbc:	00001097          	auipc	ra,0x1
    80002fc0:	098080e7          	jalr	152(ra) # 80004054 <_ZN6ThreadC1Ev>
    80002fc4:	00007797          	auipc	a5,0x7
    80002fc8:	e9478793          	addi	a5,a5,-364 # 80009e58 <_ZTV12ConsumerSync+0x10>
    80002fcc:	00fb3023          	sd	a5,0(s6)
    80002fd0:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80002fd4:	000b0513          	mv	a0,s6
    80002fd8:	00001097          	auipc	ra,0x1
    80002fdc:	020080e7          	jalr	32(ra) # 80003ff8 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80002fe0:	00000493          	li	s1,0
    80002fe4:	0380006f          	j	8000301c <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80002fe8:	00007797          	auipc	a5,0x7
    80002fec:	e4878793          	addi	a5,a5,-440 # 80009e30 <_ZTV12ProducerSync+0x10>
    80002ff0:	00fcb023          	sd	a5,0(s9)
    80002ff4:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80002ff8:	00349793          	slli	a5,s1,0x3
    80002ffc:	00f987b3          	add	a5,s3,a5
    80003000:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80003004:	00349793          	slli	a5,s1,0x3
    80003008:	00f987b3          	add	a5,s3,a5
    8000300c:	0007b503          	ld	a0,0(a5)
    80003010:	00001097          	auipc	ra,0x1
    80003014:	fe8080e7          	jalr	-24(ra) # 80003ff8 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003018:	0014849b          	addiw	s1,s1,1
    8000301c:	0b24d063          	bge	s1,s2,800030bc <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80003020:	00149793          	slli	a5,s1,0x1
    80003024:	009787b3          	add	a5,a5,s1
    80003028:	00379793          	slli	a5,a5,0x3
    8000302c:	00fa07b3          	add	a5,s4,a5
    80003030:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003034:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003038:	00007717          	auipc	a4,0x7
    8000303c:	f3873703          	ld	a4,-200(a4) # 80009f70 <_ZL10waitForAll>
    80003040:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80003044:	02905863          	blez	s1,80003074 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80003048:	02800513          	li	a0,40
    8000304c:	00001097          	auipc	ra,0x1
    80003050:	e78080e7          	jalr	-392(ra) # 80003ec4 <_Znwm>
    80003054:	00050c93          	mv	s9,a0
    80003058:	00149c13          	slli	s8,s1,0x1
    8000305c:	009c0c33          	add	s8,s8,s1
    80003060:	003c1c13          	slli	s8,s8,0x3
    80003064:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003068:	00001097          	auipc	ra,0x1
    8000306c:	fec080e7          	jalr	-20(ra) # 80004054 <_ZN6ThreadC1Ev>
    80003070:	f79ff06f          	j	80002fe8 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80003074:	02800513          	li	a0,40
    80003078:	00001097          	auipc	ra,0x1
    8000307c:	e4c080e7          	jalr	-436(ra) # 80003ec4 <_Znwm>
    80003080:	00050c93          	mv	s9,a0
    80003084:	00149c13          	slli	s8,s1,0x1
    80003088:	009c0c33          	add	s8,s8,s1
    8000308c:	003c1c13          	slli	s8,s8,0x3
    80003090:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80003094:	00001097          	auipc	ra,0x1
    80003098:	fc0080e7          	jalr	-64(ra) # 80004054 <_ZN6ThreadC1Ev>
    8000309c:	00007797          	auipc	a5,0x7
    800030a0:	d6c78793          	addi	a5,a5,-660 # 80009e08 <_ZTV16ProducerKeyboard+0x10>
    800030a4:	00fcb023          	sd	a5,0(s9)
    800030a8:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    800030ac:	00349793          	slli	a5,s1,0x3
    800030b0:	00f987b3          	add	a5,s3,a5
    800030b4:	0197b023          	sd	s9,0(a5)
    800030b8:	f4dff06f          	j	80003004 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    800030bc:	00001097          	auipc	ra,0x1
    800030c0:	f70080e7          	jalr	-144(ra) # 8000402c <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800030c4:	00000493          	li	s1,0
    800030c8:	00994e63          	blt	s2,s1,800030e4 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    800030cc:	00007517          	auipc	a0,0x7
    800030d0:	ea453503          	ld	a0,-348(a0) # 80009f70 <_ZL10waitForAll>
    800030d4:	00001097          	auipc	ra,0x1
    800030d8:	ff4080e7          	jalr	-12(ra) # 800040c8 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800030dc:	0014849b          	addiw	s1,s1,1
    800030e0:	fe9ff06f          	j	800030c8 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    800030e4:	00000493          	li	s1,0
    800030e8:	0080006f          	j	800030f0 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    800030ec:	0014849b          	addiw	s1,s1,1
    800030f0:	0324d263          	bge	s1,s2,80003114 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    800030f4:	00349793          	slli	a5,s1,0x3
    800030f8:	00f987b3          	add	a5,s3,a5
    800030fc:	0007b503          	ld	a0,0(a5)
    80003100:	fe0506e3          	beqz	a0,800030ec <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80003104:	00053783          	ld	a5,0(a0)
    80003108:	0087b783          	ld	a5,8(a5)
    8000310c:	000780e7          	jalr	a5
    80003110:	fddff06f          	j	800030ec <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003114:	000b0a63          	beqz	s6,80003128 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003118:	000b3783          	ld	a5,0(s6)
    8000311c:	0087b783          	ld	a5,8(a5)
    80003120:	000b0513          	mv	a0,s6
    80003124:	000780e7          	jalr	a5
    delete waitForAll;
    80003128:	00007517          	auipc	a0,0x7
    8000312c:	e4853503          	ld	a0,-440(a0) # 80009f70 <_ZL10waitForAll>
    80003130:	00050863          	beqz	a0,80003140 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80003134:	00053783          	ld	a5,0(a0)
    80003138:	0087b783          	ld	a5,8(a5)
    8000313c:	000780e7          	jalr	a5
    delete buffer;
    80003140:	000a8e63          	beqz	s5,8000315c <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80003144:	000a8513          	mv	a0,s5
    80003148:	00001097          	auipc	ra,0x1
    8000314c:	8a8080e7          	jalr	-1880(ra) # 800039f0 <_ZN9BufferCPPD1Ev>
    80003150:	000a8513          	mv	a0,s5
    80003154:	00001097          	auipc	ra,0x1
    80003158:	dc0080e7          	jalr	-576(ra) # 80003f14 <_ZdlPv>
    8000315c:	000b8113          	mv	sp,s7

}
    80003160:	f8040113          	addi	sp,s0,-128
    80003164:	07813083          	ld	ra,120(sp)
    80003168:	07013403          	ld	s0,112(sp)
    8000316c:	06813483          	ld	s1,104(sp)
    80003170:	06013903          	ld	s2,96(sp)
    80003174:	05813983          	ld	s3,88(sp)
    80003178:	05013a03          	ld	s4,80(sp)
    8000317c:	04813a83          	ld	s5,72(sp)
    80003180:	04013b03          	ld	s6,64(sp)
    80003184:	03813b83          	ld	s7,56(sp)
    80003188:	03013c03          	ld	s8,48(sp)
    8000318c:	02813c83          	ld	s9,40(sp)
    80003190:	08010113          	addi	sp,sp,128
    80003194:	00008067          	ret
    80003198:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    8000319c:	000a8513          	mv	a0,s5
    800031a0:	00001097          	auipc	ra,0x1
    800031a4:	d74080e7          	jalr	-652(ra) # 80003f14 <_ZdlPv>
    800031a8:	00048513          	mv	a0,s1
    800031ac:	00008097          	auipc	ra,0x8
    800031b0:	ecc080e7          	jalr	-308(ra) # 8000b078 <_Unwind_Resume>
    800031b4:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    800031b8:	00048513          	mv	a0,s1
    800031bc:	00001097          	auipc	ra,0x1
    800031c0:	d58080e7          	jalr	-680(ra) # 80003f14 <_ZdlPv>
    800031c4:	00090513          	mv	a0,s2
    800031c8:	00008097          	auipc	ra,0x8
    800031cc:	eb0080e7          	jalr	-336(ra) # 8000b078 <_Unwind_Resume>
    800031d0:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    800031d4:	000b0513          	mv	a0,s6
    800031d8:	00001097          	auipc	ra,0x1
    800031dc:	d3c080e7          	jalr	-708(ra) # 80003f14 <_ZdlPv>
    800031e0:	00048513          	mv	a0,s1
    800031e4:	00008097          	auipc	ra,0x8
    800031e8:	e94080e7          	jalr	-364(ra) # 8000b078 <_Unwind_Resume>
    800031ec:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    800031f0:	000c8513          	mv	a0,s9
    800031f4:	00001097          	auipc	ra,0x1
    800031f8:	d20080e7          	jalr	-736(ra) # 80003f14 <_ZdlPv>
    800031fc:	00048513          	mv	a0,s1
    80003200:	00008097          	auipc	ra,0x8
    80003204:	e78080e7          	jalr	-392(ra) # 8000b078 <_Unwind_Resume>
    80003208:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    8000320c:	000c8513          	mv	a0,s9
    80003210:	00001097          	auipc	ra,0x1
    80003214:	d04080e7          	jalr	-764(ra) # 80003f14 <_ZdlPv>
    80003218:	00048513          	mv	a0,s1
    8000321c:	00008097          	auipc	ra,0x8
    80003220:	e5c080e7          	jalr	-420(ra) # 8000b078 <_Unwind_Resume>

0000000080003224 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003224:	ff010113          	addi	sp,sp,-16
    80003228:	00113423          	sd	ra,8(sp)
    8000322c:	00813023          	sd	s0,0(sp)
    80003230:	01010413          	addi	s0,sp,16
    80003234:	00007797          	auipc	a5,0x7
    80003238:	c2478793          	addi	a5,a5,-988 # 80009e58 <_ZTV12ConsumerSync+0x10>
    8000323c:	00f53023          	sd	a5,0(a0)
    80003240:	00001097          	auipc	ra,0x1
    80003244:	c34080e7          	jalr	-972(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80003248:	00813083          	ld	ra,8(sp)
    8000324c:	00013403          	ld	s0,0(sp)
    80003250:	01010113          	addi	sp,sp,16
    80003254:	00008067          	ret

0000000080003258 <_ZN12ConsumerSyncD0Ev>:
    80003258:	fe010113          	addi	sp,sp,-32
    8000325c:	00113c23          	sd	ra,24(sp)
    80003260:	00813823          	sd	s0,16(sp)
    80003264:	00913423          	sd	s1,8(sp)
    80003268:	02010413          	addi	s0,sp,32
    8000326c:	00050493          	mv	s1,a0
    80003270:	00007797          	auipc	a5,0x7
    80003274:	be878793          	addi	a5,a5,-1048 # 80009e58 <_ZTV12ConsumerSync+0x10>
    80003278:	00f53023          	sd	a5,0(a0)
    8000327c:	00001097          	auipc	ra,0x1
    80003280:	bf8080e7          	jalr	-1032(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80003284:	00048513          	mv	a0,s1
    80003288:	00001097          	auipc	ra,0x1
    8000328c:	c8c080e7          	jalr	-884(ra) # 80003f14 <_ZdlPv>
    80003290:	01813083          	ld	ra,24(sp)
    80003294:	01013403          	ld	s0,16(sp)
    80003298:	00813483          	ld	s1,8(sp)
    8000329c:	02010113          	addi	sp,sp,32
    800032a0:	00008067          	ret

00000000800032a4 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    800032a4:	ff010113          	addi	sp,sp,-16
    800032a8:	00113423          	sd	ra,8(sp)
    800032ac:	00813023          	sd	s0,0(sp)
    800032b0:	01010413          	addi	s0,sp,16
    800032b4:	00007797          	auipc	a5,0x7
    800032b8:	b7c78793          	addi	a5,a5,-1156 # 80009e30 <_ZTV12ProducerSync+0x10>
    800032bc:	00f53023          	sd	a5,0(a0)
    800032c0:	00001097          	auipc	ra,0x1
    800032c4:	bb4080e7          	jalr	-1100(ra) # 80003e74 <_ZN6ThreadD1Ev>
    800032c8:	00813083          	ld	ra,8(sp)
    800032cc:	00013403          	ld	s0,0(sp)
    800032d0:	01010113          	addi	sp,sp,16
    800032d4:	00008067          	ret

00000000800032d8 <_ZN12ProducerSyncD0Ev>:
    800032d8:	fe010113          	addi	sp,sp,-32
    800032dc:	00113c23          	sd	ra,24(sp)
    800032e0:	00813823          	sd	s0,16(sp)
    800032e4:	00913423          	sd	s1,8(sp)
    800032e8:	02010413          	addi	s0,sp,32
    800032ec:	00050493          	mv	s1,a0
    800032f0:	00007797          	auipc	a5,0x7
    800032f4:	b4078793          	addi	a5,a5,-1216 # 80009e30 <_ZTV12ProducerSync+0x10>
    800032f8:	00f53023          	sd	a5,0(a0)
    800032fc:	00001097          	auipc	ra,0x1
    80003300:	b78080e7          	jalr	-1160(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80003304:	00048513          	mv	a0,s1
    80003308:	00001097          	auipc	ra,0x1
    8000330c:	c0c080e7          	jalr	-1012(ra) # 80003f14 <_ZdlPv>
    80003310:	01813083          	ld	ra,24(sp)
    80003314:	01013403          	ld	s0,16(sp)
    80003318:	00813483          	ld	s1,8(sp)
    8000331c:	02010113          	addi	sp,sp,32
    80003320:	00008067          	ret

0000000080003324 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003324:	ff010113          	addi	sp,sp,-16
    80003328:	00113423          	sd	ra,8(sp)
    8000332c:	00813023          	sd	s0,0(sp)
    80003330:	01010413          	addi	s0,sp,16
    80003334:	00007797          	auipc	a5,0x7
    80003338:	ad478793          	addi	a5,a5,-1324 # 80009e08 <_ZTV16ProducerKeyboard+0x10>
    8000333c:	00f53023          	sd	a5,0(a0)
    80003340:	00001097          	auipc	ra,0x1
    80003344:	b34080e7          	jalr	-1228(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80003348:	00813083          	ld	ra,8(sp)
    8000334c:	00013403          	ld	s0,0(sp)
    80003350:	01010113          	addi	sp,sp,16
    80003354:	00008067          	ret

0000000080003358 <_ZN16ProducerKeyboardD0Ev>:
    80003358:	fe010113          	addi	sp,sp,-32
    8000335c:	00113c23          	sd	ra,24(sp)
    80003360:	00813823          	sd	s0,16(sp)
    80003364:	00913423          	sd	s1,8(sp)
    80003368:	02010413          	addi	s0,sp,32
    8000336c:	00050493          	mv	s1,a0
    80003370:	00007797          	auipc	a5,0x7
    80003374:	a9878793          	addi	a5,a5,-1384 # 80009e08 <_ZTV16ProducerKeyboard+0x10>
    80003378:	00f53023          	sd	a5,0(a0)
    8000337c:	00001097          	auipc	ra,0x1
    80003380:	af8080e7          	jalr	-1288(ra) # 80003e74 <_ZN6ThreadD1Ev>
    80003384:	00048513          	mv	a0,s1
    80003388:	00001097          	auipc	ra,0x1
    8000338c:	b8c080e7          	jalr	-1140(ra) # 80003f14 <_ZdlPv>
    80003390:	01813083          	ld	ra,24(sp)
    80003394:	01013403          	ld	s0,16(sp)
    80003398:	00813483          	ld	s1,8(sp)
    8000339c:	02010113          	addi	sp,sp,32
    800033a0:	00008067          	ret

00000000800033a4 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    800033a4:	ff010113          	addi	sp,sp,-16
    800033a8:	00113423          	sd	ra,8(sp)
    800033ac:	00813023          	sd	s0,0(sp)
    800033b0:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    800033b4:	02053583          	ld	a1,32(a0)
    800033b8:	fffff097          	auipc	ra,0xfffff
    800033bc:	7e4080e7          	jalr	2020(ra) # 80002b9c <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    800033c0:	00813083          	ld	ra,8(sp)
    800033c4:	00013403          	ld	s0,0(sp)
    800033c8:	01010113          	addi	sp,sp,16
    800033cc:	00008067          	ret

00000000800033d0 <_ZN12ProducerSync3runEv>:
    void run() override {
    800033d0:	ff010113          	addi	sp,sp,-16
    800033d4:	00113423          	sd	ra,8(sp)
    800033d8:	00813023          	sd	s0,0(sp)
    800033dc:	01010413          	addi	s0,sp,16
        producer(td);
    800033e0:	02053583          	ld	a1,32(a0)
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	878080e7          	jalr	-1928(ra) # 80002c5c <_ZN12ProducerSync8producerEPv>
    }
    800033ec:	00813083          	ld	ra,8(sp)
    800033f0:	00013403          	ld	s0,0(sp)
    800033f4:	01010113          	addi	sp,sp,16
    800033f8:	00008067          	ret

00000000800033fc <_ZN12ConsumerSync3runEv>:
    void run() override {
    800033fc:	ff010113          	addi	sp,sp,-16
    80003400:	00113423          	sd	ra,8(sp)
    80003404:	00813023          	sd	s0,0(sp)
    80003408:	01010413          	addi	s0,sp,16
        consumer(td);
    8000340c:	02053583          	ld	a1,32(a0)
    80003410:	00000097          	auipc	ra,0x0
    80003414:	8e0080e7          	jalr	-1824(ra) # 80002cf0 <_ZN12ConsumerSync8consumerEPv>
    }
    80003418:	00813083          	ld	ra,8(sp)
    8000341c:	00013403          	ld	s0,0(sp)
    80003420:	01010113          	addi	sp,sp,16
    80003424:	00008067          	ret

0000000080003428 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003428:	fe010113          	addi	sp,sp,-32
    8000342c:	00113c23          	sd	ra,24(sp)
    80003430:	00813823          	sd	s0,16(sp)
    80003434:	00913423          	sd	s1,8(sp)
    80003438:	02010413          	addi	s0,sp,32
    8000343c:	00050493          	mv	s1,a0
    LOCK();
    80003440:	00100613          	li	a2,1
    80003444:	00000593          	li	a1,0
    80003448:	00007517          	auipc	a0,0x7
    8000344c:	b3050513          	addi	a0,a0,-1232 # 80009f78 <lockPrint>
    80003450:	ffffe097          	auipc	ra,0xffffe
    80003454:	bb0080e7          	jalr	-1104(ra) # 80001000 <copy_and_swap>
    80003458:	00050863          	beqz	a0,80003468 <_Z11printStringPKc+0x40>
    8000345c:	ffffe097          	auipc	ra,0xffffe
    80003460:	f20080e7          	jalr	-224(ra) # 8000137c <_Z15thread_dispatchv>
    80003464:	fddff06f          	j	80003440 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003468:	0004c503          	lbu	a0,0(s1)
    8000346c:	00050a63          	beqz	a0,80003480 <_Z11printStringPKc+0x58>
    {
        __putc(*string);
    80003470:	00004097          	auipc	ra,0x4
    80003474:	dcc080e7          	jalr	-564(ra) # 8000723c <__putc>
        string++;
    80003478:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000347c:	fedff06f          	j	80003468 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80003480:	00000613          	li	a2,0
    80003484:	00100593          	li	a1,1
    80003488:	00007517          	auipc	a0,0x7
    8000348c:	af050513          	addi	a0,a0,-1296 # 80009f78 <lockPrint>
    80003490:	ffffe097          	auipc	ra,0xffffe
    80003494:	b70080e7          	jalr	-1168(ra) # 80001000 <copy_and_swap>
    80003498:	fe0514e3          	bnez	a0,80003480 <_Z11printStringPKc+0x58>
}
    8000349c:	01813083          	ld	ra,24(sp)
    800034a0:	01013403          	ld	s0,16(sp)
    800034a4:	00813483          	ld	s1,8(sp)
    800034a8:	02010113          	addi	sp,sp,32
    800034ac:	00008067          	ret

00000000800034b0 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800034b0:	fd010113          	addi	sp,sp,-48
    800034b4:	02113423          	sd	ra,40(sp)
    800034b8:	02813023          	sd	s0,32(sp)
    800034bc:	00913c23          	sd	s1,24(sp)
    800034c0:	01213823          	sd	s2,16(sp)
    800034c4:	01313423          	sd	s3,8(sp)
    800034c8:	01413023          	sd	s4,0(sp)
    800034cc:	03010413          	addi	s0,sp,48
    800034d0:	00050993          	mv	s3,a0
    800034d4:	00058a13          	mv	s4,a1
    LOCK();
    800034d8:	00100613          	li	a2,1
    800034dc:	00000593          	li	a1,0
    800034e0:	00007517          	auipc	a0,0x7
    800034e4:	a9850513          	addi	a0,a0,-1384 # 80009f78 <lockPrint>
    800034e8:	ffffe097          	auipc	ra,0xffffe
    800034ec:	b18080e7          	jalr	-1256(ra) # 80001000 <copy_and_swap>
    800034f0:	00050863          	beqz	a0,80003500 <_Z9getStringPci+0x50>
    800034f4:	ffffe097          	auipc	ra,0xffffe
    800034f8:	e88080e7          	jalr	-376(ra) # 8000137c <_Z15thread_dispatchv>
    800034fc:	fddff06f          	j	800034d8 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003500:	00000913          	li	s2,0
    80003504:	00090493          	mv	s1,s2
    80003508:	0019091b          	addiw	s2,s2,1
    8000350c:	03495a63          	bge	s2,s4,80003540 <_Z9getStringPci+0x90>
        cc = __getc();
    80003510:	00004097          	auipc	ra,0x4
    80003514:	d68080e7          	jalr	-664(ra) # 80007278 <__getc>
        if(cc < 1)
    80003518:	02050463          	beqz	a0,80003540 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    8000351c:	009984b3          	add	s1,s3,s1
    80003520:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003524:	00a00793          	li	a5,10
    80003528:	00f50a63          	beq	a0,a5,8000353c <_Z9getStringPci+0x8c>
    8000352c:	00d00793          	li	a5,13
    80003530:	fcf51ae3          	bne	a0,a5,80003504 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80003534:	00090493          	mv	s1,s2
    80003538:	0080006f          	j	80003540 <_Z9getStringPci+0x90>
    8000353c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003540:	009984b3          	add	s1,s3,s1
    80003544:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003548:	00000613          	li	a2,0
    8000354c:	00100593          	li	a1,1
    80003550:	00007517          	auipc	a0,0x7
    80003554:	a2850513          	addi	a0,a0,-1496 # 80009f78 <lockPrint>
    80003558:	ffffe097          	auipc	ra,0xffffe
    8000355c:	aa8080e7          	jalr	-1368(ra) # 80001000 <copy_and_swap>
    80003560:	fe0514e3          	bnez	a0,80003548 <_Z9getStringPci+0x98>
    return buf;
}
    80003564:	00098513          	mv	a0,s3
    80003568:	02813083          	ld	ra,40(sp)
    8000356c:	02013403          	ld	s0,32(sp)
    80003570:	01813483          	ld	s1,24(sp)
    80003574:	01013903          	ld	s2,16(sp)
    80003578:	00813983          	ld	s3,8(sp)
    8000357c:	00013a03          	ld	s4,0(sp)
    80003580:	03010113          	addi	sp,sp,48
    80003584:	00008067          	ret

0000000080003588 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003588:	ff010113          	addi	sp,sp,-16
    8000358c:	00813423          	sd	s0,8(sp)
    80003590:	01010413          	addi	s0,sp,16
    80003594:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003598:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000359c:	0006c603          	lbu	a2,0(a3)
    800035a0:	fd06071b          	addiw	a4,a2,-48
    800035a4:	0ff77713          	andi	a4,a4,255
    800035a8:	00900793          	li	a5,9
    800035ac:	02e7e063          	bltu	a5,a4,800035cc <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800035b0:	0025179b          	slliw	a5,a0,0x2
    800035b4:	00a787bb          	addw	a5,a5,a0
    800035b8:	0017979b          	slliw	a5,a5,0x1
    800035bc:	00168693          	addi	a3,a3,1
    800035c0:	00c787bb          	addw	a5,a5,a2
    800035c4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800035c8:	fd5ff06f          	j	8000359c <_Z11stringToIntPKc+0x14>
    return n;
}
    800035cc:	00813403          	ld	s0,8(sp)
    800035d0:	01010113          	addi	sp,sp,16
    800035d4:	00008067          	ret

00000000800035d8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800035d8:	fc010113          	addi	sp,sp,-64
    800035dc:	02113c23          	sd	ra,56(sp)
    800035e0:	02813823          	sd	s0,48(sp)
    800035e4:	02913423          	sd	s1,40(sp)
    800035e8:	03213023          	sd	s2,32(sp)
    800035ec:	01313c23          	sd	s3,24(sp)
    800035f0:	04010413          	addi	s0,sp,64
    800035f4:	00050493          	mv	s1,a0
    800035f8:	00058913          	mv	s2,a1
    800035fc:	00060993          	mv	s3,a2
    LOCK();
    80003600:	00100613          	li	a2,1
    80003604:	00000593          	li	a1,0
    80003608:	00007517          	auipc	a0,0x7
    8000360c:	97050513          	addi	a0,a0,-1680 # 80009f78 <lockPrint>
    80003610:	ffffe097          	auipc	ra,0xffffe
    80003614:	9f0080e7          	jalr	-1552(ra) # 80001000 <copy_and_swap>
    80003618:	00050863          	beqz	a0,80003628 <_Z8printIntiii+0x50>
    8000361c:	ffffe097          	auipc	ra,0xffffe
    80003620:	d60080e7          	jalr	-672(ra) # 8000137c <_Z15thread_dispatchv>
    80003624:	fddff06f          	j	80003600 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003628:	00098463          	beqz	s3,80003630 <_Z8printIntiii+0x58>
    8000362c:	0804c463          	bltz	s1,800036b4 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003630:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003634:	00000593          	li	a1,0
    }

    i = 0;
    80003638:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000363c:	0009079b          	sext.w	a5,s2
    80003640:	0325773b          	remuw	a4,a0,s2
    80003644:	00048613          	mv	a2,s1
    80003648:	0014849b          	addiw	s1,s1,1
    8000364c:	02071693          	slli	a3,a4,0x20
    80003650:	0206d693          	srli	a3,a3,0x20
    80003654:	00007717          	auipc	a4,0x7
    80003658:	81c70713          	addi	a4,a4,-2020 # 80009e70 <digits>
    8000365c:	00d70733          	add	a4,a4,a3
    80003660:	00074683          	lbu	a3,0(a4)
    80003664:	fd040713          	addi	a4,s0,-48
    80003668:	00c70733          	add	a4,a4,a2
    8000366c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003670:	0005071b          	sext.w	a4,a0
    80003674:	0325553b          	divuw	a0,a0,s2
    80003678:	fcf772e3          	bgeu	a4,a5,8000363c <_Z8printIntiii+0x64>
    if(neg)
    8000367c:	00058c63          	beqz	a1,80003694 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80003680:	fd040793          	addi	a5,s0,-48
    80003684:	009784b3          	add	s1,a5,s1
    80003688:	02d00793          	li	a5,45
    8000368c:	fef48823          	sb	a5,-16(s1)
    80003690:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003694:	fff4849b          	addiw	s1,s1,-1
    80003698:	0204c463          	bltz	s1,800036c0 <_Z8printIntiii+0xe8>
        __putc(buf[i]);
    8000369c:	fd040793          	addi	a5,s0,-48
    800036a0:	009787b3          	add	a5,a5,s1
    800036a4:	ff07c503          	lbu	a0,-16(a5)
    800036a8:	00004097          	auipc	ra,0x4
    800036ac:	b94080e7          	jalr	-1132(ra) # 8000723c <__putc>
    800036b0:	fe5ff06f          	j	80003694 <_Z8printIntiii+0xbc>
        x = -xx;
    800036b4:	4090053b          	negw	a0,s1
        neg = 1;
    800036b8:	00100593          	li	a1,1
        x = -xx;
    800036bc:	f7dff06f          	j	80003638 <_Z8printIntiii+0x60>

    UNLOCK();
    800036c0:	00000613          	li	a2,0
    800036c4:	00100593          	li	a1,1
    800036c8:	00007517          	auipc	a0,0x7
    800036cc:	8b050513          	addi	a0,a0,-1872 # 80009f78 <lockPrint>
    800036d0:	ffffe097          	auipc	ra,0xffffe
    800036d4:	930080e7          	jalr	-1744(ra) # 80001000 <copy_and_swap>
    800036d8:	fe0514e3          	bnez	a0,800036c0 <_Z8printIntiii+0xe8>
    800036dc:	03813083          	ld	ra,56(sp)
    800036e0:	03013403          	ld	s0,48(sp)
    800036e4:	02813483          	ld	s1,40(sp)
    800036e8:	02013903          	ld	s2,32(sp)
    800036ec:	01813983          	ld	s3,24(sp)
    800036f0:	04010113          	addi	sp,sp,64
    800036f4:	00008067          	ret

00000000800036f8 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800036f8:	fd010113          	addi	sp,sp,-48
    800036fc:	02113423          	sd	ra,40(sp)
    80003700:	02813023          	sd	s0,32(sp)
    80003704:	00913c23          	sd	s1,24(sp)
    80003708:	01213823          	sd	s2,16(sp)
    8000370c:	01313423          	sd	s3,8(sp)
    80003710:	03010413          	addi	s0,sp,48
    80003714:	00050493          	mv	s1,a0
    80003718:	00058913          	mv	s2,a1
    8000371c:	0015879b          	addiw	a5,a1,1
    80003720:	0007851b          	sext.w	a0,a5
    80003724:	00f4a023          	sw	a5,0(s1)
    80003728:	0004a823          	sw	zero,16(s1)
    8000372c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003730:	00251513          	slli	a0,a0,0x2
    80003734:	ffffe097          	auipc	ra,0xffffe
    80003738:	b08080e7          	jalr	-1272(ra) # 8000123c <_Z9mem_allocm>
    8000373c:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80003740:	01000513          	li	a0,16
    80003744:	00000097          	auipc	ra,0x0
    80003748:	780080e7          	jalr	1920(ra) # 80003ec4 <_Znwm>
    8000374c:	00050993          	mv	s3,a0
    80003750:	00000593          	li	a1,0
    80003754:	00001097          	auipc	ra,0x1
    80003758:	934080e7          	jalr	-1740(ra) # 80004088 <_ZN9SemaphoreC1Ej>
    8000375c:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80003760:	01000513          	li	a0,16
    80003764:	00000097          	auipc	ra,0x0
    80003768:	760080e7          	jalr	1888(ra) # 80003ec4 <_Znwm>
    8000376c:	00050993          	mv	s3,a0
    80003770:	00090593          	mv	a1,s2
    80003774:	00001097          	auipc	ra,0x1
    80003778:	914080e7          	jalr	-1772(ra) # 80004088 <_ZN9SemaphoreC1Ej>
    8000377c:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80003780:	01000513          	li	a0,16
    80003784:	00000097          	auipc	ra,0x0
    80003788:	740080e7          	jalr	1856(ra) # 80003ec4 <_Znwm>
    8000378c:	00050913          	mv	s2,a0
    80003790:	00100593          	li	a1,1
    80003794:	00001097          	auipc	ra,0x1
    80003798:	8f4080e7          	jalr	-1804(ra) # 80004088 <_ZN9SemaphoreC1Ej>
    8000379c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800037a0:	01000513          	li	a0,16
    800037a4:	00000097          	auipc	ra,0x0
    800037a8:	720080e7          	jalr	1824(ra) # 80003ec4 <_Znwm>
    800037ac:	00050913          	mv	s2,a0
    800037b0:	00100593          	li	a1,1
    800037b4:	00001097          	auipc	ra,0x1
    800037b8:	8d4080e7          	jalr	-1836(ra) # 80004088 <_ZN9SemaphoreC1Ej>
    800037bc:	0324b823          	sd	s2,48(s1)
}
    800037c0:	02813083          	ld	ra,40(sp)
    800037c4:	02013403          	ld	s0,32(sp)
    800037c8:	01813483          	ld	s1,24(sp)
    800037cc:	01013903          	ld	s2,16(sp)
    800037d0:	00813983          	ld	s3,8(sp)
    800037d4:	03010113          	addi	sp,sp,48
    800037d8:	00008067          	ret
    800037dc:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800037e0:	00098513          	mv	a0,s3
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	730080e7          	jalr	1840(ra) # 80003f14 <_ZdlPv>
    800037ec:	00048513          	mv	a0,s1
    800037f0:	00008097          	auipc	ra,0x8
    800037f4:	888080e7          	jalr	-1912(ra) # 8000b078 <_Unwind_Resume>
    800037f8:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800037fc:	00098513          	mv	a0,s3
    80003800:	00000097          	auipc	ra,0x0
    80003804:	714080e7          	jalr	1812(ra) # 80003f14 <_ZdlPv>
    80003808:	00048513          	mv	a0,s1
    8000380c:	00008097          	auipc	ra,0x8
    80003810:	86c080e7          	jalr	-1940(ra) # 8000b078 <_Unwind_Resume>
    80003814:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80003818:	00090513          	mv	a0,s2
    8000381c:	00000097          	auipc	ra,0x0
    80003820:	6f8080e7          	jalr	1784(ra) # 80003f14 <_ZdlPv>
    80003824:	00048513          	mv	a0,s1
    80003828:	00008097          	auipc	ra,0x8
    8000382c:	850080e7          	jalr	-1968(ra) # 8000b078 <_Unwind_Resume>
    80003830:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80003834:	00090513          	mv	a0,s2
    80003838:	00000097          	auipc	ra,0x0
    8000383c:	6dc080e7          	jalr	1756(ra) # 80003f14 <_ZdlPv>
    80003840:	00048513          	mv	a0,s1
    80003844:	00008097          	auipc	ra,0x8
    80003848:	834080e7          	jalr	-1996(ra) # 8000b078 <_Unwind_Resume>

000000008000384c <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    8000384c:	fe010113          	addi	sp,sp,-32
    80003850:	00113c23          	sd	ra,24(sp)
    80003854:	00813823          	sd	s0,16(sp)
    80003858:	00913423          	sd	s1,8(sp)
    8000385c:	01213023          	sd	s2,0(sp)
    80003860:	02010413          	addi	s0,sp,32
    80003864:	00050493          	mv	s1,a0
    80003868:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    8000386c:	01853503          	ld	a0,24(a0)
    80003870:	00001097          	auipc	ra,0x1
    80003874:	858080e7          	jalr	-1960(ra) # 800040c8 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80003878:	0304b503          	ld	a0,48(s1)
    8000387c:	00001097          	auipc	ra,0x1
    80003880:	84c080e7          	jalr	-1972(ra) # 800040c8 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80003884:	0084b783          	ld	a5,8(s1)
    80003888:	0144a703          	lw	a4,20(s1)
    8000388c:	00271713          	slli	a4,a4,0x2
    80003890:	00e787b3          	add	a5,a5,a4
    80003894:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003898:	0144a783          	lw	a5,20(s1)
    8000389c:	0017879b          	addiw	a5,a5,1
    800038a0:	0004a703          	lw	a4,0(s1)
    800038a4:	02e7e7bb          	remw	a5,a5,a4
    800038a8:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800038ac:	0304b503          	ld	a0,48(s1)
    800038b0:	00001097          	auipc	ra,0x1
    800038b4:	844080e7          	jalr	-1980(ra) # 800040f4 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800038b8:	0204b503          	ld	a0,32(s1)
    800038bc:	00001097          	auipc	ra,0x1
    800038c0:	838080e7          	jalr	-1992(ra) # 800040f4 <_ZN9Semaphore6signalEv>

}
    800038c4:	01813083          	ld	ra,24(sp)
    800038c8:	01013403          	ld	s0,16(sp)
    800038cc:	00813483          	ld	s1,8(sp)
    800038d0:	00013903          	ld	s2,0(sp)
    800038d4:	02010113          	addi	sp,sp,32
    800038d8:	00008067          	ret

00000000800038dc <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800038dc:	fe010113          	addi	sp,sp,-32
    800038e0:	00113c23          	sd	ra,24(sp)
    800038e4:	00813823          	sd	s0,16(sp)
    800038e8:	00913423          	sd	s1,8(sp)
    800038ec:	01213023          	sd	s2,0(sp)
    800038f0:	02010413          	addi	s0,sp,32
    800038f4:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800038f8:	02053503          	ld	a0,32(a0)
    800038fc:	00000097          	auipc	ra,0x0
    80003900:	7cc080e7          	jalr	1996(ra) # 800040c8 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80003904:	0284b503          	ld	a0,40(s1)
    80003908:	00000097          	auipc	ra,0x0
    8000390c:	7c0080e7          	jalr	1984(ra) # 800040c8 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80003910:	0084b703          	ld	a4,8(s1)
    80003914:	0104a783          	lw	a5,16(s1)
    80003918:	00279693          	slli	a3,a5,0x2
    8000391c:	00d70733          	add	a4,a4,a3
    80003920:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003924:	0017879b          	addiw	a5,a5,1
    80003928:	0004a703          	lw	a4,0(s1)
    8000392c:	02e7e7bb          	remw	a5,a5,a4
    80003930:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80003934:	0284b503          	ld	a0,40(s1)
    80003938:	00000097          	auipc	ra,0x0
    8000393c:	7bc080e7          	jalr	1980(ra) # 800040f4 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80003940:	0184b503          	ld	a0,24(s1)
    80003944:	00000097          	auipc	ra,0x0
    80003948:	7b0080e7          	jalr	1968(ra) # 800040f4 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000394c:	00090513          	mv	a0,s2
    80003950:	01813083          	ld	ra,24(sp)
    80003954:	01013403          	ld	s0,16(sp)
    80003958:	00813483          	ld	s1,8(sp)
    8000395c:	00013903          	ld	s2,0(sp)
    80003960:	02010113          	addi	sp,sp,32
    80003964:	00008067          	ret

0000000080003968 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80003968:	fe010113          	addi	sp,sp,-32
    8000396c:	00113c23          	sd	ra,24(sp)
    80003970:	00813823          	sd	s0,16(sp)
    80003974:	00913423          	sd	s1,8(sp)
    80003978:	01213023          	sd	s2,0(sp)
    8000397c:	02010413          	addi	s0,sp,32
    80003980:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80003984:	02853503          	ld	a0,40(a0)
    80003988:	00000097          	auipc	ra,0x0
    8000398c:	740080e7          	jalr	1856(ra) # 800040c8 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80003990:	0304b503          	ld	a0,48(s1)
    80003994:	00000097          	auipc	ra,0x0
    80003998:	734080e7          	jalr	1844(ra) # 800040c8 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    8000399c:	0144a783          	lw	a5,20(s1)
    800039a0:	0104a903          	lw	s2,16(s1)
    800039a4:	0327ce63          	blt	a5,s2,800039e0 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800039a8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800039ac:	0304b503          	ld	a0,48(s1)
    800039b0:	00000097          	auipc	ra,0x0
    800039b4:	744080e7          	jalr	1860(ra) # 800040f4 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800039b8:	0284b503          	ld	a0,40(s1)
    800039bc:	00000097          	auipc	ra,0x0
    800039c0:	738080e7          	jalr	1848(ra) # 800040f4 <_ZN9Semaphore6signalEv>

    return ret;
}
    800039c4:	00090513          	mv	a0,s2
    800039c8:	01813083          	ld	ra,24(sp)
    800039cc:	01013403          	ld	s0,16(sp)
    800039d0:	00813483          	ld	s1,8(sp)
    800039d4:	00013903          	ld	s2,0(sp)
    800039d8:	02010113          	addi	sp,sp,32
    800039dc:	00008067          	ret
        ret = cap - head + tail;
    800039e0:	0004a703          	lw	a4,0(s1)
    800039e4:	4127093b          	subw	s2,a4,s2
    800039e8:	00f9093b          	addw	s2,s2,a5
    800039ec:	fc1ff06f          	j	800039ac <_ZN9BufferCPP6getCntEv+0x44>

00000000800039f0 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800039f0:	fe010113          	addi	sp,sp,-32
    800039f4:	00113c23          	sd	ra,24(sp)
    800039f8:	00813823          	sd	s0,16(sp)
    800039fc:	00913423          	sd	s1,8(sp)
    80003a00:	02010413          	addi	s0,sp,32
    80003a04:	00050493          	mv	s1,a0
    Console::putc('\n');
    80003a08:	00a00513          	li	a0,10
    80003a0c:	00000097          	auipc	ra,0x0
    80003a10:	768080e7          	jalr	1896(ra) # 80004174 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80003a14:	00004517          	auipc	a0,0x4
    80003a18:	7ec50513          	addi	a0,a0,2028 # 80008200 <CONSOLE_STATUS+0x1f0>
    80003a1c:	00000097          	auipc	ra,0x0
    80003a20:	a0c080e7          	jalr	-1524(ra) # 80003428 <_Z11printStringPKc>
    while (getCnt()) {
    80003a24:	00048513          	mv	a0,s1
    80003a28:	00000097          	auipc	ra,0x0
    80003a2c:	f40080e7          	jalr	-192(ra) # 80003968 <_ZN9BufferCPP6getCntEv>
    80003a30:	02050c63          	beqz	a0,80003a68 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80003a34:	0084b783          	ld	a5,8(s1)
    80003a38:	0104a703          	lw	a4,16(s1)
    80003a3c:	00271713          	slli	a4,a4,0x2
    80003a40:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80003a44:	0007c503          	lbu	a0,0(a5)
    80003a48:	00000097          	auipc	ra,0x0
    80003a4c:	72c080e7          	jalr	1836(ra) # 80004174 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80003a50:	0104a783          	lw	a5,16(s1)
    80003a54:	0017879b          	addiw	a5,a5,1
    80003a58:	0004a703          	lw	a4,0(s1)
    80003a5c:	02e7e7bb          	remw	a5,a5,a4
    80003a60:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80003a64:	fc1ff06f          	j	80003a24 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80003a68:	02100513          	li	a0,33
    80003a6c:	00000097          	auipc	ra,0x0
    80003a70:	708080e7          	jalr	1800(ra) # 80004174 <_ZN7Console4putcEc>
    Console::putc('\n');
    80003a74:	00a00513          	li	a0,10
    80003a78:	00000097          	auipc	ra,0x0
    80003a7c:	6fc080e7          	jalr	1788(ra) # 80004174 <_ZN7Console4putcEc>
    mem_free(buffer);
    80003a80:	0084b503          	ld	a0,8(s1)
    80003a84:	ffffe097          	auipc	ra,0xffffe
    80003a88:	804080e7          	jalr	-2044(ra) # 80001288 <_Z8mem_freePv>
    delete itemAvailable;
    80003a8c:	0204b503          	ld	a0,32(s1)
    80003a90:	00050863          	beqz	a0,80003aa0 <_ZN9BufferCPPD1Ev+0xb0>
    80003a94:	00053783          	ld	a5,0(a0)
    80003a98:	0087b783          	ld	a5,8(a5)
    80003a9c:	000780e7          	jalr	a5
    delete spaceAvailable;
    80003aa0:	0184b503          	ld	a0,24(s1)
    80003aa4:	00050863          	beqz	a0,80003ab4 <_ZN9BufferCPPD1Ev+0xc4>
    80003aa8:	00053783          	ld	a5,0(a0)
    80003aac:	0087b783          	ld	a5,8(a5)
    80003ab0:	000780e7          	jalr	a5
    delete mutexTail;
    80003ab4:	0304b503          	ld	a0,48(s1)
    80003ab8:	00050863          	beqz	a0,80003ac8 <_ZN9BufferCPPD1Ev+0xd8>
    80003abc:	00053783          	ld	a5,0(a0)
    80003ac0:	0087b783          	ld	a5,8(a5)
    80003ac4:	000780e7          	jalr	a5
    delete mutexHead;
    80003ac8:	0284b503          	ld	a0,40(s1)
    80003acc:	00050863          	beqz	a0,80003adc <_ZN9BufferCPPD1Ev+0xec>
    80003ad0:	00053783          	ld	a5,0(a0)
    80003ad4:	0087b783          	ld	a5,8(a5)
    80003ad8:	000780e7          	jalr	a5
}
    80003adc:	01813083          	ld	ra,24(sp)
    80003ae0:	01013403          	ld	s0,16(sp)
    80003ae4:	00813483          	ld	s1,8(sp)
    80003ae8:	02010113          	addi	sp,sp,32
    80003aec:	00008067          	ret

0000000080003af0 <_Z8userMainv>:
//#include "../test/ConsumerProducer_CPP_API_test.hpp"
//#include "System_Mode_test.hpp"

#endif

void userMain() {
    80003af0:	fe010113          	addi	sp,sp,-32
    80003af4:	00113c23          	sd	ra,24(sp)
    80003af8:	00813823          	sd	s0,16(sp)
    80003afc:	00913423          	sd	s1,8(sp)
    80003b00:	01213023          	sd	s2,0(sp)
    80003b04:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80003b08:	00004517          	auipc	a0,0x4
    80003b0c:	71050513          	addi	a0,a0,1808 # 80008218 <CONSOLE_STATUS+0x208>
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	918080e7          	jalr	-1768(ra) # 80003428 <_Z11printStringPKc>
    int test = getc() - '0';
    80003b18:	ffffe097          	auipc	ra,0xffffe
    80003b1c:	888080e7          	jalr	-1912(ra) # 800013a0 <_Z4getcv>
    80003b20:	00050913          	mv	s2,a0
    80003b24:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80003b28:	ffffe097          	auipc	ra,0xffffe
    80003b2c:	878080e7          	jalr	-1928(ra) # 800013a0 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80003b30:	fcb9091b          	addiw	s2,s2,-53
    80003b34:	00100793          	li	a5,1
    80003b38:	0327f463          	bgeu	a5,s2,80003b60 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80003b3c:	00700793          	li	a5,7
    80003b40:	0e97e263          	bltu	a5,s1,80003c24 <_Z8userMainv+0x134>
    80003b44:	00249493          	slli	s1,s1,0x2
    80003b48:	00005717          	auipc	a4,0x5
    80003b4c:	8e870713          	addi	a4,a4,-1816 # 80008430 <CONSOLE_STATUS+0x420>
    80003b50:	00e484b3          	add	s1,s1,a4
    80003b54:	0004a783          	lw	a5,0(s1)
    80003b58:	00e787b3          	add	a5,a5,a4
    80003b5c:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80003b60:	00004517          	auipc	a0,0x4
    80003b64:	6d850513          	addi	a0,a0,1752 # 80008238 <CONSOLE_STATUS+0x228>
    80003b68:	00000097          	auipc	ra,0x0
    80003b6c:	8c0080e7          	jalr	-1856(ra) # 80003428 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80003b70:	01813083          	ld	ra,24(sp)
    80003b74:	01013403          	ld	s0,16(sp)
    80003b78:	00813483          	ld	s1,8(sp)
    80003b7c:	00013903          	ld	s2,0(sp)
    80003b80:	02010113          	addi	sp,sp,32
    80003b84:	00008067          	ret
            Threads_C_API_test();
    80003b88:	fffff097          	auipc	ra,0xfffff
    80003b8c:	f18080e7          	jalr	-232(ra) # 80002aa0 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80003b90:	00004517          	auipc	a0,0x4
    80003b94:	6d850513          	addi	a0,a0,1752 # 80008268 <CONSOLE_STATUS+0x258>
    80003b98:	00000097          	auipc	ra,0x0
    80003b9c:	890080e7          	jalr	-1904(ra) # 80003428 <_Z11printStringPKc>
            break;
    80003ba0:	fd1ff06f          	j	80003b70 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80003ba4:	ffffe097          	auipc	ra,0xffffe
    80003ba8:	35c080e7          	jalr	860(ra) # 80001f00 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80003bac:	00004517          	auipc	a0,0x4
    80003bb0:	6fc50513          	addi	a0,a0,1788 # 800082a8 <CONSOLE_STATUS+0x298>
    80003bb4:	00000097          	auipc	ra,0x0
    80003bb8:	874080e7          	jalr	-1932(ra) # 80003428 <_Z11printStringPKc>
            break;
    80003bbc:	fb5ff06f          	j	80003b70 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80003bc0:	ffffe097          	auipc	ra,0xffffe
    80003bc4:	b94080e7          	jalr	-1132(ra) # 80001754 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80003bc8:	00004517          	auipc	a0,0x4
    80003bcc:	72050513          	addi	a0,a0,1824 # 800082e8 <CONSOLE_STATUS+0x2d8>
    80003bd0:	00000097          	auipc	ra,0x0
    80003bd4:	858080e7          	jalr	-1960(ra) # 80003428 <_Z11printStringPKc>
            break;
    80003bd8:	f99ff06f          	j	80003b70 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    80003bdc:	fffff097          	auipc	ra,0xfffff
    80003be0:	208080e7          	jalr	520(ra) # 80002de4 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80003be4:	00004517          	auipc	a0,0x4
    80003be8:	75450513          	addi	a0,a0,1876 # 80008338 <CONSOLE_STATUS+0x328>
    80003bec:	00000097          	auipc	ra,0x0
    80003bf0:	83c080e7          	jalr	-1988(ra) # 80003428 <_Z11printStringPKc>
            break;
    80003bf4:	f7dff06f          	j	80003b70 <_Z8userMainv+0x80>
            System_Mode_test();
    80003bf8:	00001097          	auipc	ra,0x1
    80003bfc:	f48080e7          	jalr	-184(ra) # 80004b40 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80003c00:	00004517          	auipc	a0,0x4
    80003c04:	79050513          	addi	a0,a0,1936 # 80008390 <CONSOLE_STATUS+0x380>
    80003c08:	00000097          	auipc	ra,0x0
    80003c0c:	820080e7          	jalr	-2016(ra) # 80003428 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80003c10:	00004517          	auipc	a0,0x4
    80003c14:	7a050513          	addi	a0,a0,1952 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80003c18:	00000097          	auipc	ra,0x0
    80003c1c:	810080e7          	jalr	-2032(ra) # 80003428 <_Z11printStringPKc>
            break;
    80003c20:	f51ff06f          	j	80003b70 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80003c24:	00004517          	auipc	a0,0x4
    80003c28:	7e450513          	addi	a0,a0,2020 # 80008408 <CONSOLE_STATUS+0x3f8>
    80003c2c:	fffff097          	auipc	ra,0xfffff
    80003c30:	7fc080e7          	jalr	2044(ra) # 80003428 <_Z11printStringPKc>
    80003c34:	f3dff06f          	j	80003b70 <_Z8userMainv+0x80>

0000000080003c38 <_Z16userMainExecutorPv>:
extern void userMain();

volatile bool finished = false;

void userMainExecutor(void*)
{
    80003c38:	ff010113          	addi	sp,sp,-16
    80003c3c:	00113423          	sd	ra,8(sp)
    80003c40:	00813023          	sd	s0,0(sp)
    80003c44:	01010413          	addi	s0,sp,16
    userMain();
    80003c48:	00000097          	auipc	ra,0x0
    80003c4c:	ea8080e7          	jalr	-344(ra) # 80003af0 <_Z8userMainv>
    finished = true;
    80003c50:	00100793          	li	a5,1
    80003c54:	00006717          	auipc	a4,0x6
    80003c58:	32f70623          	sb	a5,812(a4) # 80009f80 <finished>
}
    80003c5c:	00813083          	ld	ra,8(sp)
    80003c60:	00013403          	ld	s0,0(sp)
    80003c64:	01010113          	addi	sp,sp,16
    80003c68:	00008067          	ret

0000000080003c6c <main>:
int main() {
    80003c6c:	ff010113          	addi	sp,sp,-16
    80003c70:	00113423          	sd	ra,8(sp)
    80003c74:	00813023          	sd	s0,0(sp)
    80003c78:	01010413          	addi	s0,sp,16

    Riscv::writeSTVEC((uint64)&Riscv::supervisorTrap);
    80003c7c:	00006797          	auipc	a5,0x6
    80003c80:	26c7b783          	ld	a5,620(a5) # 80009ee8 <_GLOBAL_OFFSET_TABLE_+0x18>
inline void Riscv::writeSEPC(uint64 sepc) {
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
}

inline void Riscv::writeSTVEC(uint64 stvec) {
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80003c84:	10579073          	csrw	stvec,a5

    TCB::running = new TCB(0, 0, 0);
    80003c88:	03000513          	li	a0,48
    80003c8c:	00000097          	auipc	ra,0x0
    80003c90:	238080e7          	jalr	568(ra) # 80003ec4 <_Znwm>
    static void threadWrapper();
    static void threadExit();

    TCB (Body body, void* arg, char* stack) : body(body), arg(arg), stack(stack),
                                              context({stack != nullptr ? (uint64) stack + DEFAULT_STACK_SIZE: 0, (uint64)&threadWrapper}),
                                              active(true), finished(false)
    80003c94:	00053023          	sd	zero,0(a0)
    80003c98:	00053423          	sd	zero,8(a0)
    80003c9c:	00053823          	sd	zero,16(a0)
    80003ca0:	00053c23          	sd	zero,24(a0)
    80003ca4:	00006797          	auipc	a5,0x6
    80003ca8:	2347b783          	ld	a5,564(a5) # 80009ed8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003cac:	02f53023          	sd	a5,32(a0)
    80003cb0:	00100793          	li	a5,1
    80003cb4:	02f50423          	sb	a5,40(a0)
    80003cb8:	020504a3          	sb	zero,41(a0)
    80003cbc:	00006797          	auipc	a5,0x6
    80003cc0:	23c7b783          	ld	a5,572(a5) # 80009ef8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003cc4:	00a7b023          	sd	a0,0(a5)
    //thread_t thr;
    //thread_create(&thr, userMainExecutor, nullptr);

//    while(!finished) thread_dispatch();

    userMain();
    80003cc8:	00000097          	auipc	ra,0x0
    80003ccc:	e28080e7          	jalr	-472(ra) # 80003af0 <_Z8userMainv>

    *(int*)0x100000 = 0x5555;
    80003cd0:	00100737          	lui	a4,0x100
    80003cd4:	000057b7          	lui	a5,0x5
    80003cd8:	5557879b          	addiw	a5,a5,1365
    80003cdc:	00f72023          	sw	a5,0(a4) # 100000 <_entry-0x7ff00000>

    return 0;
    80003ce0:	00000513          	li	a0,0
    80003ce4:	00813083          	ld	ra,8(sp)
    80003ce8:	00013403          	ld	s0,0(sp)
    80003cec:	01010113          	addi	sp,sp,16
    80003cf0:	00008067          	ret

0000000080003cf4 <_ZN3TCB13threadWrapperEv>:
    running = Scheduler::get();

    TCB::contextSwitch(&old->context, &running->context);
}

void TCB::threadWrapper() {
    80003cf4:	ff010113          	addi	sp,sp,-16
    80003cf8:	00113423          	sd	ra,8(sp)
    80003cfc:	00813023          	sd	s0,0(sp)
    80003d00:	01010413          	addi	s0,sp,16
    Riscv::popSPPSPIE();
    80003d04:	00000097          	auipc	ra,0x0
    80003d08:	4e4080e7          	jalr	1252(ra) # 800041e8 <_ZN5Riscv10popSPPSPIEEv>
    running->body(running->arg);
    80003d0c:	00006797          	auipc	a5,0x6
    80003d10:	27c7b783          	ld	a5,636(a5) # 80009f88 <_ZN3TCB7runningE>
    80003d14:	0007b703          	ld	a4,0(a5)
    80003d18:	0087b503          	ld	a0,8(a5)
    80003d1c:	000700e7          	jalr	a4
    thread_exit();
    80003d20:	ffffd097          	auipc	ra,0xffffd
    80003d24:	624080e7          	jalr	1572(ra) # 80001344 <_Z11thread_exitv>
}
    80003d28:	00813083          	ld	ra,8(sp)
    80003d2c:	00013403          	ld	s0,0(sp)
    80003d30:	01010113          	addi	sp,sp,16
    80003d34:	00008067          	ret

0000000080003d38 <_ZN3TCB12createThreadEPFvPvES0_Pc>:
TCB *TCB::createThread(Body body, void* arg, char* stack) {
    80003d38:	fd010113          	addi	sp,sp,-48
    80003d3c:	02113423          	sd	ra,40(sp)
    80003d40:	02813023          	sd	s0,32(sp)
    80003d44:	00913c23          	sd	s1,24(sp)
    80003d48:	01213823          	sd	s2,16(sp)
    80003d4c:	01313423          	sd	s3,8(sp)
    80003d50:	01413023          	sd	s4,0(sp)
    80003d54:	03010413          	addi	s0,sp,48
    80003d58:	00050993          	mv	s3,a0
    80003d5c:	00058a13          	mv	s4,a1
    80003d60:	00060913          	mv	s2,a2
    return new TCB(body, arg, stack);
    80003d64:	03000513          	li	a0,48
    80003d68:	00000097          	auipc	ra,0x0
    80003d6c:	15c080e7          	jalr	348(ra) # 80003ec4 <_Znwm>
    80003d70:	00050493          	mv	s1,a0
    80003d74:	01353023          	sd	s3,0(a0)
    80003d78:	01453423          	sd	s4,8(a0)
    80003d7c:	01253823          	sd	s2,16(a0)
                                              context({stack != nullptr ? (uint64) stack + DEFAULT_STACK_SIZE: 0, (uint64)&threadWrapper}),
    80003d80:	02090e63          	beqz	s2,80003dbc <_ZN3TCB12createThreadEPFvPvES0_Pc+0x84>
    80003d84:	00001637          	lui	a2,0x1
    80003d88:	00c90933          	add	s2,s2,a2
                                              active(true), finished(false)
    80003d8c:	0124bc23          	sd	s2,24(s1)
    80003d90:	00000797          	auipc	a5,0x0
    80003d94:	f6478793          	addi	a5,a5,-156 # 80003cf4 <_ZN3TCB13threadWrapperEv>
    80003d98:	02f4b023          	sd	a5,32(s1)
    80003d9c:	00100793          	li	a5,1
    80003da0:	02f48423          	sb	a5,40(s1)
    80003da4:	020484a3          	sb	zero,41(s1)
    {
        if (body != nullptr) {Scheduler::put(this);}
    80003da8:	02098c63          	beqz	s3,80003de0 <_ZN3TCB12createThreadEPFvPvES0_Pc+0xa8>
    80003dac:	00048513          	mv	a0,s1
    80003db0:	00001097          	auipc	ra,0x1
    80003db4:	808080e7          	jalr	-2040(ra) # 800045b8 <_ZN9Scheduler3putEP3TCB>
    80003db8:	0280006f          	j	80003de0 <_ZN3TCB12createThreadEPFvPvES0_Pc+0xa8>
                                              context({stack != nullptr ? (uint64) stack + DEFAULT_STACK_SIZE: 0, (uint64)&threadWrapper}),
    80003dbc:	00000913          	li	s2,0
    80003dc0:	fcdff06f          	j	80003d8c <_ZN3TCB12createThreadEPFvPvES0_Pc+0x54>
    80003dc4:	00050913          	mv	s2,a0
    80003dc8:	00048513          	mv	a0,s1
    80003dcc:	00000097          	auipc	ra,0x0
    80003dd0:	148080e7          	jalr	328(ra) # 80003f14 <_ZdlPv>
    80003dd4:	00090513          	mv	a0,s2
    80003dd8:	00007097          	auipc	ra,0x7
    80003ddc:	2a0080e7          	jalr	672(ra) # 8000b078 <_Unwind_Resume>
}
    80003de0:	00048513          	mv	a0,s1
    80003de4:	02813083          	ld	ra,40(sp)
    80003de8:	02013403          	ld	s0,32(sp)
    80003dec:	01813483          	ld	s1,24(sp)
    80003df0:	01013903          	ld	s2,16(sp)
    80003df4:	00813983          	ld	s3,8(sp)
    80003df8:	00013a03          	ld	s4,0(sp)
    80003dfc:	03010113          	addi	sp,sp,48
    80003e00:	00008067          	ret

0000000080003e04 <_ZN3TCB8dispatchEv>:
{
    80003e04:	fe010113          	addi	sp,sp,-32
    80003e08:	00113c23          	sd	ra,24(sp)
    80003e0c:	00813823          	sd	s0,16(sp)
    80003e10:	00913423          	sd	s1,8(sp)
    80003e14:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80003e18:	00006497          	auipc	s1,0x6
    80003e1c:	1704b483          	ld	s1,368(s1) # 80009f88 <_ZN3TCB7runningE>
    bool getFinished () const { return finished; }
    80003e20:	0294c783          	lbu	a5,41(s1)
    if(!old->getFinished() && old->getActive()) {Scheduler::put(old);}
    80003e24:	00079663          	bnez	a5,80003e30 <_ZN3TCB8dispatchEv+0x2c>
    bool getActive () const { return active; }
    80003e28:	0284c783          	lbu	a5,40(s1)
    80003e2c:	02079c63          	bnez	a5,80003e64 <_ZN3TCB8dispatchEv+0x60>
    running = Scheduler::get();
    80003e30:	00000097          	auipc	ra,0x0
    80003e34:	730080e7          	jalr	1840(ra) # 80004560 <_ZN9Scheduler3getEv>
    80003e38:	00006797          	auipc	a5,0x6
    80003e3c:	14a7b823          	sd	a0,336(a5) # 80009f88 <_ZN3TCB7runningE>
    TCB::contextSwitch(&old->context, &running->context);
    80003e40:	01850593          	addi	a1,a0,24
    80003e44:	01848513          	addi	a0,s1,24
    80003e48:	ffffd097          	auipc	ra,0xffffd
    80003e4c:	3e0080e7          	jalr	992(ra) # 80001228 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80003e50:	01813083          	ld	ra,24(sp)
    80003e54:	01013403          	ld	s0,16(sp)
    80003e58:	00813483          	ld	s1,8(sp)
    80003e5c:	02010113          	addi	sp,sp,32
    80003e60:	00008067          	ret
    if(!old->getFinished() && old->getActive()) {Scheduler::put(old);}
    80003e64:	00048513          	mv	a0,s1
    80003e68:	00000097          	auipc	ra,0x0
    80003e6c:	750080e7          	jalr	1872(ra) # 800045b8 <_ZN9Scheduler3putEP3TCB>
    80003e70:	fc1ff06f          	j	80003e30 <_ZN3TCB8dispatchEv+0x2c>

0000000080003e74 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) : body(body), arg(arg){
}


Thread::~Thread(){
    80003e74:	ff010113          	addi	sp,sp,-16
    80003e78:	00813423          	sd	s0,8(sp)
    80003e7c:	01010413          	addi	s0,sp,16

}
    80003e80:	00813403          	ld	s0,8(sp)
    80003e84:	01010113          	addi	sp,sp,16
    80003e88:	00008067          	ret

0000000080003e8c <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    80003e8c:	ff010113          	addi	sp,sp,-16
    80003e90:	00113423          	sd	ra,8(sp)
    80003e94:	00813023          	sd	s0,0(sp)
    80003e98:	01010413          	addi	s0,sp,16
    80003e9c:	00006797          	auipc	a5,0x6
    80003ea0:	02478793          	addi	a5,a5,36 # 80009ec0 <_ZTV9Semaphore+0x10>
    80003ea4:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80003ea8:	00853503          	ld	a0,8(a0)
    80003eac:	ffffd097          	auipc	ra,0xffffd
    80003eb0:	594080e7          	jalr	1428(ra) # 80001440 <_Z9sem_closeP4_sem>
}
    80003eb4:	00813083          	ld	ra,8(sp)
    80003eb8:	00013403          	ld	s0,0(sp)
    80003ebc:	01010113          	addi	sp,sp,16
    80003ec0:	00008067          	ret

0000000080003ec4 <_Znwm>:
{
    80003ec4:	ff010113          	addi	sp,sp,-16
    80003ec8:	00113423          	sd	ra,8(sp)
    80003ecc:	00813023          	sd	s0,0(sp)
    80003ed0:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80003ed4:	ffffd097          	auipc	ra,0xffffd
    80003ed8:	368080e7          	jalr	872(ra) # 8000123c <_Z9mem_allocm>
}
    80003edc:	00813083          	ld	ra,8(sp)
    80003ee0:	00013403          	ld	s0,0(sp)
    80003ee4:	01010113          	addi	sp,sp,16
    80003ee8:	00008067          	ret

0000000080003eec <_Znam>:
{
    80003eec:	ff010113          	addi	sp,sp,-16
    80003ef0:	00113423          	sd	ra,8(sp)
    80003ef4:	00813023          	sd	s0,0(sp)
    80003ef8:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80003efc:	ffffd097          	auipc	ra,0xffffd
    80003f00:	340080e7          	jalr	832(ra) # 8000123c <_Z9mem_allocm>
}
    80003f04:	00813083          	ld	ra,8(sp)
    80003f08:	00013403          	ld	s0,0(sp)
    80003f0c:	01010113          	addi	sp,sp,16
    80003f10:	00008067          	ret

0000000080003f14 <_ZdlPv>:
{
    80003f14:	ff010113          	addi	sp,sp,-16
    80003f18:	00113423          	sd	ra,8(sp)
    80003f1c:	00813023          	sd	s0,0(sp)
    80003f20:	01010413          	addi	s0,sp,16
    mem_free(p);
    80003f24:	ffffd097          	auipc	ra,0xffffd
    80003f28:	364080e7          	jalr	868(ra) # 80001288 <_Z8mem_freePv>
}
    80003f2c:	00813083          	ld	ra,8(sp)
    80003f30:	00013403          	ld	s0,0(sp)
    80003f34:	01010113          	addi	sp,sp,16
    80003f38:	00008067          	ret

0000000080003f3c <_ZN6ThreadD0Ev>:
Thread::~Thread(){
    80003f3c:	ff010113          	addi	sp,sp,-16
    80003f40:	00113423          	sd	ra,8(sp)
    80003f44:	00813023          	sd	s0,0(sp)
    80003f48:	01010413          	addi	s0,sp,16
}
    80003f4c:	00000097          	auipc	ra,0x0
    80003f50:	fc8080e7          	jalr	-56(ra) # 80003f14 <_ZdlPv>
    80003f54:	00813083          	ld	ra,8(sp)
    80003f58:	00013403          	ld	s0,0(sp)
    80003f5c:	01010113          	addi	sp,sp,16
    80003f60:	00008067          	ret

0000000080003f64 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80003f64:	fe010113          	addi	sp,sp,-32
    80003f68:	00113c23          	sd	ra,24(sp)
    80003f6c:	00813823          	sd	s0,16(sp)
    80003f70:	00913423          	sd	s1,8(sp)
    80003f74:	02010413          	addi	s0,sp,32
    80003f78:	00050493          	mv	s1,a0
}
    80003f7c:	00000097          	auipc	ra,0x0
    80003f80:	f10080e7          	jalr	-240(ra) # 80003e8c <_ZN9SemaphoreD1Ev>
    80003f84:	00048513          	mv	a0,s1
    80003f88:	00000097          	auipc	ra,0x0
    80003f8c:	f8c080e7          	jalr	-116(ra) # 80003f14 <_ZdlPv>
    80003f90:	01813083          	ld	ra,24(sp)
    80003f94:	01013403          	ld	s0,16(sp)
    80003f98:	00813483          	ld	s1,8(sp)
    80003f9c:	02010113          	addi	sp,sp,32
    80003fa0:	00008067          	ret

0000000080003fa4 <_ZdaPv>:
{
    80003fa4:	ff010113          	addi	sp,sp,-16
    80003fa8:	00113423          	sd	ra,8(sp)
    80003fac:	00813023          	sd	s0,0(sp)
    80003fb0:	01010413          	addi	s0,sp,16
    mem_free(p);
    80003fb4:	ffffd097          	auipc	ra,0xffffd
    80003fb8:	2d4080e7          	jalr	724(ra) # 80001288 <_Z8mem_freePv>
}
    80003fbc:	00813083          	ld	ra,8(sp)
    80003fc0:	00013403          	ld	s0,0(sp)
    80003fc4:	01010113          	addi	sp,sp,16
    80003fc8:	00008067          	ret

0000000080003fcc <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) : body(body), arg(arg){
    80003fcc:	ff010113          	addi	sp,sp,-16
    80003fd0:	00813423          	sd	s0,8(sp)
    80003fd4:	01010413          	addi	s0,sp,16
    80003fd8:	00006797          	auipc	a5,0x6
    80003fdc:	ec078793          	addi	a5,a5,-320 # 80009e98 <_ZTV6Thread+0x10>
    80003fe0:	00f53023          	sd	a5,0(a0)
    80003fe4:	00b53823          	sd	a1,16(a0)
    80003fe8:	00c53c23          	sd	a2,24(a0)
}
    80003fec:	00813403          	ld	s0,8(sp)
    80003ff0:	01010113          	addi	sp,sp,16
    80003ff4:	00008067          	ret

0000000080003ff8 <_ZN6Thread5startEv>:
int Thread::start() {
    80003ff8:	ff010113          	addi	sp,sp,-16
    80003ffc:	00113423          	sd	ra,8(sp)
    80004000:	00813023          	sd	s0,0(sp)
    80004004:	01010413          	addi	s0,sp,16
    return thread_create(&myHandle, body, arg);
    80004008:	01853603          	ld	a2,24(a0)
    8000400c:	01053583          	ld	a1,16(a0)
    80004010:	00850513          	addi	a0,a0,8
    80004014:	ffffd097          	auipc	ra,0xffffd
    80004018:	2b0080e7          	jalr	688(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
}
    8000401c:	00813083          	ld	ra,8(sp)
    80004020:	00013403          	ld	s0,0(sp)
    80004024:	01010113          	addi	sp,sp,16
    80004028:	00008067          	ret

000000008000402c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000402c:	ff010113          	addi	sp,sp,-16
    80004030:	00113423          	sd	ra,8(sp)
    80004034:	00813023          	sd	s0,0(sp)
    80004038:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000403c:	ffffd097          	auipc	ra,0xffffd
    80004040:	340080e7          	jalr	832(ra) # 8000137c <_Z15thread_dispatchv>
}
    80004044:	00813083          	ld	ra,8(sp)
    80004048:	00013403          	ld	s0,0(sp)
    8000404c:	01010113          	addi	sp,sp,16
    80004050:	00008067          	ret

0000000080004054 <_ZN6ThreadC1Ev>:
Thread::Thread() : body(&runWrapper), arg(this){
    80004054:	ff010113          	addi	sp,sp,-16
    80004058:	00813423          	sd	s0,8(sp)
    8000405c:	01010413          	addi	s0,sp,16
    80004060:	00006797          	auipc	a5,0x6
    80004064:	e3878793          	addi	a5,a5,-456 # 80009e98 <_ZTV6Thread+0x10>
    80004068:	00f53023          	sd	a5,0(a0)
    8000406c:	00000797          	auipc	a5,0x0
    80004070:	14878793          	addi	a5,a5,328 # 800041b4 <_ZN6Thread10runWrapperEPv>
    80004074:	00f53823          	sd	a5,16(a0)
    80004078:	00a53c23          	sd	a0,24(a0)
}
    8000407c:	00813403          	ld	s0,8(sp)
    80004080:	01010113          	addi	sp,sp,16
    80004084:	00008067          	ret

0000000080004088 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80004088:	ff010113          	addi	sp,sp,-16
    8000408c:	00113423          	sd	ra,8(sp)
    80004090:	00813023          	sd	s0,0(sp)
    80004094:	01010413          	addi	s0,sp,16
    80004098:	00006797          	auipc	a5,0x6
    8000409c:	e2878793          	addi	a5,a5,-472 # 80009ec0 <_ZTV9Semaphore+0x10>
    800040a0:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    800040a4:	02059593          	slli	a1,a1,0x20
    800040a8:	0205d593          	srli	a1,a1,0x20
    800040ac:	00850513          	addi	a0,a0,8
    800040b0:	ffffd097          	auipc	ra,0xffffd
    800040b4:	350080e7          	jalr	848(ra) # 80001400 <_Z8sem_openPP4_semm>
}
    800040b8:	00813083          	ld	ra,8(sp)
    800040bc:	00013403          	ld	s0,0(sp)
    800040c0:	01010113          	addi	sp,sp,16
    800040c4:	00008067          	ret

00000000800040c8 <_ZN9Semaphore4waitEv>:

int Semaphore::wait() {
    800040c8:	ff010113          	addi	sp,sp,-16
    800040cc:	00113423          	sd	ra,8(sp)
    800040d0:	00813023          	sd	s0,0(sp)
    800040d4:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800040d8:	00853503          	ld	a0,8(a0)
    800040dc:	ffffd097          	auipc	ra,0xffffd
    800040e0:	3a0080e7          	jalr	928(ra) # 8000147c <_Z8sem_waitP4_sem>
}
    800040e4:	00813083          	ld	ra,8(sp)
    800040e8:	00013403          	ld	s0,0(sp)
    800040ec:	01010113          	addi	sp,sp,16
    800040f0:	00008067          	ret

00000000800040f4 <_ZN9Semaphore6signalEv>:

int Semaphore::signal() {
    800040f4:	ff010113          	addi	sp,sp,-16
    800040f8:	00113423          	sd	ra,8(sp)
    800040fc:	00813023          	sd	s0,0(sp)
    80004100:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80004104:	00853503          	ld	a0,8(a0)
    80004108:	ffffd097          	auipc	ra,0xffffd
    8000410c:	3b0080e7          	jalr	944(ra) # 800014b8 <_Z10sem_signalP4_sem>
}
    80004110:	00813083          	ld	ra,8(sp)
    80004114:	00013403          	ld	s0,0(sp)
    80004118:	01010113          	addi	sp,sp,16
    8000411c:	00008067          	ret

0000000080004120 <_ZN9Semaphore7tryWaitEv>:

int Semaphore::tryWait() {
    80004120:	ff010113          	addi	sp,sp,-16
    80004124:	00113423          	sd	ra,8(sp)
    80004128:	00813023          	sd	s0,0(sp)
    8000412c:	01010413          	addi	s0,sp,16
    return sem_trywait(myHandle);
    80004130:	00853503          	ld	a0,8(a0)
    80004134:	ffffd097          	auipc	ra,0xffffd
    80004138:	3c0080e7          	jalr	960(ra) # 800014f4 <_Z11sem_trywaitP4_sem>
}
    8000413c:	00813083          	ld	ra,8(sp)
    80004140:	00013403          	ld	s0,0(sp)
    80004144:	01010113          	addi	sp,sp,16
    80004148:	00008067          	ret

000000008000414c <_ZN7Console4getcEv>:


char Console::getc() {
    8000414c:	ff010113          	addi	sp,sp,-16
    80004150:	00113423          	sd	ra,8(sp)
    80004154:	00813023          	sd	s0,0(sp)
    80004158:	01010413          	addi	s0,sp,16
    return ::getc();
    8000415c:	ffffd097          	auipc	ra,0xffffd
    80004160:	244080e7          	jalr	580(ra) # 800013a0 <_Z4getcv>
}
    80004164:	00813083          	ld	ra,8(sp)
    80004168:	00013403          	ld	s0,0(sp)
    8000416c:	01010113          	addi	sp,sp,16
    80004170:	00008067          	ret

0000000080004174 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80004174:	ff010113          	addi	sp,sp,-16
    80004178:	00113423          	sd	ra,8(sp)
    8000417c:	00813023          	sd	s0,0(sp)
    80004180:	01010413          	addi	s0,sp,16
    ::putc(c);
    80004184:	ffffd097          	auipc	ra,0xffffd
    80004188:	254080e7          	jalr	596(ra) # 800013d8 <_Z4putcc>
}
    8000418c:	00813083          	ld	ra,8(sp)
    80004190:	00013403          	ld	s0,0(sp)
    80004194:	01010113          	addi	sp,sp,16
    80004198:	00008067          	ret

000000008000419c <_ZN6Thread3runEv>:
    static void dispatch ();

protected:

    Thread();
    virtual void run() {};
    8000419c:	ff010113          	addi	sp,sp,-16
    800041a0:	00813423          	sd	s0,8(sp)
    800041a4:	01010413          	addi	s0,sp,16
    800041a8:	00813403          	ld	s0,8(sp)
    800041ac:	01010113          	addi	sp,sp,16
    800041b0:	00008067          	ret

00000000800041b4 <_ZN6Thread10runWrapperEPv>:

private:
    static void runWrapper(void* thread) {
        if(thread) {
    800041b4:	02050863          	beqz	a0,800041e4 <_ZN6Thread10runWrapperEPv+0x30>
    static void runWrapper(void* thread) {
    800041b8:	ff010113          	addi	sp,sp,-16
    800041bc:	00113423          	sd	ra,8(sp)
    800041c0:	00813023          	sd	s0,0(sp)
    800041c4:	01010413          	addi	s0,sp,16
            ((Thread*)thread)->run();
    800041c8:	00053783          	ld	a5,0(a0)
    800041cc:	0107b783          	ld	a5,16(a5)
    800041d0:	000780e7          	jalr	a5
        }
    }
    800041d4:	00813083          	ld	ra,8(sp)
    800041d8:	00013403          	ld	s0,0(sp)
    800041dc:	01010113          	addi	sp,sp,16
    800041e0:	00008067          	ret
    800041e4:	00008067          	ret

00000000800041e8 <_ZN5Riscv10popSPPSPIEEv>:
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.hpp"
#include "../h/tcb.hpp"
#include "../h/semaphore.hpp"

void Riscv::popSPPSPIE() {
    800041e8:	ff010113          	addi	sp,sp,-16
    800041ec:	00813423          	sd	s0,8(sp)
    800041f0:	01010413          	addi	s0,sp,16
inline void Riscv::maskSetSSTATUS(uint64 mask) {
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::maskClearSSTATUS(uint64 mask) {
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800041f4:	10000793          	li	a5,256
    800041f8:	1007b073          	csrc	sstatus,a5
    maskClearSSTATUS(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    800041fc:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80004200:	10200073          	sret
}
    80004204:	00813403          	ld	s0,8(sp)
    80004208:	01010113          	addi	sp,sp,16
    8000420c:	00008067          	ret

0000000080004210 <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap() {
    80004210:	fb010113          	addi	sp,sp,-80
    80004214:	04113423          	sd	ra,72(sp)
    80004218:	04813023          	sd	s0,64(sp)
    8000421c:	02913c23          	sd	s1,56(sp)
    80004220:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80004224:	142027f3          	csrr	a5,scause
    80004228:	fcf43423          	sd	a5,-56(s0)
    return scause;
    8000422c:	fc843503          	ld	a0,-56(s0)
    uint64 scause = readSCAUSE();
    if (scause == 0x0000000000000008ULL || scause == 0x0000000000000009ULL) //ecall iz user ili supervisor mode-a
    80004230:	ff850713          	addi	a4,a0,-8
    80004234:	00100793          	li	a5,1
    80004238:	14e7f063          	bgeu	a5,a4,80004378 <_ZN5Riscv20handleSupervisorTrapEv+0x168>
        }

        writeSSTATUS(sstatus);
        writeSEPC(sepc);
    }
    else if (scause == 0x8000000000000001ULL)
    8000423c:	fff00793          	li	a5,-1
    80004240:	03f79793          	slli	a5,a5,0x3f
    80004244:	00178793          	addi	a5,a5,1
    80004248:	2cf50463          	beq	a0,a5,80004510 <_ZN5Riscv20handleSupervisorTrapEv+0x300>
    {
        maskClearSIP(SIP_SSIE);
    }
    else if (scause == 0x8000000000000009ULL)
    8000424c:	fff00793          	li	a5,-1
    80004250:	03f79793          	slli	a5,a5,0x3f
    80004254:	00978793          	addi	a5,a5,9
    80004258:	2cf50263          	beq	a0,a5,8000451c <_ZN5Riscv20handleSupervisorTrapEv+0x30c>
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        console_handler();
    }
    else
    {
        char chScause = scause + '0';
    8000425c:	0ff57493          	andi	s1,a0,255
    80004260:	0304849b          	addiw	s1,s1,48
    80004264:	0ff4f493          	andi	s1,s1,255
        __putc('F');__putc('A');__putc('T');__putc('A');__putc('L');__putc(' ');
    80004268:	04600513          	li	a0,70
    8000426c:	00003097          	auipc	ra,0x3
    80004270:	fd0080e7          	jalr	-48(ra) # 8000723c <__putc>
    80004274:	04100513          	li	a0,65
    80004278:	00003097          	auipc	ra,0x3
    8000427c:	fc4080e7          	jalr	-60(ra) # 8000723c <__putc>
    80004280:	05400513          	li	a0,84
    80004284:	00003097          	auipc	ra,0x3
    80004288:	fb8080e7          	jalr	-72(ra) # 8000723c <__putc>
    8000428c:	04100513          	li	a0,65
    80004290:	00003097          	auipc	ra,0x3
    80004294:	fac080e7          	jalr	-84(ra) # 8000723c <__putc>
    80004298:	04c00513          	li	a0,76
    8000429c:	00003097          	auipc	ra,0x3
    800042a0:	fa0080e7          	jalr	-96(ra) # 8000723c <__putc>
    800042a4:	02000513          	li	a0,32
    800042a8:	00003097          	auipc	ra,0x3
    800042ac:	f94080e7          	jalr	-108(ra) # 8000723c <__putc>
        __putc('E');__putc('R');__putc('R');__putc('O');__putc('R');__putc('\n');
    800042b0:	04500513          	li	a0,69
    800042b4:	00003097          	auipc	ra,0x3
    800042b8:	f88080e7          	jalr	-120(ra) # 8000723c <__putc>
    800042bc:	05200513          	li	a0,82
    800042c0:	00003097          	auipc	ra,0x3
    800042c4:	f7c080e7          	jalr	-132(ra) # 8000723c <__putc>
    800042c8:	05200513          	li	a0,82
    800042cc:	00003097          	auipc	ra,0x3
    800042d0:	f70080e7          	jalr	-144(ra) # 8000723c <__putc>
    800042d4:	04f00513          	li	a0,79
    800042d8:	00003097          	auipc	ra,0x3
    800042dc:	f64080e7          	jalr	-156(ra) # 8000723c <__putc>
    800042e0:	05200513          	li	a0,82
    800042e4:	00003097          	auipc	ra,0x3
    800042e8:	f58080e7          	jalr	-168(ra) # 8000723c <__putc>
    800042ec:	00a00513          	li	a0,10
    800042f0:	00003097          	auipc	ra,0x3
    800042f4:	f4c080e7          	jalr	-180(ra) # 8000723c <__putc>
        __putc('S');__putc('C');__putc('A');__putc('U');__putc('S');__putc('E');__putc(' ');__putc(chScause);__putc('\n');
    800042f8:	05300513          	li	a0,83
    800042fc:	00003097          	auipc	ra,0x3
    80004300:	f40080e7          	jalr	-192(ra) # 8000723c <__putc>
    80004304:	04300513          	li	a0,67
    80004308:	00003097          	auipc	ra,0x3
    8000430c:	f34080e7          	jalr	-204(ra) # 8000723c <__putc>
    80004310:	04100513          	li	a0,65
    80004314:	00003097          	auipc	ra,0x3
    80004318:	f28080e7          	jalr	-216(ra) # 8000723c <__putc>
    8000431c:	05500513          	li	a0,85
    80004320:	00003097          	auipc	ra,0x3
    80004324:	f1c080e7          	jalr	-228(ra) # 8000723c <__putc>
    80004328:	05300513          	li	a0,83
    8000432c:	00003097          	auipc	ra,0x3
    80004330:	f10080e7          	jalr	-240(ra) # 8000723c <__putc>
    80004334:	04500513          	li	a0,69
    80004338:	00003097          	auipc	ra,0x3
    8000433c:	f04080e7          	jalr	-252(ra) # 8000723c <__putc>
    80004340:	02000513          	li	a0,32
    80004344:	00003097          	auipc	ra,0x3
    80004348:	ef8080e7          	jalr	-264(ra) # 8000723c <__putc>
    8000434c:	00048513          	mv	a0,s1
    80004350:	00003097          	auipc	ra,0x3
    80004354:	eec080e7          	jalr	-276(ra) # 8000723c <__putc>
    80004358:	00a00513          	li	a0,10
    8000435c:	00003097          	auipc	ra,0x3
    80004360:	ee0080e7          	jalr	-288(ra) # 8000723c <__putc>

        *(int*)0x100000 = 0x5555;
    80004364:	00100737          	lui	a4,0x100
    80004368:	000057b7          	lui	a5,0x5
    8000436c:	5557879b          	addiw	a5,a5,1365
    80004370:	00f72023          	sw	a5,0(a4) # 100000 <_entry-0x7ff00000>
    }
    80004374:	0740006f          	j	800043e8 <_ZN5Riscv20handleSupervisorTrapEv+0x1d8>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80004378:	141027f3          	csrr	a5,sepc
    8000437c:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    80004380:	fd843783          	ld	a5,-40(s0)
        volatile uint64 sepc = readSEPC() + 4;
    80004384:	00478793          	addi	a5,a5,4 # 5004 <_entry-0x7fffaffc>
    80004388:	faf43c23          	sd	a5,-72(s0)
}

inline uint64 Riscv::readSSTATUS() {
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000438c:	100027f3          	csrr	a5,sstatus
    80004390:	fcf43823          	sd	a5,-48(s0)
    return sstatus;
    80004394:	fd043783          	ld	a5,-48(s0)
        volatile uint64 sstatus = readSSTATUS();
    80004398:	fcf43023          	sd	a5,-64(s0)
        __asm__ volatile ("ld %0, 10 * 8(fp)" : "=r" (ecallReason));
    8000439c:	05043783          	ld	a5,80(s0)
        switch (ecallReason) {
    800043a0:	04200713          	li	a4,66
    800043a4:	02f76a63          	bltu	a4,a5,800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
    800043a8:	00279793          	slli	a5,a5,0x2
    800043ac:	00004717          	auipc	a4,0x4
    800043b0:	0a470713          	addi	a4,a4,164 # 80008450 <CONSOLE_STATUS+0x440>
    800043b4:	00e787b3          	add	a5,a5,a4
    800043b8:	0007a783          	lw	a5,0(a5)
    800043bc:	00e787b3          	add	a5,a5,a4
    800043c0:	00078067          	jr	a5
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r"(size));
    800043c4:	05843503          	ld	a0,88(s0)
                ptr = (uint64)MemoryAllocator::mem_alloc((size_t)size);
    800043c8:	00651513          	slli	a0,a0,0x6
    800043cc:	00001097          	auipc	ra,0x1
    800043d0:	870080e7          	jalr	-1936(ra) # 80004c3c <_ZN15MemoryAllocator9mem_allocEm>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r"(ptr));
    800043d4:	04a43823          	sd	a0,80(s0)
        writeSSTATUS(sstatus);
    800043d8:	fc043783          	ld	a5,-64(s0)
}

inline void Riscv::writeSSTATUS(uint64 sstatus) {
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800043dc:	10079073          	csrw	sstatus,a5
        writeSEPC(sepc);
    800043e0:	fb843783          	ld	a5,-72(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800043e4:	14179073          	csrw	sepc,a5
    800043e8:	04813083          	ld	ra,72(sp)
    800043ec:	04013403          	ld	s0,64(sp)
    800043f0:	03813483          	ld	s1,56(sp)
    800043f4:	05010113          	addi	sp,sp,80
    800043f8:	00008067          	ret
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (ptr));
    800043fc:	05843503          	ld	a0,88(s0)
                ret = MemoryAllocator::mem_free((void*)ptr);
    80004400:	00001097          	auipc	ra,0x1
    80004404:	980080e7          	jalr	-1664(ra) # 80004d80 <_ZN15MemoryAllocator8mem_freeEPv>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    80004408:	04a43823          	sd	a0,80(s0)
                break;
    8000440c:	fcdff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
    80004410:	05843483          	ld	s1,88(s0)
                __asm__ volatile ("ld %0, 12 * 8(fp)" : "=r" (start_routine));
    80004414:	06043503          	ld	a0,96(s0)
                __asm__ volatile ("ld %0, 13 * 8(fp)" : "=r" (arg));
    80004418:	06843583          	ld	a1,104(s0)
                __asm__ volatile ("ld %0, 14 * 8(fp)" : "=r" (stack_space));
    8000441c:	07043603          	ld	a2,112(s0)
                TCB* newThread = TCB::createThread((TCB::Body)start_routine, (void*)arg, (char*)stack_space);
    80004420:	00000097          	auipc	ra,0x0
    80004424:	918080e7          	jalr	-1768(ra) # 80003d38 <_ZN3TCB12createThreadEPFvPvES0_Pc>
                *((TCB**)handle) = newThread;
    80004428:	00a4b023          	sd	a0,0(s1)
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    8000442c:	00000793          	li	a5,0
    80004430:	04f43823          	sd	a5,80(s0)
                break;
    80004434:	fa5ff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                TCB::running->setFinished(true);
    80004438:	00006797          	auipc	a5,0x6
    8000443c:	ac07b783          	ld	a5,-1344(a5) # 80009ef8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80004440:	0007b783          	ld	a5,0(a5)
    void setFinished (bool val) { finished = val; }
    80004444:	00100713          	li	a4,1
    80004448:	02e784a3          	sb	a4,41(a5)
                TCB::dispatch();
    8000444c:	00000097          	auipc	ra,0x0
    80004450:	9b8080e7          	jalr	-1608(ra) # 80003e04 <_ZN3TCB8dispatchEv>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    80004454:	00000793          	li	a5,0
    80004458:	04f43823          	sd	a5,80(s0)
                break;
    8000445c:	f7dff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                TCB::dispatch();
    80004460:	00000097          	auipc	ra,0x0
    80004464:	9a4080e7          	jalr	-1628(ra) # 80003e04 <_ZN3TCB8dispatchEv>
                break;
    80004468:	f71ff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                char c = __getc();
    8000446c:	00003097          	auipc	ra,0x3
    80004470:	e0c080e7          	jalr	-500(ra) # 80007278 <__getc>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (c));
    80004474:	04a43823          	sd	a0,80(s0)
                break;
    80004478:	f61ff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (c));
    8000447c:	05843503          	ld	a0,88(s0)
                __putc(c);
    80004480:	0ff57513          	andi	a0,a0,255
    80004484:	00003097          	auipc	ra,0x3
    80004488:	db8080e7          	jalr	-584(ra) # 8000723c <__putc>
                break;
    8000448c:	f4dff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
    80004490:	05843483          	ld	s1,88(s0)
                __asm__ volatile ("ld %0, 12 * 8(fp)" : "=r" (init));
    80004494:	06043503          	ld	a0,96(s0)
                Sem* newSem = Sem::sem_open(init);
    80004498:	ffffe097          	auipc	ra,0xffffe
    8000449c:	f28080e7          	jalr	-216(ra) # 800023c0 <_ZN3Sem8sem_openEm>
                *((Sem**)handle) = newSem;
    800044a0:	00a4b023          	sd	a0,0(s1)
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    800044a4:	00000793          	li	a5,0
    800044a8:	04f43823          	sd	a5,80(s0)
                break;
    800044ac:	f2dff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
    800044b0:	05843503          	ld	a0,88(s0)
                ((Sem*)handle)->sem_close();
    800044b4:	ffffe097          	auipc	ra,0xffffe
    800044b8:	f4c080e7          	jalr	-180(ra) # 80002400 <_ZN3Sem9sem_closeEv>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    800044bc:	00000793          	li	a5,0
    800044c0:	04f43823          	sd	a5,80(s0)
                break;
    800044c4:	f15ff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
    800044c8:	05843503          	ld	a0,88(s0)
                ((Sem*)handle)->sem_wait();
    800044cc:	ffffe097          	auipc	ra,0xffffe
    800044d0:	f98080e7          	jalr	-104(ra) # 80002464 <_ZN3Sem8sem_waitEv>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    800044d4:	00000793          	li	a5,0
    800044d8:	04f43823          	sd	a5,80(s0)
                break;
    800044dc:	efdff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
    800044e0:	05843503          	ld	a0,88(s0)
                ((Sem*)handle)->sem_signal();
    800044e4:	ffffe097          	auipc	ra,0xffffe
    800044e8:	018080e7          	jalr	24(ra) # 800024fc <_ZN3Sem10sem_signalEv>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    800044ec:	00000793          	li	a5,0
    800044f0:	04f43823          	sd	a5,80(s0)
                break;
    800044f4:	ee5ff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
                __asm__ volatile ("ld %0, 11 * 8(fp)" : "=r" (handle));
    800044f8:	05843503          	ld	a0,88(s0)
                ((Sem*)handle)->sem_trywait();
    800044fc:	ffffe097          	auipc	ra,0xffffe
    80004500:	08c080e7          	jalr	140(ra) # 80002588 <_ZN3Sem11sem_trywaitEv>
                __asm__ volatile ("sd %0, 10 * 8(fp)" : : "r" (ret));
    80004504:	00000793          	li	a5,0
    80004508:	04f43823          	sd	a5,80(s0)
                break;
    8000450c:	ecdff06f          	j	800043d8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80004510:	00200793          	li	a5,2
    80004514:	1447b073          	csrc	sip,a5
}
    80004518:	ed1ff06f          	j	800043e8 <_ZN5Riscv20handleSupervisorTrapEv+0x1d8>
        console_handler();
    8000451c:	00003097          	auipc	ra,0x3
    80004520:	d94080e7          	jalr	-620(ra) # 800072b0 <console_handler>
    80004524:	ec5ff06f          	j	800043e8 <_ZN5Riscv20handleSupervisorTrapEv+0x1d8>

0000000080004528 <_Z41__static_initialization_and_destruction_0ii>:
    return queue.popFront();
}

void Scheduler::put(TCB* tcb){
    queue.addRear(tcb);
    80004528:	ff010113          	addi	sp,sp,-16
    8000452c:	00813423          	sd	s0,8(sp)
    80004530:	01010413          	addi	s0,sp,16
    80004534:	00100793          	li	a5,1
    80004538:	00f50863          	beq	a0,a5,80004548 <_Z41__static_initialization_and_destruction_0ii+0x20>
    8000453c:	00813403          	ld	s0,8(sp)
    80004540:	01010113          	addi	sp,sp,16
    80004544:	00008067          	ret
    80004548:	000107b7          	lui	a5,0x10
    8000454c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004550:	fef596e3          	bne	a1,a5,8000453c <_Z41__static_initialization_and_destruction_0ii+0x14>
        elem* next;
    }Elem;

    Elem* head;

    List () : head(0) {};
    80004554:	00006797          	auipc	a5,0x6
    80004558:	a207be23          	sd	zero,-1476(a5) # 80009f90 <_ZN9Scheduler5queueE>
    8000455c:	fe1ff06f          	j	8000453c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080004560 <_ZN9Scheduler3getEv>:
TCB* Scheduler::get(){
    80004560:	fe010113          	addi	sp,sp,-32
    80004564:	00113c23          	sd	ra,24(sp)
    80004568:	00813823          	sd	s0,16(sp)
    8000456c:	00913423          	sd	s1,8(sp)
    80004570:	02010413          	addi	s0,sp,32
        }
        else head = newElem;
    }

    TCB* popFront () {
        if (head == 0) return 0;
    80004574:	00006517          	auipc	a0,0x6
    80004578:	a1c53503          	ld	a0,-1508(a0) # 80009f90 <_ZN9Scheduler5queueE>
    8000457c:	02050a63          	beqz	a0,800045b0 <_ZN9Scheduler3getEv+0x50>
        TCB* tmpTCB = head->data;
    80004580:	00053483          	ld	s1,0(a0)
        Elem* tmpElem = head;

        head = head->next;
    80004584:	00853783          	ld	a5,8(a0)
    80004588:	00006717          	auipc	a4,0x6
    8000458c:	a0f73423          	sd	a5,-1528(a4) # 80009f90 <_ZN9Scheduler5queueE>
        if(mem_free(tmpElem)) {};
    80004590:	ffffd097          	auipc	ra,0xffffd
    80004594:	cf8080e7          	jalr	-776(ra) # 80001288 <_Z8mem_freePv>
}
    80004598:	00048513          	mv	a0,s1
    8000459c:	01813083          	ld	ra,24(sp)
    800045a0:	01013403          	ld	s0,16(sp)
    800045a4:	00813483          	ld	s1,8(sp)
    800045a8:	02010113          	addi	sp,sp,32
    800045ac:	00008067          	ret
        if (head == 0) return 0;
    800045b0:	00050493          	mv	s1,a0
    return queue.popFront();
    800045b4:	fe5ff06f          	j	80004598 <_ZN9Scheduler3getEv+0x38>

00000000800045b8 <_ZN9Scheduler3putEP3TCB>:
void Scheduler::put(TCB* tcb){
    800045b8:	fe010113          	addi	sp,sp,-32
    800045bc:	00113c23          	sd	ra,24(sp)
    800045c0:	00813823          	sd	s0,16(sp)
    800045c4:	00913423          	sd	s1,8(sp)
    800045c8:	02010413          	addi	s0,sp,32
    800045cc:	00050493          	mv	s1,a0
        Elem* newElem = (Elem*)mem_alloc(sizeof(Elem));
    800045d0:	01000513          	li	a0,16
    800045d4:	ffffd097          	auipc	ra,0xffffd
    800045d8:	c68080e7          	jalr	-920(ra) # 8000123c <_Z9mem_allocm>
        newElem->data = data;
    800045dc:	00953023          	sd	s1,0(a0)
        newElem->next = 0;
    800045e0:	00053423          	sd	zero,8(a0)
        if (head) {
    800045e4:	00006797          	auipc	a5,0x6
    800045e8:	9ac7b783          	ld	a5,-1620(a5) # 80009f90 <_ZN9Scheduler5queueE>
    800045ec:	02078463          	beqz	a5,80004614 <_ZN9Scheduler3putEP3TCB+0x5c>
            for (curr = head; curr->next != 0; curr = curr->next);
    800045f0:	00078713          	mv	a4,a5
    800045f4:	0087b783          	ld	a5,8(a5)
    800045f8:	fe079ce3          	bnez	a5,800045f0 <_ZN9Scheduler3putEP3TCB+0x38>
            curr->next = newElem;
    800045fc:	00a73423          	sd	a0,8(a4)
    80004600:	01813083          	ld	ra,24(sp)
    80004604:	01013403          	ld	s0,16(sp)
    80004608:	00813483          	ld	s1,8(sp)
    8000460c:	02010113          	addi	sp,sp,32
    80004610:	00008067          	ret
        else head = newElem;
    80004614:	00006797          	auipc	a5,0x6
    80004618:	96a7be23          	sd	a0,-1668(a5) # 80009f90 <_ZN9Scheduler5queueE>
    8000461c:	fe5ff06f          	j	80004600 <_ZN9Scheduler3putEP3TCB+0x48>

0000000080004620 <_GLOBAL__sub_I__ZN9Scheduler5queueE>:
    80004620:	ff010113          	addi	sp,sp,-16
    80004624:	00113423          	sd	ra,8(sp)
    80004628:	00813023          	sd	s0,0(sp)
    8000462c:	01010413          	addi	s0,sp,16
    80004630:	000105b7          	lui	a1,0x10
    80004634:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80004638:	00100513          	li	a0,1
    8000463c:	00000097          	auipc	ra,0x0
    80004640:	eec080e7          	jalr	-276(ra) # 80004528 <_Z41__static_initialization_and_destruction_0ii>
    80004644:	00813083          	ld	ra,8(sp)
    80004648:	00013403          	ld	s0,0(sp)
    8000464c:	01010113          	addi	sp,sp,16
    80004650:	00008067          	ret

0000000080004654 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004654:	fe010113          	addi	sp,sp,-32
    80004658:	00113c23          	sd	ra,24(sp)
    8000465c:	00813823          	sd	s0,16(sp)
    80004660:	00913423          	sd	s1,8(sp)
    80004664:	01213023          	sd	s2,0(sp)
    80004668:	02010413          	addi	s0,sp,32
    8000466c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004670:	00100793          	li	a5,1
    80004674:	02a7f863          	bgeu	a5,a0,800046a4 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004678:	00a00793          	li	a5,10
    8000467c:	02f577b3          	remu	a5,a0,a5
    80004680:	02078e63          	beqz	a5,800046bc <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004684:	fff48513          	addi	a0,s1,-1
    80004688:	00000097          	auipc	ra,0x0
    8000468c:	fcc080e7          	jalr	-52(ra) # 80004654 <_ZL9fibonaccim>
    80004690:	00050913          	mv	s2,a0
    80004694:	ffe48513          	addi	a0,s1,-2
    80004698:	00000097          	auipc	ra,0x0
    8000469c:	fbc080e7          	jalr	-68(ra) # 80004654 <_ZL9fibonaccim>
    800046a0:	00a90533          	add	a0,s2,a0
}
    800046a4:	01813083          	ld	ra,24(sp)
    800046a8:	01013403          	ld	s0,16(sp)
    800046ac:	00813483          	ld	s1,8(sp)
    800046b0:	00013903          	ld	s2,0(sp)
    800046b4:	02010113          	addi	sp,sp,32
    800046b8:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800046bc:	ffffd097          	auipc	ra,0xffffd
    800046c0:	cc0080e7          	jalr	-832(ra) # 8000137c <_Z15thread_dispatchv>
    800046c4:	fc1ff06f          	j	80004684 <_ZL9fibonaccim+0x30>

00000000800046c8 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800046c8:	fe010113          	addi	sp,sp,-32
    800046cc:	00113c23          	sd	ra,24(sp)
    800046d0:	00813823          	sd	s0,16(sp)
    800046d4:	00913423          	sd	s1,8(sp)
    800046d8:	01213023          	sd	s2,0(sp)
    800046dc:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800046e0:	00a00493          	li	s1,10
    800046e4:	0400006f          	j	80004724 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800046e8:	00004517          	auipc	a0,0x4
    800046ec:	a8050513          	addi	a0,a0,-1408 # 80008168 <CONSOLE_STATUS+0x158>
    800046f0:	fffff097          	auipc	ra,0xfffff
    800046f4:	d38080e7          	jalr	-712(ra) # 80003428 <_Z11printStringPKc>
    800046f8:	00000613          	li	a2,0
    800046fc:	00a00593          	li	a1,10
    80004700:	00048513          	mv	a0,s1
    80004704:	fffff097          	auipc	ra,0xfffff
    80004708:	ed4080e7          	jalr	-300(ra) # 800035d8 <_Z8printIntiii>
    8000470c:	00004517          	auipc	a0,0x4
    80004710:	c7c50513          	addi	a0,a0,-900 # 80008388 <CONSOLE_STATUS+0x378>
    80004714:	fffff097          	auipc	ra,0xfffff
    80004718:	d14080e7          	jalr	-748(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000471c:	0014849b          	addiw	s1,s1,1
    80004720:	0ff4f493          	andi	s1,s1,255
    80004724:	00c00793          	li	a5,12
    80004728:	fc97f0e3          	bgeu	a5,s1,800046e8 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000472c:	00004517          	auipc	a0,0x4
    80004730:	a4450513          	addi	a0,a0,-1468 # 80008170 <CONSOLE_STATUS+0x160>
    80004734:	fffff097          	auipc	ra,0xfffff
    80004738:	cf4080e7          	jalr	-780(ra) # 80003428 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000473c:	00500313          	li	t1,5
    thread_dispatch();
    80004740:	ffffd097          	auipc	ra,0xffffd
    80004744:	c3c080e7          	jalr	-964(ra) # 8000137c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004748:	01000513          	li	a0,16
    8000474c:	00000097          	auipc	ra,0x0
    80004750:	f08080e7          	jalr	-248(ra) # 80004654 <_ZL9fibonaccim>
    80004754:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004758:	00004517          	auipc	a0,0x4
    8000475c:	a2850513          	addi	a0,a0,-1496 # 80008180 <CONSOLE_STATUS+0x170>
    80004760:	fffff097          	auipc	ra,0xfffff
    80004764:	cc8080e7          	jalr	-824(ra) # 80003428 <_Z11printStringPKc>
    80004768:	00000613          	li	a2,0
    8000476c:	00a00593          	li	a1,10
    80004770:	0009051b          	sext.w	a0,s2
    80004774:	fffff097          	auipc	ra,0xfffff
    80004778:	e64080e7          	jalr	-412(ra) # 800035d8 <_Z8printIntiii>
    8000477c:	00004517          	auipc	a0,0x4
    80004780:	c0c50513          	addi	a0,a0,-1012 # 80008388 <CONSOLE_STATUS+0x378>
    80004784:	fffff097          	auipc	ra,0xfffff
    80004788:	ca4080e7          	jalr	-860(ra) # 80003428 <_Z11printStringPKc>
    8000478c:	0400006f          	j	800047cc <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004790:	00004517          	auipc	a0,0x4
    80004794:	9d850513          	addi	a0,a0,-1576 # 80008168 <CONSOLE_STATUS+0x158>
    80004798:	fffff097          	auipc	ra,0xfffff
    8000479c:	c90080e7          	jalr	-880(ra) # 80003428 <_Z11printStringPKc>
    800047a0:	00000613          	li	a2,0
    800047a4:	00a00593          	li	a1,10
    800047a8:	00048513          	mv	a0,s1
    800047ac:	fffff097          	auipc	ra,0xfffff
    800047b0:	e2c080e7          	jalr	-468(ra) # 800035d8 <_Z8printIntiii>
    800047b4:	00004517          	auipc	a0,0x4
    800047b8:	bd450513          	addi	a0,a0,-1068 # 80008388 <CONSOLE_STATUS+0x378>
    800047bc:	fffff097          	auipc	ra,0xfffff
    800047c0:	c6c080e7          	jalr	-916(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800047c4:	0014849b          	addiw	s1,s1,1
    800047c8:	0ff4f493          	andi	s1,s1,255
    800047cc:	00f00793          	li	a5,15
    800047d0:	fc97f0e3          	bgeu	a5,s1,80004790 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800047d4:	00004517          	auipc	a0,0x4
    800047d8:	9bc50513          	addi	a0,a0,-1604 # 80008190 <CONSOLE_STATUS+0x180>
    800047dc:	fffff097          	auipc	ra,0xfffff
    800047e0:	c4c080e7          	jalr	-948(ra) # 80003428 <_Z11printStringPKc>
    finishedD = true;
    800047e4:	00100793          	li	a5,1
    800047e8:	00005717          	auipc	a4,0x5
    800047ec:	7af70823          	sb	a5,1968(a4) # 80009f98 <_ZL9finishedD>
    thread_dispatch();
    800047f0:	ffffd097          	auipc	ra,0xffffd
    800047f4:	b8c080e7          	jalr	-1140(ra) # 8000137c <_Z15thread_dispatchv>
}
    800047f8:	01813083          	ld	ra,24(sp)
    800047fc:	01013403          	ld	s0,16(sp)
    80004800:	00813483          	ld	s1,8(sp)
    80004804:	00013903          	ld	s2,0(sp)
    80004808:	02010113          	addi	sp,sp,32
    8000480c:	00008067          	ret

0000000080004810 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80004810:	fe010113          	addi	sp,sp,-32
    80004814:	00113c23          	sd	ra,24(sp)
    80004818:	00813823          	sd	s0,16(sp)
    8000481c:	00913423          	sd	s1,8(sp)
    80004820:	01213023          	sd	s2,0(sp)
    80004824:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004828:	00000493          	li	s1,0
    8000482c:	0400006f          	j	8000486c <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80004830:	00004517          	auipc	a0,0x4
    80004834:	90850513          	addi	a0,a0,-1784 # 80008138 <CONSOLE_STATUS+0x128>
    80004838:	fffff097          	auipc	ra,0xfffff
    8000483c:	bf0080e7          	jalr	-1040(ra) # 80003428 <_Z11printStringPKc>
    80004840:	00000613          	li	a2,0
    80004844:	00a00593          	li	a1,10
    80004848:	00048513          	mv	a0,s1
    8000484c:	fffff097          	auipc	ra,0xfffff
    80004850:	d8c080e7          	jalr	-628(ra) # 800035d8 <_Z8printIntiii>
    80004854:	00004517          	auipc	a0,0x4
    80004858:	b3450513          	addi	a0,a0,-1228 # 80008388 <CONSOLE_STATUS+0x378>
    8000485c:	fffff097          	auipc	ra,0xfffff
    80004860:	bcc080e7          	jalr	-1076(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004864:	0014849b          	addiw	s1,s1,1
    80004868:	0ff4f493          	andi	s1,s1,255
    8000486c:	00200793          	li	a5,2
    80004870:	fc97f0e3          	bgeu	a5,s1,80004830 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004874:	00004517          	auipc	a0,0x4
    80004878:	8cc50513          	addi	a0,a0,-1844 # 80008140 <CONSOLE_STATUS+0x130>
    8000487c:	fffff097          	auipc	ra,0xfffff
    80004880:	bac080e7          	jalr	-1108(ra) # 80003428 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004884:	00700313          	li	t1,7
    thread_dispatch();
    80004888:	ffffd097          	auipc	ra,0xffffd
    8000488c:	af4080e7          	jalr	-1292(ra) # 8000137c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004890:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004894:	00004517          	auipc	a0,0x4
    80004898:	8bc50513          	addi	a0,a0,-1860 # 80008150 <CONSOLE_STATUS+0x140>
    8000489c:	fffff097          	auipc	ra,0xfffff
    800048a0:	b8c080e7          	jalr	-1140(ra) # 80003428 <_Z11printStringPKc>
    800048a4:	00000613          	li	a2,0
    800048a8:	00a00593          	li	a1,10
    800048ac:	0009051b          	sext.w	a0,s2
    800048b0:	fffff097          	auipc	ra,0xfffff
    800048b4:	d28080e7          	jalr	-728(ra) # 800035d8 <_Z8printIntiii>
    800048b8:	00004517          	auipc	a0,0x4
    800048bc:	ad050513          	addi	a0,a0,-1328 # 80008388 <CONSOLE_STATUS+0x378>
    800048c0:	fffff097          	auipc	ra,0xfffff
    800048c4:	b68080e7          	jalr	-1176(ra) # 80003428 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800048c8:	00c00513          	li	a0,12
    800048cc:	00000097          	auipc	ra,0x0
    800048d0:	d88080e7          	jalr	-632(ra) # 80004654 <_ZL9fibonaccim>
    800048d4:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800048d8:	00004517          	auipc	a0,0x4
    800048dc:	88050513          	addi	a0,a0,-1920 # 80008158 <CONSOLE_STATUS+0x148>
    800048e0:	fffff097          	auipc	ra,0xfffff
    800048e4:	b48080e7          	jalr	-1208(ra) # 80003428 <_Z11printStringPKc>
    800048e8:	00000613          	li	a2,0
    800048ec:	00a00593          	li	a1,10
    800048f0:	0009051b          	sext.w	a0,s2
    800048f4:	fffff097          	auipc	ra,0xfffff
    800048f8:	ce4080e7          	jalr	-796(ra) # 800035d8 <_Z8printIntiii>
    800048fc:	00004517          	auipc	a0,0x4
    80004900:	a8c50513          	addi	a0,a0,-1396 # 80008388 <CONSOLE_STATUS+0x378>
    80004904:	fffff097          	auipc	ra,0xfffff
    80004908:	b24080e7          	jalr	-1244(ra) # 80003428 <_Z11printStringPKc>
    8000490c:	0400006f          	j	8000494c <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004910:	00004517          	auipc	a0,0x4
    80004914:	82850513          	addi	a0,a0,-2008 # 80008138 <CONSOLE_STATUS+0x128>
    80004918:	fffff097          	auipc	ra,0xfffff
    8000491c:	b10080e7          	jalr	-1264(ra) # 80003428 <_Z11printStringPKc>
    80004920:	00000613          	li	a2,0
    80004924:	00a00593          	li	a1,10
    80004928:	00048513          	mv	a0,s1
    8000492c:	fffff097          	auipc	ra,0xfffff
    80004930:	cac080e7          	jalr	-852(ra) # 800035d8 <_Z8printIntiii>
    80004934:	00004517          	auipc	a0,0x4
    80004938:	a5450513          	addi	a0,a0,-1452 # 80008388 <CONSOLE_STATUS+0x378>
    8000493c:	fffff097          	auipc	ra,0xfffff
    80004940:	aec080e7          	jalr	-1300(ra) # 80003428 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004944:	0014849b          	addiw	s1,s1,1
    80004948:	0ff4f493          	andi	s1,s1,255
    8000494c:	00500793          	li	a5,5
    80004950:	fc97f0e3          	bgeu	a5,s1,80004910 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004954:	00003517          	auipc	a0,0x3
    80004958:	7bc50513          	addi	a0,a0,1980 # 80008110 <CONSOLE_STATUS+0x100>
    8000495c:	fffff097          	auipc	ra,0xfffff
    80004960:	acc080e7          	jalr	-1332(ra) # 80003428 <_Z11printStringPKc>
    finishedC = true;
    80004964:	00100793          	li	a5,1
    80004968:	00005717          	auipc	a4,0x5
    8000496c:	62f708a3          	sb	a5,1585(a4) # 80009f99 <_ZL9finishedC>
    thread_dispatch();
    80004970:	ffffd097          	auipc	ra,0xffffd
    80004974:	a0c080e7          	jalr	-1524(ra) # 8000137c <_Z15thread_dispatchv>
}
    80004978:	01813083          	ld	ra,24(sp)
    8000497c:	01013403          	ld	s0,16(sp)
    80004980:	00813483          	ld	s1,8(sp)
    80004984:	00013903          	ld	s2,0(sp)
    80004988:	02010113          	addi	sp,sp,32
    8000498c:	00008067          	ret

0000000080004990 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004990:	fe010113          	addi	sp,sp,-32
    80004994:	00113c23          	sd	ra,24(sp)
    80004998:	00813823          	sd	s0,16(sp)
    8000499c:	00913423          	sd	s1,8(sp)
    800049a0:	01213023          	sd	s2,0(sp)
    800049a4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800049a8:	00000913          	li	s2,0
    800049ac:	0400006f          	j	800049ec <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800049b0:	ffffd097          	auipc	ra,0xffffd
    800049b4:	9cc080e7          	jalr	-1588(ra) # 8000137c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800049b8:	00148493          	addi	s1,s1,1
    800049bc:	000027b7          	lui	a5,0x2
    800049c0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800049c4:	0097ee63          	bltu	a5,s1,800049e0 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800049c8:	00000713          	li	a4,0
    800049cc:	000077b7          	lui	a5,0x7
    800049d0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800049d4:	fce7eee3          	bltu	a5,a4,800049b0 <_ZL11workerBodyBPv+0x20>
    800049d8:	00170713          	addi	a4,a4,1
    800049dc:	ff1ff06f          	j	800049cc <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    800049e0:	00a00793          	li	a5,10
    800049e4:	04f90663          	beq	s2,a5,80004a30 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    800049e8:	00190913          	addi	s2,s2,1
    800049ec:	00f00793          	li	a5,15
    800049f0:	0527e463          	bltu	a5,s2,80004a38 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800049f4:	00003517          	auipc	a0,0x3
    800049f8:	72c50513          	addi	a0,a0,1836 # 80008120 <CONSOLE_STATUS+0x110>
    800049fc:	fffff097          	auipc	ra,0xfffff
    80004a00:	a2c080e7          	jalr	-1492(ra) # 80003428 <_Z11printStringPKc>
    80004a04:	00000613          	li	a2,0
    80004a08:	00a00593          	li	a1,10
    80004a0c:	0009051b          	sext.w	a0,s2
    80004a10:	fffff097          	auipc	ra,0xfffff
    80004a14:	bc8080e7          	jalr	-1080(ra) # 800035d8 <_Z8printIntiii>
    80004a18:	00004517          	auipc	a0,0x4
    80004a1c:	97050513          	addi	a0,a0,-1680 # 80008388 <CONSOLE_STATUS+0x378>
    80004a20:	fffff097          	auipc	ra,0xfffff
    80004a24:	a08080e7          	jalr	-1528(ra) # 80003428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004a28:	00000493          	li	s1,0
    80004a2c:	f91ff06f          	j	800049bc <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80004a30:	14102ff3          	csrr	t6,sepc
    80004a34:	fb5ff06f          	j	800049e8 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80004a38:	00003517          	auipc	a0,0x3
    80004a3c:	6f050513          	addi	a0,a0,1776 # 80008128 <CONSOLE_STATUS+0x118>
    80004a40:	fffff097          	auipc	ra,0xfffff
    80004a44:	9e8080e7          	jalr	-1560(ra) # 80003428 <_Z11printStringPKc>
    finishedB = true;
    80004a48:	00100793          	li	a5,1
    80004a4c:	00005717          	auipc	a4,0x5
    80004a50:	54f70723          	sb	a5,1358(a4) # 80009f9a <_ZL9finishedB>
    thread_dispatch();
    80004a54:	ffffd097          	auipc	ra,0xffffd
    80004a58:	928080e7          	jalr	-1752(ra) # 8000137c <_Z15thread_dispatchv>
}
    80004a5c:	01813083          	ld	ra,24(sp)
    80004a60:	01013403          	ld	s0,16(sp)
    80004a64:	00813483          	ld	s1,8(sp)
    80004a68:	00013903          	ld	s2,0(sp)
    80004a6c:	02010113          	addi	sp,sp,32
    80004a70:	00008067          	ret

0000000080004a74 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004a74:	fe010113          	addi	sp,sp,-32
    80004a78:	00113c23          	sd	ra,24(sp)
    80004a7c:	00813823          	sd	s0,16(sp)
    80004a80:	00913423          	sd	s1,8(sp)
    80004a84:	01213023          	sd	s2,0(sp)
    80004a88:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004a8c:	00000913          	li	s2,0
    80004a90:	0380006f          	j	80004ac8 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004a94:	ffffd097          	auipc	ra,0xffffd
    80004a98:	8e8080e7          	jalr	-1816(ra) # 8000137c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004a9c:	00148493          	addi	s1,s1,1
    80004aa0:	000027b7          	lui	a5,0x2
    80004aa4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004aa8:	0097ee63          	bltu	a5,s1,80004ac4 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004aac:	00000713          	li	a4,0
    80004ab0:	000077b7          	lui	a5,0x7
    80004ab4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004ab8:	fce7eee3          	bltu	a5,a4,80004a94 <_ZL11workerBodyAPv+0x20>
    80004abc:	00170713          	addi	a4,a4,1
    80004ac0:	ff1ff06f          	j	80004ab0 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004ac4:	00190913          	addi	s2,s2,1
    80004ac8:	00900793          	li	a5,9
    80004acc:	0527e063          	bltu	a5,s2,80004b0c <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004ad0:	00003517          	auipc	a0,0x3
    80004ad4:	63850513          	addi	a0,a0,1592 # 80008108 <CONSOLE_STATUS+0xf8>
    80004ad8:	fffff097          	auipc	ra,0xfffff
    80004adc:	950080e7          	jalr	-1712(ra) # 80003428 <_Z11printStringPKc>
    80004ae0:	00000613          	li	a2,0
    80004ae4:	00a00593          	li	a1,10
    80004ae8:	0009051b          	sext.w	a0,s2
    80004aec:	fffff097          	auipc	ra,0xfffff
    80004af0:	aec080e7          	jalr	-1300(ra) # 800035d8 <_Z8printIntiii>
    80004af4:	00004517          	auipc	a0,0x4
    80004af8:	89450513          	addi	a0,a0,-1900 # 80008388 <CONSOLE_STATUS+0x378>
    80004afc:	fffff097          	auipc	ra,0xfffff
    80004b00:	92c080e7          	jalr	-1748(ra) # 80003428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004b04:	00000493          	li	s1,0
    80004b08:	f99ff06f          	j	80004aa0 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80004b0c:	00003517          	auipc	a0,0x3
    80004b10:	60450513          	addi	a0,a0,1540 # 80008110 <CONSOLE_STATUS+0x100>
    80004b14:	fffff097          	auipc	ra,0xfffff
    80004b18:	914080e7          	jalr	-1772(ra) # 80003428 <_Z11printStringPKc>
    finishedA = true;
    80004b1c:	00100793          	li	a5,1
    80004b20:	00005717          	auipc	a4,0x5
    80004b24:	46f70da3          	sb	a5,1147(a4) # 80009f9b <_ZL9finishedA>
}
    80004b28:	01813083          	ld	ra,24(sp)
    80004b2c:	01013403          	ld	s0,16(sp)
    80004b30:	00813483          	ld	s1,8(sp)
    80004b34:	00013903          	ld	s2,0(sp)
    80004b38:	02010113          	addi	sp,sp,32
    80004b3c:	00008067          	ret

0000000080004b40 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80004b40:	fd010113          	addi	sp,sp,-48
    80004b44:	02113423          	sd	ra,40(sp)
    80004b48:	02813023          	sd	s0,32(sp)
    80004b4c:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004b50:	00000613          	li	a2,0
    80004b54:	00000597          	auipc	a1,0x0
    80004b58:	f2058593          	addi	a1,a1,-224 # 80004a74 <_ZL11workerBodyAPv>
    80004b5c:	fd040513          	addi	a0,s0,-48
    80004b60:	ffffc097          	auipc	ra,0xffffc
    80004b64:	764080e7          	jalr	1892(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80004b68:	00003517          	auipc	a0,0x3
    80004b6c:	63850513          	addi	a0,a0,1592 # 800081a0 <CONSOLE_STATUS+0x190>
    80004b70:	fffff097          	auipc	ra,0xfffff
    80004b74:	8b8080e7          	jalr	-1864(ra) # 80003428 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80004b78:	00000613          	li	a2,0
    80004b7c:	00000597          	auipc	a1,0x0
    80004b80:	e1458593          	addi	a1,a1,-492 # 80004990 <_ZL11workerBodyBPv>
    80004b84:	fd840513          	addi	a0,s0,-40
    80004b88:	ffffc097          	auipc	ra,0xffffc
    80004b8c:	73c080e7          	jalr	1852(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004b90:	00003517          	auipc	a0,0x3
    80004b94:	62850513          	addi	a0,a0,1576 # 800081b8 <CONSOLE_STATUS+0x1a8>
    80004b98:	fffff097          	auipc	ra,0xfffff
    80004b9c:	890080e7          	jalr	-1904(ra) # 80003428 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004ba0:	00000613          	li	a2,0
    80004ba4:	00000597          	auipc	a1,0x0
    80004ba8:	c6c58593          	addi	a1,a1,-916 # 80004810 <_ZL11workerBodyCPv>
    80004bac:	fe040513          	addi	a0,s0,-32
    80004bb0:	ffffc097          	auipc	ra,0xffffc
    80004bb4:	714080e7          	jalr	1812(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80004bb8:	00003517          	auipc	a0,0x3
    80004bbc:	61850513          	addi	a0,a0,1560 # 800081d0 <CONSOLE_STATUS+0x1c0>
    80004bc0:	fffff097          	auipc	ra,0xfffff
    80004bc4:	868080e7          	jalr	-1944(ra) # 80003428 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80004bc8:	00000613          	li	a2,0
    80004bcc:	00000597          	auipc	a1,0x0
    80004bd0:	afc58593          	addi	a1,a1,-1284 # 800046c8 <_ZL11workerBodyDPv>
    80004bd4:	fe840513          	addi	a0,s0,-24
    80004bd8:	ffffc097          	auipc	ra,0xffffc
    80004bdc:	6ec080e7          	jalr	1772(ra) # 800012c4 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004be0:	00003517          	auipc	a0,0x3
    80004be4:	60850513          	addi	a0,a0,1544 # 800081e8 <CONSOLE_STATUS+0x1d8>
    80004be8:	fffff097          	auipc	ra,0xfffff
    80004bec:	840080e7          	jalr	-1984(ra) # 80003428 <_Z11printStringPKc>
    80004bf0:	00c0006f          	j	80004bfc <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004bf4:	ffffc097          	auipc	ra,0xffffc
    80004bf8:	788080e7          	jalr	1928(ra) # 8000137c <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004bfc:	00005797          	auipc	a5,0x5
    80004c00:	39f7c783          	lbu	a5,927(a5) # 80009f9b <_ZL9finishedA>
    80004c04:	fe0788e3          	beqz	a5,80004bf4 <_Z16System_Mode_testv+0xb4>
    80004c08:	00005797          	auipc	a5,0x5
    80004c0c:	3927c783          	lbu	a5,914(a5) # 80009f9a <_ZL9finishedB>
    80004c10:	fe0782e3          	beqz	a5,80004bf4 <_Z16System_Mode_testv+0xb4>
    80004c14:	00005797          	auipc	a5,0x5
    80004c18:	3857c783          	lbu	a5,901(a5) # 80009f99 <_ZL9finishedC>
    80004c1c:	fc078ce3          	beqz	a5,80004bf4 <_Z16System_Mode_testv+0xb4>
    80004c20:	00005797          	auipc	a5,0x5
    80004c24:	3787c783          	lbu	a5,888(a5) # 80009f98 <_ZL9finishedD>
    80004c28:	fc0786e3          	beqz	a5,80004bf4 <_Z16System_Mode_testv+0xb4>
    }

}
    80004c2c:	02813083          	ld	ra,40(sp)
    80004c30:	02013403          	ld	s0,32(sp)
    80004c34:	03010113          	addi	sp,sp,48
    80004c38:	00008067          	ret

0000000080004c3c <_ZN15MemoryAllocator9mem_allocEm>:
#include "../lib/mem.h"

MemMeta* MemoryAllocator::firstFree = nullptr;
MemMeta* MemoryAllocator::firstUsed = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80004c3c:	ff010113          	addi	sp,sp,-16
    80004c40:	00813423          	sd	s0,8(sp)
    80004c44:	01010413          	addi	s0,sp,16
    MemMeta* newFree = nullptr;
    size_t actualSize;


    // inicijalizacija pri prvom trazenju memorije posle boot-a
    if (firstFree == nullptr) {
    80004c48:	00005797          	auipc	a5,0x5
    80004c4c:	3587b783          	ld	a5,856(a5) # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
    80004c50:	04078263          	beqz	a5,80004c94 <_ZN15MemoryAllocator9mem_allocEm+0x58>
        firstFree = (MemMeta*)HEAP_START_ADDR;
        firstFree->size = ((((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR) - sizeof(MemMeta)) / MEM_BLOCK_SIZE) * MEM_BLOCK_SIZE;
        firstFree->next = nullptr;
    }

    curr = firstFree;
    80004c54:	00005617          	auipc	a2,0x5
    80004c58:	34c63603          	ld	a2,844(a2) # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
    actualSize = size + (size % MEM_BLOCK_SIZE ? 1 : 0) * (MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);
    80004c5c:	03f57793          	andi	a5,a0,63
    80004c60:	06078a63          	beqz	a5,80004cd4 <_ZN15MemoryAllocator9mem_allocEm+0x98>
    80004c64:	00100693          	li	a3,1
    80004c68:	04000713          	li	a4,64
    80004c6c:	40f70733          	sub	a4,a4,a5
    80004c70:	02d70733          	mul	a4,a4,a3
    80004c74:	00a70733          	add	a4,a4,a0
    curr = firstFree;
    80004c78:	00060513          	mv	a0,a2

    while (curr != nullptr) {
    80004c7c:	06050063          	beqz	a0,80004cdc <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        if (curr->size > (actualSize + sizeof(MemMeta))) break; //nasli smo dovoljno veliki blok. jej!
    80004c80:	00053683          	ld	a3,0(a0)
    80004c84:	01070793          	addi	a5,a4,16
    80004c88:	04d7ea63          	bltu	a5,a3,80004cdc <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        curr = (MemMeta*)curr->next;
    80004c8c:	00853503          	ld	a0,8(a0)
    while (curr != nullptr) {
    80004c90:	fedff06f          	j	80004c7c <_ZN15MemoryAllocator9mem_allocEm+0x40>
        firstFree = (MemMeta*)HEAP_START_ADDR;
    80004c94:	00005797          	auipc	a5,0x5
    80004c98:	24c7b783          	ld	a5,588(a5) # 80009ee0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004c9c:	0007b703          	ld	a4,0(a5)
    80004ca0:	00005697          	auipc	a3,0x5
    80004ca4:	30068693          	addi	a3,a3,768 # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
    80004ca8:	00e6b023          	sd	a4,0(a3)
        firstFree->size = ((((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR) - sizeof(MemMeta)) / MEM_BLOCK_SIZE) * MEM_BLOCK_SIZE;
    80004cac:	00005797          	auipc	a5,0x5
    80004cb0:	2547b783          	ld	a5,596(a5) # 80009f00 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004cb4:	0007b783          	ld	a5,0(a5)
    80004cb8:	40e787b3          	sub	a5,a5,a4
    80004cbc:	ff078793          	addi	a5,a5,-16
    80004cc0:	fc07f793          	andi	a5,a5,-64
    80004cc4:	00f73023          	sd	a5,0(a4)
        firstFree->next = nullptr;
    80004cc8:	0006b783          	ld	a5,0(a3)
    80004ccc:	0007b423          	sd	zero,8(a5)
    80004cd0:	f85ff06f          	j	80004c54 <_ZN15MemoryAllocator9mem_allocEm+0x18>
    actualSize = size + (size % MEM_BLOCK_SIZE ? 1 : 0) * (MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);
    80004cd4:	00078693          	mv	a3,a5
    80004cd8:	f91ff06f          	j	80004c68 <_ZN15MemoryAllocator9mem_allocEm+0x2c>
    }

    if (curr == nullptr) return nullptr; //potencijalna nadogradnja: attemptDefrag();
    80004cdc:	06050863          	beqz	a0,80004d4c <_ZN15MemoryAllocator9mem_allocEm+0x110>


    for(curr2 = firstFree; curr != firstFree && curr2->next != curr && curr2->next != 0; curr2 = (MemMeta*)curr2->next);
    80004ce0:	00060693          	mv	a3,a2
    80004ce4:	0080006f          	j	80004cec <_ZN15MemoryAllocator9mem_allocEm+0xb0>
    80004ce8:	00078693          	mv	a3,a5
    80004cec:	00c50863          	beq	a0,a2,80004cfc <_ZN15MemoryAllocator9mem_allocEm+0xc0>
    80004cf0:	0086b783          	ld	a5,8(a3)
    80004cf4:	00a78463          	beq	a5,a0,80004cfc <_ZN15MemoryAllocator9mem_allocEm+0xc0>
    80004cf8:	fe0798e3          	bnez	a5,80004ce8 <_ZN15MemoryAllocator9mem_allocEm+0xac>
    newFree = (MemMeta*)((size_t)curr + actualSize + sizeof(MemMeta));
    80004cfc:	00e505b3          	add	a1,a0,a4
    80004d00:	01058813          	addi	a6,a1,16
    if (curr2 != firstFree) curr2->next = newFree;
    80004d04:	04c68a63          	beq	a3,a2,80004d58 <_ZN15MemoryAllocator9mem_allocEm+0x11c>
    80004d08:	0106b423          	sd	a6,8(a3)
    else firstFree = newFree;
    newFree->size = curr->size - actualSize - sizeof(MemMeta);
    80004d0c:	00053783          	ld	a5,0(a0)
    80004d10:	40e787b3          	sub	a5,a5,a4
    80004d14:	ff078793          	addi	a5,a5,-16
    80004d18:	00f5b823          	sd	a5,16(a1)
    newFree->next = curr->next;
    80004d1c:	00853783          	ld	a5,8(a0)
    80004d20:	00f83423          	sd	a5,8(a6)

    if (firstUsed == nullptr) {
    80004d24:	00005797          	auipc	a5,0x5
    80004d28:	2847b783          	ld	a5,644(a5) # 80009fa8 <_ZN15MemoryAllocator9firstUsedE>
    80004d2c:	02078c63          	beqz	a5,80004d64 <_ZN15MemoryAllocator9mem_allocEm+0x128>
        firstUsed->next = nullptr;
        newUsed = firstUsed;
    }

    else {
        for (curr2 = firstUsed; curr2->next != nullptr; curr2 = (MemMeta*)curr2->next);
    80004d30:	00078693          	mv	a3,a5
    80004d34:	0087b783          	ld	a5,8(a5)
    80004d38:	fe079ce3          	bnez	a5,80004d30 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
        newUsed = curr;
        curr2->next = newUsed;
    80004d3c:	00a6b423          	sd	a0,8(a3)
        newUsed->size = actualSize;
    80004d40:	00e53023          	sd	a4,0(a0)
        newUsed->next = nullptr;
    80004d44:	00053423          	sd	zero,8(a0)
    }

    return (void*)((size_t)newUsed + sizeof(MemMeta));
    80004d48:	01050513          	addi	a0,a0,16
}
    80004d4c:	00813403          	ld	s0,8(sp)
    80004d50:	01010113          	addi	sp,sp,16
    80004d54:	00008067          	ret
    else firstFree = newFree;
    80004d58:	00005797          	auipc	a5,0x5
    80004d5c:	2507b423          	sd	a6,584(a5) # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
    80004d60:	fadff06f          	j	80004d0c <_ZN15MemoryAllocator9mem_allocEm+0xd0>
        firstUsed = curr;
    80004d64:	00005797          	auipc	a5,0x5
    80004d68:	23c78793          	addi	a5,a5,572 # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
    80004d6c:	00a7b423          	sd	a0,8(a5)
        firstUsed->size = actualSize;
    80004d70:	00e53023          	sd	a4,0(a0)
        firstUsed->next = nullptr;
    80004d74:	0087b503          	ld	a0,8(a5)
    80004d78:	00053423          	sd	zero,8(a0)
        newUsed = firstUsed;
    80004d7c:	fcdff06f          	j	80004d48 <_ZN15MemoryAllocator9mem_allocEm+0x10c>

0000000080004d80 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free (void* ptr) {
    80004d80:	ff010113          	addi	sp,sp,-16
    80004d84:	00813423          	sd	s0,8(sp)
    80004d88:	01010413          	addi	s0,sp,16
    void* tmp;
    MemMeta* newFree;

    //rastuci poredak

    if ((void*)((size_t)ptr - sizeof(MemMeta)) == firstUsed) {
    80004d8c:	ff050513          	addi	a0,a0,-16
    80004d90:	00050713          	mv	a4,a0
    80004d94:	00005797          	auipc	a5,0x5
    80004d98:	2147b783          	ld	a5,532(a5) # 80009fa8 <_ZN15MemoryAllocator9firstUsedE>
    80004d9c:	06f50e63          	beq	a0,a5,80004e18 <_ZN15MemoryAllocator8mem_freeEPv+0x98>
        firstUsed = (MemMeta*)firstUsed->next;
    }
    else {
        for (curr = firstUsed; curr->next != (void*)((size_t)ptr - sizeof(MemMeta)) && curr->next != 0; curr = (MemMeta*)curr->next);
    80004da0:	00078693          	mv	a3,a5
    80004da4:	0087b783          	ld	a5,8(a5)
    80004da8:	00f70463          	beq	a4,a5,80004db0 <_ZN15MemoryAllocator8mem_freeEPv+0x30>
    80004dac:	fe079ae3          	bnez	a5,80004da0 <_ZN15MemoryAllocator8mem_freeEPv+0x20>
        if (curr->next == nullptr) return -1;
    80004db0:	08078a63          	beqz	a5,80004e44 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
        curr->next = ((MemMeta*)((size_t)ptr - sizeof(MemMeta)))->next;
    80004db4:	00853783          	ld	a5,8(a0)
    80004db8:	00f6b423          	sd	a5,8(a3)
    } // vrsi prelancavanje USED liste

    newFree = (MemMeta*)((size_t)ptr - sizeof(MemMeta));

    if ((MemMeta*)((size_t)ptr - sizeof(MemMeta)) < firstFree) {
    80004dbc:	00005797          	auipc	a5,0x5
    80004dc0:	1e47b783          	ld	a5,484(a5) # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
    80004dc4:	06f77263          	bgeu	a4,a5,80004e28 <_ZN15MemoryAllocator8mem_freeEPv+0xa8>
        newFree->next = firstFree;
    80004dc8:	00f53423          	sd	a5,8(a0)
        firstFree = newFree;
    80004dcc:	00005797          	auipc	a5,0x5
    80004dd0:	1ca7ba23          	sd	a0,468(a5) # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
        curr->next = newFree;
        newFree->next = tmp;

    }

    for (curr = firstFree; curr->next != nullptr; ){
    80004dd4:	00005797          	auipc	a5,0x5
    80004dd8:	1cc7b783          	ld	a5,460(a5) # 80009fa0 <_ZN15MemoryAllocator9firstFreeE>
    80004ddc:	00078693          	mv	a3,a5
    80004de0:	0087b783          	ld	a5,8(a5)
    80004de4:	06078463          	beqz	a5,80004e4c <_ZN15MemoryAllocator8mem_freeEPv+0xcc>
        if ((size_t)curr + curr->size + sizeof(MemMeta) == (size_t)curr->next){
    80004de8:	0006b603          	ld	a2,0(a3)
    80004dec:	00c68733          	add	a4,a3,a2
    80004df0:	01070713          	addi	a4,a4,16
    80004df4:	fef714e3          	bne	a4,a5,80004ddc <_ZN15MemoryAllocator8mem_freeEPv+0x5c>
            curr->size = curr->size + ((MemMeta*)curr->next)->size + sizeof(MemMeta);
    80004df8:	0007b703          	ld	a4,0(a5)
    80004dfc:	00e60633          	add	a2,a2,a4
    80004e00:	01060613          	addi	a2,a2,16
    80004e04:	00c6b023          	sd	a2,0(a3)
            curr->next = ((MemMeta*)curr->next)->next;
    80004e08:	0087b783          	ld	a5,8(a5)
    80004e0c:	00f6b423          	sd	a5,8(a3)
    80004e10:	00068793          	mv	a5,a3
    80004e14:	fc9ff06f          	j	80004ddc <_ZN15MemoryAllocator8mem_freeEPv+0x5c>
        firstUsed = (MemMeta*)firstUsed->next;
    80004e18:	0087b783          	ld	a5,8(a5)
    80004e1c:	00005697          	auipc	a3,0x5
    80004e20:	18f6b623          	sd	a5,396(a3) # 80009fa8 <_ZN15MemoryAllocator9firstUsedE>
    80004e24:	f99ff06f          	j	80004dbc <_ZN15MemoryAllocator8mem_freeEPv+0x3c>
        for (curr = firstFree; (size_t)curr->next < ((size_t)ptr - sizeof(MemMeta)) && curr->next != 0; curr = (MemMeta*)curr->next);
    80004e28:	00078713          	mv	a4,a5
    80004e2c:	0087b783          	ld	a5,8(a5)
    80004e30:	00a7f463          	bgeu	a5,a0,80004e38 <_ZN15MemoryAllocator8mem_freeEPv+0xb8>
    80004e34:	fe079ae3          	bnez	a5,80004e28 <_ZN15MemoryAllocator8mem_freeEPv+0xa8>
        curr->next = newFree;
    80004e38:	00a73423          	sd	a0,8(a4)
        newFree->next = tmp;
    80004e3c:	00f53423          	sd	a5,8(a0)
    80004e40:	f95ff06f          	j	80004dd4 <_ZN15MemoryAllocator8mem_freeEPv+0x54>
        if (curr->next == nullptr) return -1;
    80004e44:	fff00513          	li	a0,-1
    80004e48:	0080006f          	j	80004e50 <_ZN15MemoryAllocator8mem_freeEPv+0xd0>
        else {
            curr = (MemMeta*)curr->next;
        }
    }

    return 0;
    80004e4c:	00000513          	li	a0,0
}
    80004e50:	00813403          	ld	s0,8(sp)
    80004e54:	01010113          	addi	sp,sp,16
    80004e58:	00008067          	ret

0000000080004e5c <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004e5c:	fe010113          	addi	sp,sp,-32
    80004e60:	00113c23          	sd	ra,24(sp)
    80004e64:	00813823          	sd	s0,16(sp)
    80004e68:	00913423          	sd	s1,8(sp)
    80004e6c:	01213023          	sd	s2,0(sp)
    80004e70:	02010413          	addi	s0,sp,32
    80004e74:	00050493          	mv	s1,a0
    80004e78:	00058913          	mv	s2,a1
    80004e7c:	0015879b          	addiw	a5,a1,1
    80004e80:	0007851b          	sext.w	a0,a5
    80004e84:	00f4a023          	sw	a5,0(s1)
    80004e88:	0004a823          	sw	zero,16(s1)
    80004e8c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004e90:	00251513          	slli	a0,a0,0x2
    80004e94:	ffffc097          	auipc	ra,0xffffc
    80004e98:	3a8080e7          	jalr	936(ra) # 8000123c <_Z9mem_allocm>
    80004e9c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004ea0:	00000593          	li	a1,0
    80004ea4:	02048513          	addi	a0,s1,32
    80004ea8:	ffffc097          	auipc	ra,0xffffc
    80004eac:	558080e7          	jalr	1368(ra) # 80001400 <_Z8sem_openPP4_semm>
    sem_open(&spaceAvailable, _cap);
    80004eb0:	00090593          	mv	a1,s2
    80004eb4:	01848513          	addi	a0,s1,24
    80004eb8:	ffffc097          	auipc	ra,0xffffc
    80004ebc:	548080e7          	jalr	1352(ra) # 80001400 <_Z8sem_openPP4_semm>
    sem_open(&mutexHead, 1);
    80004ec0:	00100593          	li	a1,1
    80004ec4:	02848513          	addi	a0,s1,40
    80004ec8:	ffffc097          	auipc	ra,0xffffc
    80004ecc:	538080e7          	jalr	1336(ra) # 80001400 <_Z8sem_openPP4_semm>
    sem_open(&mutexTail, 1);
    80004ed0:	00100593          	li	a1,1
    80004ed4:	03048513          	addi	a0,s1,48
    80004ed8:	ffffc097          	auipc	ra,0xffffc
    80004edc:	528080e7          	jalr	1320(ra) # 80001400 <_Z8sem_openPP4_semm>
}
    80004ee0:	01813083          	ld	ra,24(sp)
    80004ee4:	01013403          	ld	s0,16(sp)
    80004ee8:	00813483          	ld	s1,8(sp)
    80004eec:	00013903          	ld	s2,0(sp)
    80004ef0:	02010113          	addi	sp,sp,32
    80004ef4:	00008067          	ret

0000000080004ef8 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004ef8:	fe010113          	addi	sp,sp,-32
    80004efc:	00113c23          	sd	ra,24(sp)
    80004f00:	00813823          	sd	s0,16(sp)
    80004f04:	00913423          	sd	s1,8(sp)
    80004f08:	01213023          	sd	s2,0(sp)
    80004f0c:	02010413          	addi	s0,sp,32
    80004f10:	00050493          	mv	s1,a0
    80004f14:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004f18:	01853503          	ld	a0,24(a0)
    80004f1c:	ffffc097          	auipc	ra,0xffffc
    80004f20:	560080e7          	jalr	1376(ra) # 8000147c <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80004f24:	0304b503          	ld	a0,48(s1)
    80004f28:	ffffc097          	auipc	ra,0xffffc
    80004f2c:	554080e7          	jalr	1364(ra) # 8000147c <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80004f30:	0084b783          	ld	a5,8(s1)
    80004f34:	0144a703          	lw	a4,20(s1)
    80004f38:	00271713          	slli	a4,a4,0x2
    80004f3c:	00e787b3          	add	a5,a5,a4
    80004f40:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004f44:	0144a783          	lw	a5,20(s1)
    80004f48:	0017879b          	addiw	a5,a5,1
    80004f4c:	0004a703          	lw	a4,0(s1)
    80004f50:	02e7e7bb          	remw	a5,a5,a4
    80004f54:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004f58:	0304b503          	ld	a0,48(s1)
    80004f5c:	ffffc097          	auipc	ra,0xffffc
    80004f60:	55c080e7          	jalr	1372(ra) # 800014b8 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80004f64:	0204b503          	ld	a0,32(s1)
    80004f68:	ffffc097          	auipc	ra,0xffffc
    80004f6c:	550080e7          	jalr	1360(ra) # 800014b8 <_Z10sem_signalP4_sem>

}
    80004f70:	01813083          	ld	ra,24(sp)
    80004f74:	01013403          	ld	s0,16(sp)
    80004f78:	00813483          	ld	s1,8(sp)
    80004f7c:	00013903          	ld	s2,0(sp)
    80004f80:	02010113          	addi	sp,sp,32
    80004f84:	00008067          	ret

0000000080004f88 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004f88:	fe010113          	addi	sp,sp,-32
    80004f8c:	00113c23          	sd	ra,24(sp)
    80004f90:	00813823          	sd	s0,16(sp)
    80004f94:	00913423          	sd	s1,8(sp)
    80004f98:	01213023          	sd	s2,0(sp)
    80004f9c:	02010413          	addi	s0,sp,32
    80004fa0:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80004fa4:	02053503          	ld	a0,32(a0)
    80004fa8:	ffffc097          	auipc	ra,0xffffc
    80004fac:	4d4080e7          	jalr	1236(ra) # 8000147c <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80004fb0:	0284b503          	ld	a0,40(s1)
    80004fb4:	ffffc097          	auipc	ra,0xffffc
    80004fb8:	4c8080e7          	jalr	1224(ra) # 8000147c <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80004fbc:	0084b703          	ld	a4,8(s1)
    80004fc0:	0104a783          	lw	a5,16(s1)
    80004fc4:	00279693          	slli	a3,a5,0x2
    80004fc8:	00d70733          	add	a4,a4,a3
    80004fcc:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004fd0:	0017879b          	addiw	a5,a5,1
    80004fd4:	0004a703          	lw	a4,0(s1)
    80004fd8:	02e7e7bb          	remw	a5,a5,a4
    80004fdc:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004fe0:	0284b503          	ld	a0,40(s1)
    80004fe4:	ffffc097          	auipc	ra,0xffffc
    80004fe8:	4d4080e7          	jalr	1236(ra) # 800014b8 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80004fec:	0184b503          	ld	a0,24(s1)
    80004ff0:	ffffc097          	auipc	ra,0xffffc
    80004ff4:	4c8080e7          	jalr	1224(ra) # 800014b8 <_Z10sem_signalP4_sem>

    return ret;
}
    80004ff8:	00090513          	mv	a0,s2
    80004ffc:	01813083          	ld	ra,24(sp)
    80005000:	01013403          	ld	s0,16(sp)
    80005004:	00813483          	ld	s1,8(sp)
    80005008:	00013903          	ld	s2,0(sp)
    8000500c:	02010113          	addi	sp,sp,32
    80005010:	00008067          	ret

0000000080005014 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80005014:	fe010113          	addi	sp,sp,-32
    80005018:	00113c23          	sd	ra,24(sp)
    8000501c:	00813823          	sd	s0,16(sp)
    80005020:	00913423          	sd	s1,8(sp)
    80005024:	01213023          	sd	s2,0(sp)
    80005028:	02010413          	addi	s0,sp,32
    8000502c:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80005030:	02853503          	ld	a0,40(a0)
    80005034:	ffffc097          	auipc	ra,0xffffc
    80005038:	448080e7          	jalr	1096(ra) # 8000147c <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    8000503c:	0304b503          	ld	a0,48(s1)
    80005040:	ffffc097          	auipc	ra,0xffffc
    80005044:	43c080e7          	jalr	1084(ra) # 8000147c <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80005048:	0144a783          	lw	a5,20(s1)
    8000504c:	0104a903          	lw	s2,16(s1)
    80005050:	0327ce63          	blt	a5,s2,8000508c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80005054:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80005058:	0304b503          	ld	a0,48(s1)
    8000505c:	ffffc097          	auipc	ra,0xffffc
    80005060:	45c080e7          	jalr	1116(ra) # 800014b8 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80005064:	0284b503          	ld	a0,40(s1)
    80005068:	ffffc097          	auipc	ra,0xffffc
    8000506c:	450080e7          	jalr	1104(ra) # 800014b8 <_Z10sem_signalP4_sem>

    return ret;
}
    80005070:	00090513          	mv	a0,s2
    80005074:	01813083          	ld	ra,24(sp)
    80005078:	01013403          	ld	s0,16(sp)
    8000507c:	00813483          	ld	s1,8(sp)
    80005080:	00013903          	ld	s2,0(sp)
    80005084:	02010113          	addi	sp,sp,32
    80005088:	00008067          	ret
        ret = cap - head + tail;
    8000508c:	0004a703          	lw	a4,0(s1)
    80005090:	4127093b          	subw	s2,a4,s2
    80005094:	00f9093b          	addw	s2,s2,a5
    80005098:	fc1ff06f          	j	80005058 <_ZN6Buffer6getCntEv+0x44>

000000008000509c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000509c:	fe010113          	addi	sp,sp,-32
    800050a0:	00113c23          	sd	ra,24(sp)
    800050a4:	00813823          	sd	s0,16(sp)
    800050a8:	00913423          	sd	s1,8(sp)
    800050ac:	02010413          	addi	s0,sp,32
    800050b0:	00050493          	mv	s1,a0
    putc('\n');
    800050b4:	00a00513          	li	a0,10
    800050b8:	ffffc097          	auipc	ra,0xffffc
    800050bc:	320080e7          	jalr	800(ra) # 800013d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    800050c0:	00003517          	auipc	a0,0x3
    800050c4:	14050513          	addi	a0,a0,320 # 80008200 <CONSOLE_STATUS+0x1f0>
    800050c8:	ffffe097          	auipc	ra,0xffffe
    800050cc:	360080e7          	jalr	864(ra) # 80003428 <_Z11printStringPKc>
    while (getCnt() > 0) {
    800050d0:	00048513          	mv	a0,s1
    800050d4:	00000097          	auipc	ra,0x0
    800050d8:	f40080e7          	jalr	-192(ra) # 80005014 <_ZN6Buffer6getCntEv>
    800050dc:	02a05c63          	blez	a0,80005114 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800050e0:	0084b783          	ld	a5,8(s1)
    800050e4:	0104a703          	lw	a4,16(s1)
    800050e8:	00271713          	slli	a4,a4,0x2
    800050ec:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800050f0:	0007c503          	lbu	a0,0(a5)
    800050f4:	ffffc097          	auipc	ra,0xffffc
    800050f8:	2e4080e7          	jalr	740(ra) # 800013d8 <_Z4putcc>
        head = (head + 1) % cap;
    800050fc:	0104a783          	lw	a5,16(s1)
    80005100:	0017879b          	addiw	a5,a5,1
    80005104:	0004a703          	lw	a4,0(s1)
    80005108:	02e7e7bb          	remw	a5,a5,a4
    8000510c:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80005110:	fc1ff06f          	j	800050d0 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80005114:	02100513          	li	a0,33
    80005118:	ffffc097          	auipc	ra,0xffffc
    8000511c:	2c0080e7          	jalr	704(ra) # 800013d8 <_Z4putcc>
    putc('\n');
    80005120:	00a00513          	li	a0,10
    80005124:	ffffc097          	auipc	ra,0xffffc
    80005128:	2b4080e7          	jalr	692(ra) # 800013d8 <_Z4putcc>
    mem_free(buffer);
    8000512c:	0084b503          	ld	a0,8(s1)
    80005130:	ffffc097          	auipc	ra,0xffffc
    80005134:	158080e7          	jalr	344(ra) # 80001288 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80005138:	0204b503          	ld	a0,32(s1)
    8000513c:	ffffc097          	auipc	ra,0xffffc
    80005140:	304080e7          	jalr	772(ra) # 80001440 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80005144:	0184b503          	ld	a0,24(s1)
    80005148:	ffffc097          	auipc	ra,0xffffc
    8000514c:	2f8080e7          	jalr	760(ra) # 80001440 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    80005150:	0304b503          	ld	a0,48(s1)
    80005154:	ffffc097          	auipc	ra,0xffffc
    80005158:	2ec080e7          	jalr	748(ra) # 80001440 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    8000515c:	0284b503          	ld	a0,40(s1)
    80005160:	ffffc097          	auipc	ra,0xffffc
    80005164:	2e0080e7          	jalr	736(ra) # 80001440 <_Z9sem_closeP4_sem>
}
    80005168:	01813083          	ld	ra,24(sp)
    8000516c:	01013403          	ld	s0,16(sp)
    80005170:	00813483          	ld	s1,8(sp)
    80005174:	02010113          	addi	sp,sp,32
    80005178:	00008067          	ret

000000008000517c <start>:
    8000517c:	ff010113          	addi	sp,sp,-16
    80005180:	00813423          	sd	s0,8(sp)
    80005184:	01010413          	addi	s0,sp,16
    80005188:	300027f3          	csrr	a5,mstatus
    8000518c:	ffffe737          	lui	a4,0xffffe
    80005190:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff35ef>
    80005194:	00e7f7b3          	and	a5,a5,a4
    80005198:	00001737          	lui	a4,0x1
    8000519c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800051a0:	00e7e7b3          	or	a5,a5,a4
    800051a4:	30079073          	csrw	mstatus,a5
    800051a8:	00000797          	auipc	a5,0x0
    800051ac:	16078793          	addi	a5,a5,352 # 80005308 <system_main>
    800051b0:	34179073          	csrw	mepc,a5
    800051b4:	00000793          	li	a5,0
    800051b8:	18079073          	csrw	satp,a5
    800051bc:	000107b7          	lui	a5,0x10
    800051c0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800051c4:	30279073          	csrw	medeleg,a5
    800051c8:	30379073          	csrw	mideleg,a5
    800051cc:	104027f3          	csrr	a5,sie
    800051d0:	2227e793          	ori	a5,a5,546
    800051d4:	10479073          	csrw	sie,a5
    800051d8:	fff00793          	li	a5,-1
    800051dc:	00a7d793          	srli	a5,a5,0xa
    800051e0:	3b079073          	csrw	pmpaddr0,a5
    800051e4:	00f00793          	li	a5,15
    800051e8:	3a079073          	csrw	pmpcfg0,a5
    800051ec:	f14027f3          	csrr	a5,mhartid
    800051f0:	0200c737          	lui	a4,0x200c
    800051f4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800051f8:	0007869b          	sext.w	a3,a5
    800051fc:	00269713          	slli	a4,a3,0x2
    80005200:	000f4637          	lui	a2,0xf4
    80005204:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005208:	00d70733          	add	a4,a4,a3
    8000520c:	0037979b          	slliw	a5,a5,0x3
    80005210:	020046b7          	lui	a3,0x2004
    80005214:	00d787b3          	add	a5,a5,a3
    80005218:	00c585b3          	add	a1,a1,a2
    8000521c:	00371693          	slli	a3,a4,0x3
    80005220:	00005717          	auipc	a4,0x5
    80005224:	d9070713          	addi	a4,a4,-624 # 80009fb0 <timer_scratch>
    80005228:	00b7b023          	sd	a1,0(a5)
    8000522c:	00d70733          	add	a4,a4,a3
    80005230:	00f73c23          	sd	a5,24(a4)
    80005234:	02c73023          	sd	a2,32(a4)
    80005238:	34071073          	csrw	mscratch,a4
    8000523c:	00000797          	auipc	a5,0x0
    80005240:	6e478793          	addi	a5,a5,1764 # 80005920 <timervec>
    80005244:	30579073          	csrw	mtvec,a5
    80005248:	300027f3          	csrr	a5,mstatus
    8000524c:	0087e793          	ori	a5,a5,8
    80005250:	30079073          	csrw	mstatus,a5
    80005254:	304027f3          	csrr	a5,mie
    80005258:	0807e793          	ori	a5,a5,128
    8000525c:	30479073          	csrw	mie,a5
    80005260:	f14027f3          	csrr	a5,mhartid
    80005264:	0007879b          	sext.w	a5,a5
    80005268:	00078213          	mv	tp,a5
    8000526c:	30200073          	mret
    80005270:	00813403          	ld	s0,8(sp)
    80005274:	01010113          	addi	sp,sp,16
    80005278:	00008067          	ret

000000008000527c <timerinit>:
    8000527c:	ff010113          	addi	sp,sp,-16
    80005280:	00813423          	sd	s0,8(sp)
    80005284:	01010413          	addi	s0,sp,16
    80005288:	f14027f3          	csrr	a5,mhartid
    8000528c:	0200c737          	lui	a4,0x200c
    80005290:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005294:	0007869b          	sext.w	a3,a5
    80005298:	00269713          	slli	a4,a3,0x2
    8000529c:	000f4637          	lui	a2,0xf4
    800052a0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800052a4:	00d70733          	add	a4,a4,a3
    800052a8:	0037979b          	slliw	a5,a5,0x3
    800052ac:	020046b7          	lui	a3,0x2004
    800052b0:	00d787b3          	add	a5,a5,a3
    800052b4:	00c585b3          	add	a1,a1,a2
    800052b8:	00371693          	slli	a3,a4,0x3
    800052bc:	00005717          	auipc	a4,0x5
    800052c0:	cf470713          	addi	a4,a4,-780 # 80009fb0 <timer_scratch>
    800052c4:	00b7b023          	sd	a1,0(a5)
    800052c8:	00d70733          	add	a4,a4,a3
    800052cc:	00f73c23          	sd	a5,24(a4)
    800052d0:	02c73023          	sd	a2,32(a4)
    800052d4:	34071073          	csrw	mscratch,a4
    800052d8:	00000797          	auipc	a5,0x0
    800052dc:	64878793          	addi	a5,a5,1608 # 80005920 <timervec>
    800052e0:	30579073          	csrw	mtvec,a5
    800052e4:	300027f3          	csrr	a5,mstatus
    800052e8:	0087e793          	ori	a5,a5,8
    800052ec:	30079073          	csrw	mstatus,a5
    800052f0:	304027f3          	csrr	a5,mie
    800052f4:	0807e793          	ori	a5,a5,128
    800052f8:	30479073          	csrw	mie,a5
    800052fc:	00813403          	ld	s0,8(sp)
    80005300:	01010113          	addi	sp,sp,16
    80005304:	00008067          	ret

0000000080005308 <system_main>:
    80005308:	fe010113          	addi	sp,sp,-32
    8000530c:	00813823          	sd	s0,16(sp)
    80005310:	00913423          	sd	s1,8(sp)
    80005314:	00113c23          	sd	ra,24(sp)
    80005318:	02010413          	addi	s0,sp,32
    8000531c:	00000097          	auipc	ra,0x0
    80005320:	0c4080e7          	jalr	196(ra) # 800053e0 <cpuid>
    80005324:	00005497          	auipc	s1,0x5
    80005328:	bfc48493          	addi	s1,s1,-1028 # 80009f20 <started>
    8000532c:	02050263          	beqz	a0,80005350 <system_main+0x48>
    80005330:	0004a783          	lw	a5,0(s1)
    80005334:	0007879b          	sext.w	a5,a5
    80005338:	fe078ce3          	beqz	a5,80005330 <system_main+0x28>
    8000533c:	0ff0000f          	fence
    80005340:	00003517          	auipc	a0,0x3
    80005344:	25050513          	addi	a0,a0,592 # 80008590 <CONSOLE_STATUS+0x580>
    80005348:	00001097          	auipc	ra,0x1
    8000534c:	a74080e7          	jalr	-1420(ra) # 80005dbc <panic>
    80005350:	00001097          	auipc	ra,0x1
    80005354:	9c8080e7          	jalr	-1592(ra) # 80005d18 <consoleinit>
    80005358:	00001097          	auipc	ra,0x1
    8000535c:	154080e7          	jalr	340(ra) # 800064ac <printfinit>
    80005360:	00003517          	auipc	a0,0x3
    80005364:	02850513          	addi	a0,a0,40 # 80008388 <CONSOLE_STATUS+0x378>
    80005368:	00001097          	auipc	ra,0x1
    8000536c:	ab0080e7          	jalr	-1360(ra) # 80005e18 <__printf>
    80005370:	00003517          	auipc	a0,0x3
    80005374:	1f050513          	addi	a0,a0,496 # 80008560 <CONSOLE_STATUS+0x550>
    80005378:	00001097          	auipc	ra,0x1
    8000537c:	aa0080e7          	jalr	-1376(ra) # 80005e18 <__printf>
    80005380:	00003517          	auipc	a0,0x3
    80005384:	00850513          	addi	a0,a0,8 # 80008388 <CONSOLE_STATUS+0x378>
    80005388:	00001097          	auipc	ra,0x1
    8000538c:	a90080e7          	jalr	-1392(ra) # 80005e18 <__printf>
    80005390:	00001097          	auipc	ra,0x1
    80005394:	4a8080e7          	jalr	1192(ra) # 80006838 <kinit>
    80005398:	00000097          	auipc	ra,0x0
    8000539c:	148080e7          	jalr	328(ra) # 800054e0 <trapinit>
    800053a0:	00000097          	auipc	ra,0x0
    800053a4:	16c080e7          	jalr	364(ra) # 8000550c <trapinithart>
    800053a8:	00000097          	auipc	ra,0x0
    800053ac:	5b8080e7          	jalr	1464(ra) # 80005960 <plicinit>
    800053b0:	00000097          	auipc	ra,0x0
    800053b4:	5d8080e7          	jalr	1496(ra) # 80005988 <plicinithart>
    800053b8:	00000097          	auipc	ra,0x0
    800053bc:	078080e7          	jalr	120(ra) # 80005430 <userinit>
    800053c0:	0ff0000f          	fence
    800053c4:	00100793          	li	a5,1
    800053c8:	00003517          	auipc	a0,0x3
    800053cc:	1b050513          	addi	a0,a0,432 # 80008578 <CONSOLE_STATUS+0x568>
    800053d0:	00f4a023          	sw	a5,0(s1)
    800053d4:	00001097          	auipc	ra,0x1
    800053d8:	a44080e7          	jalr	-1468(ra) # 80005e18 <__printf>
    800053dc:	0000006f          	j	800053dc <system_main+0xd4>

00000000800053e0 <cpuid>:
    800053e0:	ff010113          	addi	sp,sp,-16
    800053e4:	00813423          	sd	s0,8(sp)
    800053e8:	01010413          	addi	s0,sp,16
    800053ec:	00020513          	mv	a0,tp
    800053f0:	00813403          	ld	s0,8(sp)
    800053f4:	0005051b          	sext.w	a0,a0
    800053f8:	01010113          	addi	sp,sp,16
    800053fc:	00008067          	ret

0000000080005400 <mycpu>:
    80005400:	ff010113          	addi	sp,sp,-16
    80005404:	00813423          	sd	s0,8(sp)
    80005408:	01010413          	addi	s0,sp,16
    8000540c:	00020793          	mv	a5,tp
    80005410:	00813403          	ld	s0,8(sp)
    80005414:	0007879b          	sext.w	a5,a5
    80005418:	00779793          	slli	a5,a5,0x7
    8000541c:	00006517          	auipc	a0,0x6
    80005420:	bc450513          	addi	a0,a0,-1084 # 8000afe0 <cpus>
    80005424:	00f50533          	add	a0,a0,a5
    80005428:	01010113          	addi	sp,sp,16
    8000542c:	00008067          	ret

0000000080005430 <userinit>:
    80005430:	ff010113          	addi	sp,sp,-16
    80005434:	00813423          	sd	s0,8(sp)
    80005438:	01010413          	addi	s0,sp,16
    8000543c:	00813403          	ld	s0,8(sp)
    80005440:	01010113          	addi	sp,sp,16
    80005444:	fffff317          	auipc	t1,0xfffff
    80005448:	82830067          	jr	-2008(t1) # 80003c6c <main>

000000008000544c <either_copyout>:
    8000544c:	ff010113          	addi	sp,sp,-16
    80005450:	00813023          	sd	s0,0(sp)
    80005454:	00113423          	sd	ra,8(sp)
    80005458:	01010413          	addi	s0,sp,16
    8000545c:	02051663          	bnez	a0,80005488 <either_copyout+0x3c>
    80005460:	00058513          	mv	a0,a1
    80005464:	00060593          	mv	a1,a2
    80005468:	0006861b          	sext.w	a2,a3
    8000546c:	00002097          	auipc	ra,0x2
    80005470:	c58080e7          	jalr	-936(ra) # 800070c4 <__memmove>
    80005474:	00813083          	ld	ra,8(sp)
    80005478:	00013403          	ld	s0,0(sp)
    8000547c:	00000513          	li	a0,0
    80005480:	01010113          	addi	sp,sp,16
    80005484:	00008067          	ret
    80005488:	00003517          	auipc	a0,0x3
    8000548c:	13050513          	addi	a0,a0,304 # 800085b8 <CONSOLE_STATUS+0x5a8>
    80005490:	00001097          	auipc	ra,0x1
    80005494:	92c080e7          	jalr	-1748(ra) # 80005dbc <panic>

0000000080005498 <either_copyin>:
    80005498:	ff010113          	addi	sp,sp,-16
    8000549c:	00813023          	sd	s0,0(sp)
    800054a0:	00113423          	sd	ra,8(sp)
    800054a4:	01010413          	addi	s0,sp,16
    800054a8:	02059463          	bnez	a1,800054d0 <either_copyin+0x38>
    800054ac:	00060593          	mv	a1,a2
    800054b0:	0006861b          	sext.w	a2,a3
    800054b4:	00002097          	auipc	ra,0x2
    800054b8:	c10080e7          	jalr	-1008(ra) # 800070c4 <__memmove>
    800054bc:	00813083          	ld	ra,8(sp)
    800054c0:	00013403          	ld	s0,0(sp)
    800054c4:	00000513          	li	a0,0
    800054c8:	01010113          	addi	sp,sp,16
    800054cc:	00008067          	ret
    800054d0:	00003517          	auipc	a0,0x3
    800054d4:	11050513          	addi	a0,a0,272 # 800085e0 <CONSOLE_STATUS+0x5d0>
    800054d8:	00001097          	auipc	ra,0x1
    800054dc:	8e4080e7          	jalr	-1820(ra) # 80005dbc <panic>

00000000800054e0 <trapinit>:
    800054e0:	ff010113          	addi	sp,sp,-16
    800054e4:	00813423          	sd	s0,8(sp)
    800054e8:	01010413          	addi	s0,sp,16
    800054ec:	00813403          	ld	s0,8(sp)
    800054f0:	00003597          	auipc	a1,0x3
    800054f4:	11858593          	addi	a1,a1,280 # 80008608 <CONSOLE_STATUS+0x5f8>
    800054f8:	00006517          	auipc	a0,0x6
    800054fc:	b6850513          	addi	a0,a0,-1176 # 8000b060 <tickslock>
    80005500:	01010113          	addi	sp,sp,16
    80005504:	00001317          	auipc	t1,0x1
    80005508:	5c430067          	jr	1476(t1) # 80006ac8 <initlock>

000000008000550c <trapinithart>:
    8000550c:	ff010113          	addi	sp,sp,-16
    80005510:	00813423          	sd	s0,8(sp)
    80005514:	01010413          	addi	s0,sp,16
    80005518:	00000797          	auipc	a5,0x0
    8000551c:	2f878793          	addi	a5,a5,760 # 80005810 <kernelvec>
    80005520:	10579073          	csrw	stvec,a5
    80005524:	00813403          	ld	s0,8(sp)
    80005528:	01010113          	addi	sp,sp,16
    8000552c:	00008067          	ret

0000000080005530 <usertrap>:
    80005530:	ff010113          	addi	sp,sp,-16
    80005534:	00813423          	sd	s0,8(sp)
    80005538:	01010413          	addi	s0,sp,16
    8000553c:	00813403          	ld	s0,8(sp)
    80005540:	01010113          	addi	sp,sp,16
    80005544:	00008067          	ret

0000000080005548 <usertrapret>:
    80005548:	ff010113          	addi	sp,sp,-16
    8000554c:	00813423          	sd	s0,8(sp)
    80005550:	01010413          	addi	s0,sp,16
    80005554:	00813403          	ld	s0,8(sp)
    80005558:	01010113          	addi	sp,sp,16
    8000555c:	00008067          	ret

0000000080005560 <kerneltrap>:
    80005560:	fe010113          	addi	sp,sp,-32
    80005564:	00813823          	sd	s0,16(sp)
    80005568:	00113c23          	sd	ra,24(sp)
    8000556c:	00913423          	sd	s1,8(sp)
    80005570:	02010413          	addi	s0,sp,32
    80005574:	142025f3          	csrr	a1,scause
    80005578:	100027f3          	csrr	a5,sstatus
    8000557c:	0027f793          	andi	a5,a5,2
    80005580:	10079c63          	bnez	a5,80005698 <kerneltrap+0x138>
    80005584:	142027f3          	csrr	a5,scause
    80005588:	0207ce63          	bltz	a5,800055c4 <kerneltrap+0x64>
    8000558c:	00003517          	auipc	a0,0x3
    80005590:	0c450513          	addi	a0,a0,196 # 80008650 <CONSOLE_STATUS+0x640>
    80005594:	00001097          	auipc	ra,0x1
    80005598:	884080e7          	jalr	-1916(ra) # 80005e18 <__printf>
    8000559c:	141025f3          	csrr	a1,sepc
    800055a0:	14302673          	csrr	a2,stval
    800055a4:	00003517          	auipc	a0,0x3
    800055a8:	0bc50513          	addi	a0,a0,188 # 80008660 <CONSOLE_STATUS+0x650>
    800055ac:	00001097          	auipc	ra,0x1
    800055b0:	86c080e7          	jalr	-1940(ra) # 80005e18 <__printf>
    800055b4:	00003517          	auipc	a0,0x3
    800055b8:	0c450513          	addi	a0,a0,196 # 80008678 <CONSOLE_STATUS+0x668>
    800055bc:	00001097          	auipc	ra,0x1
    800055c0:	800080e7          	jalr	-2048(ra) # 80005dbc <panic>
    800055c4:	0ff7f713          	andi	a4,a5,255
    800055c8:	00900693          	li	a3,9
    800055cc:	04d70063          	beq	a4,a3,8000560c <kerneltrap+0xac>
    800055d0:	fff00713          	li	a4,-1
    800055d4:	03f71713          	slli	a4,a4,0x3f
    800055d8:	00170713          	addi	a4,a4,1
    800055dc:	fae798e3          	bne	a5,a4,8000558c <kerneltrap+0x2c>
    800055e0:	00000097          	auipc	ra,0x0
    800055e4:	e00080e7          	jalr	-512(ra) # 800053e0 <cpuid>
    800055e8:	06050663          	beqz	a0,80005654 <kerneltrap+0xf4>
    800055ec:	144027f3          	csrr	a5,sip
    800055f0:	ffd7f793          	andi	a5,a5,-3
    800055f4:	14479073          	csrw	sip,a5
    800055f8:	01813083          	ld	ra,24(sp)
    800055fc:	01013403          	ld	s0,16(sp)
    80005600:	00813483          	ld	s1,8(sp)
    80005604:	02010113          	addi	sp,sp,32
    80005608:	00008067          	ret
    8000560c:	00000097          	auipc	ra,0x0
    80005610:	3c8080e7          	jalr	968(ra) # 800059d4 <plic_claim>
    80005614:	00a00793          	li	a5,10
    80005618:	00050493          	mv	s1,a0
    8000561c:	06f50863          	beq	a0,a5,8000568c <kerneltrap+0x12c>
    80005620:	fc050ce3          	beqz	a0,800055f8 <kerneltrap+0x98>
    80005624:	00050593          	mv	a1,a0
    80005628:	00003517          	auipc	a0,0x3
    8000562c:	00850513          	addi	a0,a0,8 # 80008630 <CONSOLE_STATUS+0x620>
    80005630:	00000097          	auipc	ra,0x0
    80005634:	7e8080e7          	jalr	2024(ra) # 80005e18 <__printf>
    80005638:	01013403          	ld	s0,16(sp)
    8000563c:	01813083          	ld	ra,24(sp)
    80005640:	00048513          	mv	a0,s1
    80005644:	00813483          	ld	s1,8(sp)
    80005648:	02010113          	addi	sp,sp,32
    8000564c:	00000317          	auipc	t1,0x0
    80005650:	3c030067          	jr	960(t1) # 80005a0c <plic_complete>
    80005654:	00006517          	auipc	a0,0x6
    80005658:	a0c50513          	addi	a0,a0,-1524 # 8000b060 <tickslock>
    8000565c:	00001097          	auipc	ra,0x1
    80005660:	490080e7          	jalr	1168(ra) # 80006aec <acquire>
    80005664:	00005717          	auipc	a4,0x5
    80005668:	8c070713          	addi	a4,a4,-1856 # 80009f24 <ticks>
    8000566c:	00072783          	lw	a5,0(a4)
    80005670:	00006517          	auipc	a0,0x6
    80005674:	9f050513          	addi	a0,a0,-1552 # 8000b060 <tickslock>
    80005678:	0017879b          	addiw	a5,a5,1
    8000567c:	00f72023          	sw	a5,0(a4)
    80005680:	00001097          	auipc	ra,0x1
    80005684:	538080e7          	jalr	1336(ra) # 80006bb8 <release>
    80005688:	f65ff06f          	j	800055ec <kerneltrap+0x8c>
    8000568c:	00001097          	auipc	ra,0x1
    80005690:	094080e7          	jalr	148(ra) # 80006720 <uartintr>
    80005694:	fa5ff06f          	j	80005638 <kerneltrap+0xd8>
    80005698:	00003517          	auipc	a0,0x3
    8000569c:	f7850513          	addi	a0,a0,-136 # 80008610 <CONSOLE_STATUS+0x600>
    800056a0:	00000097          	auipc	ra,0x0
    800056a4:	71c080e7          	jalr	1820(ra) # 80005dbc <panic>

00000000800056a8 <clockintr>:
    800056a8:	fe010113          	addi	sp,sp,-32
    800056ac:	00813823          	sd	s0,16(sp)
    800056b0:	00913423          	sd	s1,8(sp)
    800056b4:	00113c23          	sd	ra,24(sp)
    800056b8:	02010413          	addi	s0,sp,32
    800056bc:	00006497          	auipc	s1,0x6
    800056c0:	9a448493          	addi	s1,s1,-1628 # 8000b060 <tickslock>
    800056c4:	00048513          	mv	a0,s1
    800056c8:	00001097          	auipc	ra,0x1
    800056cc:	424080e7          	jalr	1060(ra) # 80006aec <acquire>
    800056d0:	00005717          	auipc	a4,0x5
    800056d4:	85470713          	addi	a4,a4,-1964 # 80009f24 <ticks>
    800056d8:	00072783          	lw	a5,0(a4)
    800056dc:	01013403          	ld	s0,16(sp)
    800056e0:	01813083          	ld	ra,24(sp)
    800056e4:	00048513          	mv	a0,s1
    800056e8:	0017879b          	addiw	a5,a5,1
    800056ec:	00813483          	ld	s1,8(sp)
    800056f0:	00f72023          	sw	a5,0(a4)
    800056f4:	02010113          	addi	sp,sp,32
    800056f8:	00001317          	auipc	t1,0x1
    800056fc:	4c030067          	jr	1216(t1) # 80006bb8 <release>

0000000080005700 <devintr>:
    80005700:	142027f3          	csrr	a5,scause
    80005704:	00000513          	li	a0,0
    80005708:	0007c463          	bltz	a5,80005710 <devintr+0x10>
    8000570c:	00008067          	ret
    80005710:	fe010113          	addi	sp,sp,-32
    80005714:	00813823          	sd	s0,16(sp)
    80005718:	00113c23          	sd	ra,24(sp)
    8000571c:	00913423          	sd	s1,8(sp)
    80005720:	02010413          	addi	s0,sp,32
    80005724:	0ff7f713          	andi	a4,a5,255
    80005728:	00900693          	li	a3,9
    8000572c:	04d70c63          	beq	a4,a3,80005784 <devintr+0x84>
    80005730:	fff00713          	li	a4,-1
    80005734:	03f71713          	slli	a4,a4,0x3f
    80005738:	00170713          	addi	a4,a4,1
    8000573c:	00e78c63          	beq	a5,a4,80005754 <devintr+0x54>
    80005740:	01813083          	ld	ra,24(sp)
    80005744:	01013403          	ld	s0,16(sp)
    80005748:	00813483          	ld	s1,8(sp)
    8000574c:	02010113          	addi	sp,sp,32
    80005750:	00008067          	ret
    80005754:	00000097          	auipc	ra,0x0
    80005758:	c8c080e7          	jalr	-884(ra) # 800053e0 <cpuid>
    8000575c:	06050663          	beqz	a0,800057c8 <devintr+0xc8>
    80005760:	144027f3          	csrr	a5,sip
    80005764:	ffd7f793          	andi	a5,a5,-3
    80005768:	14479073          	csrw	sip,a5
    8000576c:	01813083          	ld	ra,24(sp)
    80005770:	01013403          	ld	s0,16(sp)
    80005774:	00813483          	ld	s1,8(sp)
    80005778:	00200513          	li	a0,2
    8000577c:	02010113          	addi	sp,sp,32
    80005780:	00008067          	ret
    80005784:	00000097          	auipc	ra,0x0
    80005788:	250080e7          	jalr	592(ra) # 800059d4 <plic_claim>
    8000578c:	00a00793          	li	a5,10
    80005790:	00050493          	mv	s1,a0
    80005794:	06f50663          	beq	a0,a5,80005800 <devintr+0x100>
    80005798:	00100513          	li	a0,1
    8000579c:	fa0482e3          	beqz	s1,80005740 <devintr+0x40>
    800057a0:	00048593          	mv	a1,s1
    800057a4:	00003517          	auipc	a0,0x3
    800057a8:	e8c50513          	addi	a0,a0,-372 # 80008630 <CONSOLE_STATUS+0x620>
    800057ac:	00000097          	auipc	ra,0x0
    800057b0:	66c080e7          	jalr	1644(ra) # 80005e18 <__printf>
    800057b4:	00048513          	mv	a0,s1
    800057b8:	00000097          	auipc	ra,0x0
    800057bc:	254080e7          	jalr	596(ra) # 80005a0c <plic_complete>
    800057c0:	00100513          	li	a0,1
    800057c4:	f7dff06f          	j	80005740 <devintr+0x40>
    800057c8:	00006517          	auipc	a0,0x6
    800057cc:	89850513          	addi	a0,a0,-1896 # 8000b060 <tickslock>
    800057d0:	00001097          	auipc	ra,0x1
    800057d4:	31c080e7          	jalr	796(ra) # 80006aec <acquire>
    800057d8:	00004717          	auipc	a4,0x4
    800057dc:	74c70713          	addi	a4,a4,1868 # 80009f24 <ticks>
    800057e0:	00072783          	lw	a5,0(a4)
    800057e4:	00006517          	auipc	a0,0x6
    800057e8:	87c50513          	addi	a0,a0,-1924 # 8000b060 <tickslock>
    800057ec:	0017879b          	addiw	a5,a5,1
    800057f0:	00f72023          	sw	a5,0(a4)
    800057f4:	00001097          	auipc	ra,0x1
    800057f8:	3c4080e7          	jalr	964(ra) # 80006bb8 <release>
    800057fc:	f65ff06f          	j	80005760 <devintr+0x60>
    80005800:	00001097          	auipc	ra,0x1
    80005804:	f20080e7          	jalr	-224(ra) # 80006720 <uartintr>
    80005808:	fadff06f          	j	800057b4 <devintr+0xb4>
    8000580c:	0000                	unimp
	...

0000000080005810 <kernelvec>:
    80005810:	f0010113          	addi	sp,sp,-256
    80005814:	00113023          	sd	ra,0(sp)
    80005818:	00213423          	sd	sp,8(sp)
    8000581c:	00313823          	sd	gp,16(sp)
    80005820:	00413c23          	sd	tp,24(sp)
    80005824:	02513023          	sd	t0,32(sp)
    80005828:	02613423          	sd	t1,40(sp)
    8000582c:	02713823          	sd	t2,48(sp)
    80005830:	02813c23          	sd	s0,56(sp)
    80005834:	04913023          	sd	s1,64(sp)
    80005838:	04a13423          	sd	a0,72(sp)
    8000583c:	04b13823          	sd	a1,80(sp)
    80005840:	04c13c23          	sd	a2,88(sp)
    80005844:	06d13023          	sd	a3,96(sp)
    80005848:	06e13423          	sd	a4,104(sp)
    8000584c:	06f13823          	sd	a5,112(sp)
    80005850:	07013c23          	sd	a6,120(sp)
    80005854:	09113023          	sd	a7,128(sp)
    80005858:	09213423          	sd	s2,136(sp)
    8000585c:	09313823          	sd	s3,144(sp)
    80005860:	09413c23          	sd	s4,152(sp)
    80005864:	0b513023          	sd	s5,160(sp)
    80005868:	0b613423          	sd	s6,168(sp)
    8000586c:	0b713823          	sd	s7,176(sp)
    80005870:	0b813c23          	sd	s8,184(sp)
    80005874:	0d913023          	sd	s9,192(sp)
    80005878:	0da13423          	sd	s10,200(sp)
    8000587c:	0db13823          	sd	s11,208(sp)
    80005880:	0dc13c23          	sd	t3,216(sp)
    80005884:	0fd13023          	sd	t4,224(sp)
    80005888:	0fe13423          	sd	t5,232(sp)
    8000588c:	0ff13823          	sd	t6,240(sp)
    80005890:	cd1ff0ef          	jal	ra,80005560 <kerneltrap>
    80005894:	00013083          	ld	ra,0(sp)
    80005898:	00813103          	ld	sp,8(sp)
    8000589c:	01013183          	ld	gp,16(sp)
    800058a0:	02013283          	ld	t0,32(sp)
    800058a4:	02813303          	ld	t1,40(sp)
    800058a8:	03013383          	ld	t2,48(sp)
    800058ac:	03813403          	ld	s0,56(sp)
    800058b0:	04013483          	ld	s1,64(sp)
    800058b4:	04813503          	ld	a0,72(sp)
    800058b8:	05013583          	ld	a1,80(sp)
    800058bc:	05813603          	ld	a2,88(sp)
    800058c0:	06013683          	ld	a3,96(sp)
    800058c4:	06813703          	ld	a4,104(sp)
    800058c8:	07013783          	ld	a5,112(sp)
    800058cc:	07813803          	ld	a6,120(sp)
    800058d0:	08013883          	ld	a7,128(sp)
    800058d4:	08813903          	ld	s2,136(sp)
    800058d8:	09013983          	ld	s3,144(sp)
    800058dc:	09813a03          	ld	s4,152(sp)
    800058e0:	0a013a83          	ld	s5,160(sp)
    800058e4:	0a813b03          	ld	s6,168(sp)
    800058e8:	0b013b83          	ld	s7,176(sp)
    800058ec:	0b813c03          	ld	s8,184(sp)
    800058f0:	0c013c83          	ld	s9,192(sp)
    800058f4:	0c813d03          	ld	s10,200(sp)
    800058f8:	0d013d83          	ld	s11,208(sp)
    800058fc:	0d813e03          	ld	t3,216(sp)
    80005900:	0e013e83          	ld	t4,224(sp)
    80005904:	0e813f03          	ld	t5,232(sp)
    80005908:	0f013f83          	ld	t6,240(sp)
    8000590c:	10010113          	addi	sp,sp,256
    80005910:	10200073          	sret
    80005914:	00000013          	nop
    80005918:	00000013          	nop
    8000591c:	00000013          	nop

0000000080005920 <timervec>:
    80005920:	34051573          	csrrw	a0,mscratch,a0
    80005924:	00b53023          	sd	a1,0(a0)
    80005928:	00c53423          	sd	a2,8(a0)
    8000592c:	00d53823          	sd	a3,16(a0)
    80005930:	01853583          	ld	a1,24(a0)
    80005934:	02053603          	ld	a2,32(a0)
    80005938:	0005b683          	ld	a3,0(a1)
    8000593c:	00c686b3          	add	a3,a3,a2
    80005940:	00d5b023          	sd	a3,0(a1)
    80005944:	00200593          	li	a1,2
    80005948:	14459073          	csrw	sip,a1
    8000594c:	01053683          	ld	a3,16(a0)
    80005950:	00853603          	ld	a2,8(a0)
    80005954:	00053583          	ld	a1,0(a0)
    80005958:	34051573          	csrrw	a0,mscratch,a0
    8000595c:	30200073          	mret

0000000080005960 <plicinit>:
    80005960:	ff010113          	addi	sp,sp,-16
    80005964:	00813423          	sd	s0,8(sp)
    80005968:	01010413          	addi	s0,sp,16
    8000596c:	00813403          	ld	s0,8(sp)
    80005970:	0c0007b7          	lui	a5,0xc000
    80005974:	00100713          	li	a4,1
    80005978:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000597c:	00e7a223          	sw	a4,4(a5)
    80005980:	01010113          	addi	sp,sp,16
    80005984:	00008067          	ret

0000000080005988 <plicinithart>:
    80005988:	ff010113          	addi	sp,sp,-16
    8000598c:	00813023          	sd	s0,0(sp)
    80005990:	00113423          	sd	ra,8(sp)
    80005994:	01010413          	addi	s0,sp,16
    80005998:	00000097          	auipc	ra,0x0
    8000599c:	a48080e7          	jalr	-1464(ra) # 800053e0 <cpuid>
    800059a0:	0085171b          	slliw	a4,a0,0x8
    800059a4:	0c0027b7          	lui	a5,0xc002
    800059a8:	00e787b3          	add	a5,a5,a4
    800059ac:	40200713          	li	a4,1026
    800059b0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800059b4:	00813083          	ld	ra,8(sp)
    800059b8:	00013403          	ld	s0,0(sp)
    800059bc:	00d5151b          	slliw	a0,a0,0xd
    800059c0:	0c2017b7          	lui	a5,0xc201
    800059c4:	00a78533          	add	a0,a5,a0
    800059c8:	00052023          	sw	zero,0(a0)
    800059cc:	01010113          	addi	sp,sp,16
    800059d0:	00008067          	ret

00000000800059d4 <plic_claim>:
    800059d4:	ff010113          	addi	sp,sp,-16
    800059d8:	00813023          	sd	s0,0(sp)
    800059dc:	00113423          	sd	ra,8(sp)
    800059e0:	01010413          	addi	s0,sp,16
    800059e4:	00000097          	auipc	ra,0x0
    800059e8:	9fc080e7          	jalr	-1540(ra) # 800053e0 <cpuid>
    800059ec:	00813083          	ld	ra,8(sp)
    800059f0:	00013403          	ld	s0,0(sp)
    800059f4:	00d5151b          	slliw	a0,a0,0xd
    800059f8:	0c2017b7          	lui	a5,0xc201
    800059fc:	00a78533          	add	a0,a5,a0
    80005a00:	00452503          	lw	a0,4(a0)
    80005a04:	01010113          	addi	sp,sp,16
    80005a08:	00008067          	ret

0000000080005a0c <plic_complete>:
    80005a0c:	fe010113          	addi	sp,sp,-32
    80005a10:	00813823          	sd	s0,16(sp)
    80005a14:	00913423          	sd	s1,8(sp)
    80005a18:	00113c23          	sd	ra,24(sp)
    80005a1c:	02010413          	addi	s0,sp,32
    80005a20:	00050493          	mv	s1,a0
    80005a24:	00000097          	auipc	ra,0x0
    80005a28:	9bc080e7          	jalr	-1604(ra) # 800053e0 <cpuid>
    80005a2c:	01813083          	ld	ra,24(sp)
    80005a30:	01013403          	ld	s0,16(sp)
    80005a34:	00d5179b          	slliw	a5,a0,0xd
    80005a38:	0c201737          	lui	a4,0xc201
    80005a3c:	00f707b3          	add	a5,a4,a5
    80005a40:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005a44:	00813483          	ld	s1,8(sp)
    80005a48:	02010113          	addi	sp,sp,32
    80005a4c:	00008067          	ret

0000000080005a50 <consolewrite>:
    80005a50:	fb010113          	addi	sp,sp,-80
    80005a54:	04813023          	sd	s0,64(sp)
    80005a58:	04113423          	sd	ra,72(sp)
    80005a5c:	02913c23          	sd	s1,56(sp)
    80005a60:	03213823          	sd	s2,48(sp)
    80005a64:	03313423          	sd	s3,40(sp)
    80005a68:	03413023          	sd	s4,32(sp)
    80005a6c:	01513c23          	sd	s5,24(sp)
    80005a70:	05010413          	addi	s0,sp,80
    80005a74:	06c05c63          	blez	a2,80005aec <consolewrite+0x9c>
    80005a78:	00060993          	mv	s3,a2
    80005a7c:	00050a13          	mv	s4,a0
    80005a80:	00058493          	mv	s1,a1
    80005a84:	00000913          	li	s2,0
    80005a88:	fff00a93          	li	s5,-1
    80005a8c:	01c0006f          	j	80005aa8 <consolewrite+0x58>
    80005a90:	fbf44503          	lbu	a0,-65(s0)
    80005a94:	0019091b          	addiw	s2,s2,1
    80005a98:	00148493          	addi	s1,s1,1
    80005a9c:	00001097          	auipc	ra,0x1
    80005aa0:	a9c080e7          	jalr	-1380(ra) # 80006538 <uartputc>
    80005aa4:	03298063          	beq	s3,s2,80005ac4 <consolewrite+0x74>
    80005aa8:	00048613          	mv	a2,s1
    80005aac:	00100693          	li	a3,1
    80005ab0:	000a0593          	mv	a1,s4
    80005ab4:	fbf40513          	addi	a0,s0,-65
    80005ab8:	00000097          	auipc	ra,0x0
    80005abc:	9e0080e7          	jalr	-1568(ra) # 80005498 <either_copyin>
    80005ac0:	fd5518e3          	bne	a0,s5,80005a90 <consolewrite+0x40>
    80005ac4:	04813083          	ld	ra,72(sp)
    80005ac8:	04013403          	ld	s0,64(sp)
    80005acc:	03813483          	ld	s1,56(sp)
    80005ad0:	02813983          	ld	s3,40(sp)
    80005ad4:	02013a03          	ld	s4,32(sp)
    80005ad8:	01813a83          	ld	s5,24(sp)
    80005adc:	00090513          	mv	a0,s2
    80005ae0:	03013903          	ld	s2,48(sp)
    80005ae4:	05010113          	addi	sp,sp,80
    80005ae8:	00008067          	ret
    80005aec:	00000913          	li	s2,0
    80005af0:	fd5ff06f          	j	80005ac4 <consolewrite+0x74>

0000000080005af4 <consoleread>:
    80005af4:	f9010113          	addi	sp,sp,-112
    80005af8:	06813023          	sd	s0,96(sp)
    80005afc:	04913c23          	sd	s1,88(sp)
    80005b00:	05213823          	sd	s2,80(sp)
    80005b04:	05313423          	sd	s3,72(sp)
    80005b08:	05413023          	sd	s4,64(sp)
    80005b0c:	03513c23          	sd	s5,56(sp)
    80005b10:	03613823          	sd	s6,48(sp)
    80005b14:	03713423          	sd	s7,40(sp)
    80005b18:	03813023          	sd	s8,32(sp)
    80005b1c:	06113423          	sd	ra,104(sp)
    80005b20:	01913c23          	sd	s9,24(sp)
    80005b24:	07010413          	addi	s0,sp,112
    80005b28:	00060b93          	mv	s7,a2
    80005b2c:	00050913          	mv	s2,a0
    80005b30:	00058c13          	mv	s8,a1
    80005b34:	00060b1b          	sext.w	s6,a2
    80005b38:	00005497          	auipc	s1,0x5
    80005b3c:	55048493          	addi	s1,s1,1360 # 8000b088 <cons>
    80005b40:	00400993          	li	s3,4
    80005b44:	fff00a13          	li	s4,-1
    80005b48:	00a00a93          	li	s5,10
    80005b4c:	05705e63          	blez	s7,80005ba8 <consoleread+0xb4>
    80005b50:	09c4a703          	lw	a4,156(s1)
    80005b54:	0984a783          	lw	a5,152(s1)
    80005b58:	0007071b          	sext.w	a4,a4
    80005b5c:	08e78463          	beq	a5,a4,80005be4 <consoleread+0xf0>
    80005b60:	07f7f713          	andi	a4,a5,127
    80005b64:	00e48733          	add	a4,s1,a4
    80005b68:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005b6c:	0017869b          	addiw	a3,a5,1
    80005b70:	08d4ac23          	sw	a3,152(s1)
    80005b74:	00070c9b          	sext.w	s9,a4
    80005b78:	0b370663          	beq	a4,s3,80005c24 <consoleread+0x130>
    80005b7c:	00100693          	li	a3,1
    80005b80:	f9f40613          	addi	a2,s0,-97
    80005b84:	000c0593          	mv	a1,s8
    80005b88:	00090513          	mv	a0,s2
    80005b8c:	f8e40fa3          	sb	a4,-97(s0)
    80005b90:	00000097          	auipc	ra,0x0
    80005b94:	8bc080e7          	jalr	-1860(ra) # 8000544c <either_copyout>
    80005b98:	01450863          	beq	a0,s4,80005ba8 <consoleread+0xb4>
    80005b9c:	001c0c13          	addi	s8,s8,1
    80005ba0:	fffb8b9b          	addiw	s7,s7,-1
    80005ba4:	fb5c94e3          	bne	s9,s5,80005b4c <consoleread+0x58>
    80005ba8:	000b851b          	sext.w	a0,s7
    80005bac:	06813083          	ld	ra,104(sp)
    80005bb0:	06013403          	ld	s0,96(sp)
    80005bb4:	05813483          	ld	s1,88(sp)
    80005bb8:	05013903          	ld	s2,80(sp)
    80005bbc:	04813983          	ld	s3,72(sp)
    80005bc0:	04013a03          	ld	s4,64(sp)
    80005bc4:	03813a83          	ld	s5,56(sp)
    80005bc8:	02813b83          	ld	s7,40(sp)
    80005bcc:	02013c03          	ld	s8,32(sp)
    80005bd0:	01813c83          	ld	s9,24(sp)
    80005bd4:	40ab053b          	subw	a0,s6,a0
    80005bd8:	03013b03          	ld	s6,48(sp)
    80005bdc:	07010113          	addi	sp,sp,112
    80005be0:	00008067          	ret
    80005be4:	00001097          	auipc	ra,0x1
    80005be8:	1d8080e7          	jalr	472(ra) # 80006dbc <push_on>
    80005bec:	0984a703          	lw	a4,152(s1)
    80005bf0:	09c4a783          	lw	a5,156(s1)
    80005bf4:	0007879b          	sext.w	a5,a5
    80005bf8:	fef70ce3          	beq	a4,a5,80005bf0 <consoleread+0xfc>
    80005bfc:	00001097          	auipc	ra,0x1
    80005c00:	234080e7          	jalr	564(ra) # 80006e30 <pop_on>
    80005c04:	0984a783          	lw	a5,152(s1)
    80005c08:	07f7f713          	andi	a4,a5,127
    80005c0c:	00e48733          	add	a4,s1,a4
    80005c10:	01874703          	lbu	a4,24(a4)
    80005c14:	0017869b          	addiw	a3,a5,1
    80005c18:	08d4ac23          	sw	a3,152(s1)
    80005c1c:	00070c9b          	sext.w	s9,a4
    80005c20:	f5371ee3          	bne	a4,s3,80005b7c <consoleread+0x88>
    80005c24:	000b851b          	sext.w	a0,s7
    80005c28:	f96bf2e3          	bgeu	s7,s6,80005bac <consoleread+0xb8>
    80005c2c:	08f4ac23          	sw	a5,152(s1)
    80005c30:	f7dff06f          	j	80005bac <consoleread+0xb8>

0000000080005c34 <consputc>:
    80005c34:	10000793          	li	a5,256
    80005c38:	00f50663          	beq	a0,a5,80005c44 <consputc+0x10>
    80005c3c:	00001317          	auipc	t1,0x1
    80005c40:	9f430067          	jr	-1548(t1) # 80006630 <uartputc_sync>
    80005c44:	ff010113          	addi	sp,sp,-16
    80005c48:	00113423          	sd	ra,8(sp)
    80005c4c:	00813023          	sd	s0,0(sp)
    80005c50:	01010413          	addi	s0,sp,16
    80005c54:	00800513          	li	a0,8
    80005c58:	00001097          	auipc	ra,0x1
    80005c5c:	9d8080e7          	jalr	-1576(ra) # 80006630 <uartputc_sync>
    80005c60:	02000513          	li	a0,32
    80005c64:	00001097          	auipc	ra,0x1
    80005c68:	9cc080e7          	jalr	-1588(ra) # 80006630 <uartputc_sync>
    80005c6c:	00013403          	ld	s0,0(sp)
    80005c70:	00813083          	ld	ra,8(sp)
    80005c74:	00800513          	li	a0,8
    80005c78:	01010113          	addi	sp,sp,16
    80005c7c:	00001317          	auipc	t1,0x1
    80005c80:	9b430067          	jr	-1612(t1) # 80006630 <uartputc_sync>

0000000080005c84 <consoleintr>:
    80005c84:	fe010113          	addi	sp,sp,-32
    80005c88:	00813823          	sd	s0,16(sp)
    80005c8c:	00913423          	sd	s1,8(sp)
    80005c90:	01213023          	sd	s2,0(sp)
    80005c94:	00113c23          	sd	ra,24(sp)
    80005c98:	02010413          	addi	s0,sp,32
    80005c9c:	00005917          	auipc	s2,0x5
    80005ca0:	3ec90913          	addi	s2,s2,1004 # 8000b088 <cons>
    80005ca4:	00050493          	mv	s1,a0
    80005ca8:	00090513          	mv	a0,s2
    80005cac:	00001097          	auipc	ra,0x1
    80005cb0:	e40080e7          	jalr	-448(ra) # 80006aec <acquire>
    80005cb4:	02048c63          	beqz	s1,80005cec <consoleintr+0x68>
    80005cb8:	0a092783          	lw	a5,160(s2)
    80005cbc:	09892703          	lw	a4,152(s2)
    80005cc0:	07f00693          	li	a3,127
    80005cc4:	40e7873b          	subw	a4,a5,a4
    80005cc8:	02e6e263          	bltu	a3,a4,80005cec <consoleintr+0x68>
    80005ccc:	00d00713          	li	a4,13
    80005cd0:	04e48063          	beq	s1,a4,80005d10 <consoleintr+0x8c>
    80005cd4:	07f7f713          	andi	a4,a5,127
    80005cd8:	00e90733          	add	a4,s2,a4
    80005cdc:	0017879b          	addiw	a5,a5,1
    80005ce0:	0af92023          	sw	a5,160(s2)
    80005ce4:	00970c23          	sb	s1,24(a4)
    80005ce8:	08f92e23          	sw	a5,156(s2)
    80005cec:	01013403          	ld	s0,16(sp)
    80005cf0:	01813083          	ld	ra,24(sp)
    80005cf4:	00813483          	ld	s1,8(sp)
    80005cf8:	00013903          	ld	s2,0(sp)
    80005cfc:	00005517          	auipc	a0,0x5
    80005d00:	38c50513          	addi	a0,a0,908 # 8000b088 <cons>
    80005d04:	02010113          	addi	sp,sp,32
    80005d08:	00001317          	auipc	t1,0x1
    80005d0c:	eb030067          	jr	-336(t1) # 80006bb8 <release>
    80005d10:	00a00493          	li	s1,10
    80005d14:	fc1ff06f          	j	80005cd4 <consoleintr+0x50>

0000000080005d18 <consoleinit>:
    80005d18:	fe010113          	addi	sp,sp,-32
    80005d1c:	00113c23          	sd	ra,24(sp)
    80005d20:	00813823          	sd	s0,16(sp)
    80005d24:	00913423          	sd	s1,8(sp)
    80005d28:	02010413          	addi	s0,sp,32
    80005d2c:	00005497          	auipc	s1,0x5
    80005d30:	35c48493          	addi	s1,s1,860 # 8000b088 <cons>
    80005d34:	00048513          	mv	a0,s1
    80005d38:	00003597          	auipc	a1,0x3
    80005d3c:	95058593          	addi	a1,a1,-1712 # 80008688 <CONSOLE_STATUS+0x678>
    80005d40:	00001097          	auipc	ra,0x1
    80005d44:	d88080e7          	jalr	-632(ra) # 80006ac8 <initlock>
    80005d48:	00000097          	auipc	ra,0x0
    80005d4c:	7ac080e7          	jalr	1964(ra) # 800064f4 <uartinit>
    80005d50:	01813083          	ld	ra,24(sp)
    80005d54:	01013403          	ld	s0,16(sp)
    80005d58:	00000797          	auipc	a5,0x0
    80005d5c:	d9c78793          	addi	a5,a5,-612 # 80005af4 <consoleread>
    80005d60:	0af4bc23          	sd	a5,184(s1)
    80005d64:	00000797          	auipc	a5,0x0
    80005d68:	cec78793          	addi	a5,a5,-788 # 80005a50 <consolewrite>
    80005d6c:	0cf4b023          	sd	a5,192(s1)
    80005d70:	00813483          	ld	s1,8(sp)
    80005d74:	02010113          	addi	sp,sp,32
    80005d78:	00008067          	ret

0000000080005d7c <console_read>:
    80005d7c:	ff010113          	addi	sp,sp,-16
    80005d80:	00813423          	sd	s0,8(sp)
    80005d84:	01010413          	addi	s0,sp,16
    80005d88:	00813403          	ld	s0,8(sp)
    80005d8c:	00005317          	auipc	t1,0x5
    80005d90:	3b433303          	ld	t1,948(t1) # 8000b140 <devsw+0x10>
    80005d94:	01010113          	addi	sp,sp,16
    80005d98:	00030067          	jr	t1

0000000080005d9c <console_write>:
    80005d9c:	ff010113          	addi	sp,sp,-16
    80005da0:	00813423          	sd	s0,8(sp)
    80005da4:	01010413          	addi	s0,sp,16
    80005da8:	00813403          	ld	s0,8(sp)
    80005dac:	00005317          	auipc	t1,0x5
    80005db0:	39c33303          	ld	t1,924(t1) # 8000b148 <devsw+0x18>
    80005db4:	01010113          	addi	sp,sp,16
    80005db8:	00030067          	jr	t1

0000000080005dbc <panic>:
    80005dbc:	fe010113          	addi	sp,sp,-32
    80005dc0:	00113c23          	sd	ra,24(sp)
    80005dc4:	00813823          	sd	s0,16(sp)
    80005dc8:	00913423          	sd	s1,8(sp)
    80005dcc:	02010413          	addi	s0,sp,32
    80005dd0:	00050493          	mv	s1,a0
    80005dd4:	00003517          	auipc	a0,0x3
    80005dd8:	8bc50513          	addi	a0,a0,-1860 # 80008690 <CONSOLE_STATUS+0x680>
    80005ddc:	00005797          	auipc	a5,0x5
    80005de0:	4007a623          	sw	zero,1036(a5) # 8000b1e8 <pr+0x18>
    80005de4:	00000097          	auipc	ra,0x0
    80005de8:	034080e7          	jalr	52(ra) # 80005e18 <__printf>
    80005dec:	00048513          	mv	a0,s1
    80005df0:	00000097          	auipc	ra,0x0
    80005df4:	028080e7          	jalr	40(ra) # 80005e18 <__printf>
    80005df8:	00002517          	auipc	a0,0x2
    80005dfc:	59050513          	addi	a0,a0,1424 # 80008388 <CONSOLE_STATUS+0x378>
    80005e00:	00000097          	auipc	ra,0x0
    80005e04:	018080e7          	jalr	24(ra) # 80005e18 <__printf>
    80005e08:	00100793          	li	a5,1
    80005e0c:	00004717          	auipc	a4,0x4
    80005e10:	10f72e23          	sw	a5,284(a4) # 80009f28 <panicked>
    80005e14:	0000006f          	j	80005e14 <panic+0x58>

0000000080005e18 <__printf>:
    80005e18:	f3010113          	addi	sp,sp,-208
    80005e1c:	08813023          	sd	s0,128(sp)
    80005e20:	07313423          	sd	s3,104(sp)
    80005e24:	09010413          	addi	s0,sp,144
    80005e28:	05813023          	sd	s8,64(sp)
    80005e2c:	08113423          	sd	ra,136(sp)
    80005e30:	06913c23          	sd	s1,120(sp)
    80005e34:	07213823          	sd	s2,112(sp)
    80005e38:	07413023          	sd	s4,96(sp)
    80005e3c:	05513c23          	sd	s5,88(sp)
    80005e40:	05613823          	sd	s6,80(sp)
    80005e44:	05713423          	sd	s7,72(sp)
    80005e48:	03913c23          	sd	s9,56(sp)
    80005e4c:	03a13823          	sd	s10,48(sp)
    80005e50:	03b13423          	sd	s11,40(sp)
    80005e54:	00005317          	auipc	t1,0x5
    80005e58:	37c30313          	addi	t1,t1,892 # 8000b1d0 <pr>
    80005e5c:	01832c03          	lw	s8,24(t1)
    80005e60:	00b43423          	sd	a1,8(s0)
    80005e64:	00c43823          	sd	a2,16(s0)
    80005e68:	00d43c23          	sd	a3,24(s0)
    80005e6c:	02e43023          	sd	a4,32(s0)
    80005e70:	02f43423          	sd	a5,40(s0)
    80005e74:	03043823          	sd	a6,48(s0)
    80005e78:	03143c23          	sd	a7,56(s0)
    80005e7c:	00050993          	mv	s3,a0
    80005e80:	4a0c1663          	bnez	s8,8000632c <__printf+0x514>
    80005e84:	60098c63          	beqz	s3,8000649c <__printf+0x684>
    80005e88:	0009c503          	lbu	a0,0(s3)
    80005e8c:	00840793          	addi	a5,s0,8
    80005e90:	f6f43c23          	sd	a5,-136(s0)
    80005e94:	00000493          	li	s1,0
    80005e98:	22050063          	beqz	a0,800060b8 <__printf+0x2a0>
    80005e9c:	00002a37          	lui	s4,0x2
    80005ea0:	00018ab7          	lui	s5,0x18
    80005ea4:	000f4b37          	lui	s6,0xf4
    80005ea8:	00989bb7          	lui	s7,0x989
    80005eac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005eb0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005eb4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005eb8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005ebc:	00148c9b          	addiw	s9,s1,1
    80005ec0:	02500793          	li	a5,37
    80005ec4:	01998933          	add	s2,s3,s9
    80005ec8:	38f51263          	bne	a0,a5,8000624c <__printf+0x434>
    80005ecc:	00094783          	lbu	a5,0(s2)
    80005ed0:	00078c9b          	sext.w	s9,a5
    80005ed4:	1e078263          	beqz	a5,800060b8 <__printf+0x2a0>
    80005ed8:	0024849b          	addiw	s1,s1,2
    80005edc:	07000713          	li	a4,112
    80005ee0:	00998933          	add	s2,s3,s1
    80005ee4:	38e78a63          	beq	a5,a4,80006278 <__printf+0x460>
    80005ee8:	20f76863          	bltu	a4,a5,800060f8 <__printf+0x2e0>
    80005eec:	42a78863          	beq	a5,a0,8000631c <__printf+0x504>
    80005ef0:	06400713          	li	a4,100
    80005ef4:	40e79663          	bne	a5,a4,80006300 <__printf+0x4e8>
    80005ef8:	f7843783          	ld	a5,-136(s0)
    80005efc:	0007a603          	lw	a2,0(a5)
    80005f00:	00878793          	addi	a5,a5,8
    80005f04:	f6f43c23          	sd	a5,-136(s0)
    80005f08:	42064a63          	bltz	a2,8000633c <__printf+0x524>
    80005f0c:	00a00713          	li	a4,10
    80005f10:	02e677bb          	remuw	a5,a2,a4
    80005f14:	00002d97          	auipc	s11,0x2
    80005f18:	7a4d8d93          	addi	s11,s11,1956 # 800086b8 <digits>
    80005f1c:	00900593          	li	a1,9
    80005f20:	0006051b          	sext.w	a0,a2
    80005f24:	00000c93          	li	s9,0
    80005f28:	02079793          	slli	a5,a5,0x20
    80005f2c:	0207d793          	srli	a5,a5,0x20
    80005f30:	00fd87b3          	add	a5,s11,a5
    80005f34:	0007c783          	lbu	a5,0(a5)
    80005f38:	02e656bb          	divuw	a3,a2,a4
    80005f3c:	f8f40023          	sb	a5,-128(s0)
    80005f40:	14c5d863          	bge	a1,a2,80006090 <__printf+0x278>
    80005f44:	06300593          	li	a1,99
    80005f48:	00100c93          	li	s9,1
    80005f4c:	02e6f7bb          	remuw	a5,a3,a4
    80005f50:	02079793          	slli	a5,a5,0x20
    80005f54:	0207d793          	srli	a5,a5,0x20
    80005f58:	00fd87b3          	add	a5,s11,a5
    80005f5c:	0007c783          	lbu	a5,0(a5)
    80005f60:	02e6d73b          	divuw	a4,a3,a4
    80005f64:	f8f400a3          	sb	a5,-127(s0)
    80005f68:	12a5f463          	bgeu	a1,a0,80006090 <__printf+0x278>
    80005f6c:	00a00693          	li	a3,10
    80005f70:	00900593          	li	a1,9
    80005f74:	02d777bb          	remuw	a5,a4,a3
    80005f78:	02079793          	slli	a5,a5,0x20
    80005f7c:	0207d793          	srli	a5,a5,0x20
    80005f80:	00fd87b3          	add	a5,s11,a5
    80005f84:	0007c503          	lbu	a0,0(a5)
    80005f88:	02d757bb          	divuw	a5,a4,a3
    80005f8c:	f8a40123          	sb	a0,-126(s0)
    80005f90:	48e5f263          	bgeu	a1,a4,80006414 <__printf+0x5fc>
    80005f94:	06300513          	li	a0,99
    80005f98:	02d7f5bb          	remuw	a1,a5,a3
    80005f9c:	02059593          	slli	a1,a1,0x20
    80005fa0:	0205d593          	srli	a1,a1,0x20
    80005fa4:	00bd85b3          	add	a1,s11,a1
    80005fa8:	0005c583          	lbu	a1,0(a1)
    80005fac:	02d7d7bb          	divuw	a5,a5,a3
    80005fb0:	f8b401a3          	sb	a1,-125(s0)
    80005fb4:	48e57263          	bgeu	a0,a4,80006438 <__printf+0x620>
    80005fb8:	3e700513          	li	a0,999
    80005fbc:	02d7f5bb          	remuw	a1,a5,a3
    80005fc0:	02059593          	slli	a1,a1,0x20
    80005fc4:	0205d593          	srli	a1,a1,0x20
    80005fc8:	00bd85b3          	add	a1,s11,a1
    80005fcc:	0005c583          	lbu	a1,0(a1)
    80005fd0:	02d7d7bb          	divuw	a5,a5,a3
    80005fd4:	f8b40223          	sb	a1,-124(s0)
    80005fd8:	46e57663          	bgeu	a0,a4,80006444 <__printf+0x62c>
    80005fdc:	02d7f5bb          	remuw	a1,a5,a3
    80005fe0:	02059593          	slli	a1,a1,0x20
    80005fe4:	0205d593          	srli	a1,a1,0x20
    80005fe8:	00bd85b3          	add	a1,s11,a1
    80005fec:	0005c583          	lbu	a1,0(a1)
    80005ff0:	02d7d7bb          	divuw	a5,a5,a3
    80005ff4:	f8b402a3          	sb	a1,-123(s0)
    80005ff8:	46ea7863          	bgeu	s4,a4,80006468 <__printf+0x650>
    80005ffc:	02d7f5bb          	remuw	a1,a5,a3
    80006000:	02059593          	slli	a1,a1,0x20
    80006004:	0205d593          	srli	a1,a1,0x20
    80006008:	00bd85b3          	add	a1,s11,a1
    8000600c:	0005c583          	lbu	a1,0(a1)
    80006010:	02d7d7bb          	divuw	a5,a5,a3
    80006014:	f8b40323          	sb	a1,-122(s0)
    80006018:	3eeaf863          	bgeu	s5,a4,80006408 <__printf+0x5f0>
    8000601c:	02d7f5bb          	remuw	a1,a5,a3
    80006020:	02059593          	slli	a1,a1,0x20
    80006024:	0205d593          	srli	a1,a1,0x20
    80006028:	00bd85b3          	add	a1,s11,a1
    8000602c:	0005c583          	lbu	a1,0(a1)
    80006030:	02d7d7bb          	divuw	a5,a5,a3
    80006034:	f8b403a3          	sb	a1,-121(s0)
    80006038:	42eb7e63          	bgeu	s6,a4,80006474 <__printf+0x65c>
    8000603c:	02d7f5bb          	remuw	a1,a5,a3
    80006040:	02059593          	slli	a1,a1,0x20
    80006044:	0205d593          	srli	a1,a1,0x20
    80006048:	00bd85b3          	add	a1,s11,a1
    8000604c:	0005c583          	lbu	a1,0(a1)
    80006050:	02d7d7bb          	divuw	a5,a5,a3
    80006054:	f8b40423          	sb	a1,-120(s0)
    80006058:	42ebfc63          	bgeu	s7,a4,80006490 <__printf+0x678>
    8000605c:	02079793          	slli	a5,a5,0x20
    80006060:	0207d793          	srli	a5,a5,0x20
    80006064:	00fd8db3          	add	s11,s11,a5
    80006068:	000dc703          	lbu	a4,0(s11)
    8000606c:	00a00793          	li	a5,10
    80006070:	00900c93          	li	s9,9
    80006074:	f8e404a3          	sb	a4,-119(s0)
    80006078:	00065c63          	bgez	a2,80006090 <__printf+0x278>
    8000607c:	f9040713          	addi	a4,s0,-112
    80006080:	00f70733          	add	a4,a4,a5
    80006084:	02d00693          	li	a3,45
    80006088:	fed70823          	sb	a3,-16(a4)
    8000608c:	00078c93          	mv	s9,a5
    80006090:	f8040793          	addi	a5,s0,-128
    80006094:	01978cb3          	add	s9,a5,s9
    80006098:	f7f40d13          	addi	s10,s0,-129
    8000609c:	000cc503          	lbu	a0,0(s9)
    800060a0:	fffc8c93          	addi	s9,s9,-1
    800060a4:	00000097          	auipc	ra,0x0
    800060a8:	b90080e7          	jalr	-1136(ra) # 80005c34 <consputc>
    800060ac:	ffac98e3          	bne	s9,s10,8000609c <__printf+0x284>
    800060b0:	00094503          	lbu	a0,0(s2)
    800060b4:	e00514e3          	bnez	a0,80005ebc <__printf+0xa4>
    800060b8:	1a0c1663          	bnez	s8,80006264 <__printf+0x44c>
    800060bc:	08813083          	ld	ra,136(sp)
    800060c0:	08013403          	ld	s0,128(sp)
    800060c4:	07813483          	ld	s1,120(sp)
    800060c8:	07013903          	ld	s2,112(sp)
    800060cc:	06813983          	ld	s3,104(sp)
    800060d0:	06013a03          	ld	s4,96(sp)
    800060d4:	05813a83          	ld	s5,88(sp)
    800060d8:	05013b03          	ld	s6,80(sp)
    800060dc:	04813b83          	ld	s7,72(sp)
    800060e0:	04013c03          	ld	s8,64(sp)
    800060e4:	03813c83          	ld	s9,56(sp)
    800060e8:	03013d03          	ld	s10,48(sp)
    800060ec:	02813d83          	ld	s11,40(sp)
    800060f0:	0d010113          	addi	sp,sp,208
    800060f4:	00008067          	ret
    800060f8:	07300713          	li	a4,115
    800060fc:	1ce78a63          	beq	a5,a4,800062d0 <__printf+0x4b8>
    80006100:	07800713          	li	a4,120
    80006104:	1ee79e63          	bne	a5,a4,80006300 <__printf+0x4e8>
    80006108:	f7843783          	ld	a5,-136(s0)
    8000610c:	0007a703          	lw	a4,0(a5)
    80006110:	00878793          	addi	a5,a5,8
    80006114:	f6f43c23          	sd	a5,-136(s0)
    80006118:	28074263          	bltz	a4,8000639c <__printf+0x584>
    8000611c:	00002d97          	auipc	s11,0x2
    80006120:	59cd8d93          	addi	s11,s11,1436 # 800086b8 <digits>
    80006124:	00f77793          	andi	a5,a4,15
    80006128:	00fd87b3          	add	a5,s11,a5
    8000612c:	0007c683          	lbu	a3,0(a5)
    80006130:	00f00613          	li	a2,15
    80006134:	0007079b          	sext.w	a5,a4
    80006138:	f8d40023          	sb	a3,-128(s0)
    8000613c:	0047559b          	srliw	a1,a4,0x4
    80006140:	0047569b          	srliw	a3,a4,0x4
    80006144:	00000c93          	li	s9,0
    80006148:	0ee65063          	bge	a2,a4,80006228 <__printf+0x410>
    8000614c:	00f6f693          	andi	a3,a3,15
    80006150:	00dd86b3          	add	a3,s11,a3
    80006154:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006158:	0087d79b          	srliw	a5,a5,0x8
    8000615c:	00100c93          	li	s9,1
    80006160:	f8d400a3          	sb	a3,-127(s0)
    80006164:	0cb67263          	bgeu	a2,a1,80006228 <__printf+0x410>
    80006168:	00f7f693          	andi	a3,a5,15
    8000616c:	00dd86b3          	add	a3,s11,a3
    80006170:	0006c583          	lbu	a1,0(a3)
    80006174:	00f00613          	li	a2,15
    80006178:	0047d69b          	srliw	a3,a5,0x4
    8000617c:	f8b40123          	sb	a1,-126(s0)
    80006180:	0047d593          	srli	a1,a5,0x4
    80006184:	28f67e63          	bgeu	a2,a5,80006420 <__printf+0x608>
    80006188:	00f6f693          	andi	a3,a3,15
    8000618c:	00dd86b3          	add	a3,s11,a3
    80006190:	0006c503          	lbu	a0,0(a3)
    80006194:	0087d813          	srli	a6,a5,0x8
    80006198:	0087d69b          	srliw	a3,a5,0x8
    8000619c:	f8a401a3          	sb	a0,-125(s0)
    800061a0:	28b67663          	bgeu	a2,a1,8000642c <__printf+0x614>
    800061a4:	00f6f693          	andi	a3,a3,15
    800061a8:	00dd86b3          	add	a3,s11,a3
    800061ac:	0006c583          	lbu	a1,0(a3)
    800061b0:	00c7d513          	srli	a0,a5,0xc
    800061b4:	00c7d69b          	srliw	a3,a5,0xc
    800061b8:	f8b40223          	sb	a1,-124(s0)
    800061bc:	29067a63          	bgeu	a2,a6,80006450 <__printf+0x638>
    800061c0:	00f6f693          	andi	a3,a3,15
    800061c4:	00dd86b3          	add	a3,s11,a3
    800061c8:	0006c583          	lbu	a1,0(a3)
    800061cc:	0107d813          	srli	a6,a5,0x10
    800061d0:	0107d69b          	srliw	a3,a5,0x10
    800061d4:	f8b402a3          	sb	a1,-123(s0)
    800061d8:	28a67263          	bgeu	a2,a0,8000645c <__printf+0x644>
    800061dc:	00f6f693          	andi	a3,a3,15
    800061e0:	00dd86b3          	add	a3,s11,a3
    800061e4:	0006c683          	lbu	a3,0(a3)
    800061e8:	0147d79b          	srliw	a5,a5,0x14
    800061ec:	f8d40323          	sb	a3,-122(s0)
    800061f0:	21067663          	bgeu	a2,a6,800063fc <__printf+0x5e4>
    800061f4:	02079793          	slli	a5,a5,0x20
    800061f8:	0207d793          	srli	a5,a5,0x20
    800061fc:	00fd8db3          	add	s11,s11,a5
    80006200:	000dc683          	lbu	a3,0(s11)
    80006204:	00800793          	li	a5,8
    80006208:	00700c93          	li	s9,7
    8000620c:	f8d403a3          	sb	a3,-121(s0)
    80006210:	00075c63          	bgez	a4,80006228 <__printf+0x410>
    80006214:	f9040713          	addi	a4,s0,-112
    80006218:	00f70733          	add	a4,a4,a5
    8000621c:	02d00693          	li	a3,45
    80006220:	fed70823          	sb	a3,-16(a4)
    80006224:	00078c93          	mv	s9,a5
    80006228:	f8040793          	addi	a5,s0,-128
    8000622c:	01978cb3          	add	s9,a5,s9
    80006230:	f7f40d13          	addi	s10,s0,-129
    80006234:	000cc503          	lbu	a0,0(s9)
    80006238:	fffc8c93          	addi	s9,s9,-1
    8000623c:	00000097          	auipc	ra,0x0
    80006240:	9f8080e7          	jalr	-1544(ra) # 80005c34 <consputc>
    80006244:	ff9d18e3          	bne	s10,s9,80006234 <__printf+0x41c>
    80006248:	0100006f          	j	80006258 <__printf+0x440>
    8000624c:	00000097          	auipc	ra,0x0
    80006250:	9e8080e7          	jalr	-1560(ra) # 80005c34 <consputc>
    80006254:	000c8493          	mv	s1,s9
    80006258:	00094503          	lbu	a0,0(s2)
    8000625c:	c60510e3          	bnez	a0,80005ebc <__printf+0xa4>
    80006260:	e40c0ee3          	beqz	s8,800060bc <__printf+0x2a4>
    80006264:	00005517          	auipc	a0,0x5
    80006268:	f6c50513          	addi	a0,a0,-148 # 8000b1d0 <pr>
    8000626c:	00001097          	auipc	ra,0x1
    80006270:	94c080e7          	jalr	-1716(ra) # 80006bb8 <release>
    80006274:	e49ff06f          	j	800060bc <__printf+0x2a4>
    80006278:	f7843783          	ld	a5,-136(s0)
    8000627c:	03000513          	li	a0,48
    80006280:	01000d13          	li	s10,16
    80006284:	00878713          	addi	a4,a5,8
    80006288:	0007bc83          	ld	s9,0(a5)
    8000628c:	f6e43c23          	sd	a4,-136(s0)
    80006290:	00000097          	auipc	ra,0x0
    80006294:	9a4080e7          	jalr	-1628(ra) # 80005c34 <consputc>
    80006298:	07800513          	li	a0,120
    8000629c:	00000097          	auipc	ra,0x0
    800062a0:	998080e7          	jalr	-1640(ra) # 80005c34 <consputc>
    800062a4:	00002d97          	auipc	s11,0x2
    800062a8:	414d8d93          	addi	s11,s11,1044 # 800086b8 <digits>
    800062ac:	03ccd793          	srli	a5,s9,0x3c
    800062b0:	00fd87b3          	add	a5,s11,a5
    800062b4:	0007c503          	lbu	a0,0(a5)
    800062b8:	fffd0d1b          	addiw	s10,s10,-1
    800062bc:	004c9c93          	slli	s9,s9,0x4
    800062c0:	00000097          	auipc	ra,0x0
    800062c4:	974080e7          	jalr	-1676(ra) # 80005c34 <consputc>
    800062c8:	fe0d12e3          	bnez	s10,800062ac <__printf+0x494>
    800062cc:	f8dff06f          	j	80006258 <__printf+0x440>
    800062d0:	f7843783          	ld	a5,-136(s0)
    800062d4:	0007bc83          	ld	s9,0(a5)
    800062d8:	00878793          	addi	a5,a5,8
    800062dc:	f6f43c23          	sd	a5,-136(s0)
    800062e0:	000c9a63          	bnez	s9,800062f4 <__printf+0x4dc>
    800062e4:	1080006f          	j	800063ec <__printf+0x5d4>
    800062e8:	001c8c93          	addi	s9,s9,1
    800062ec:	00000097          	auipc	ra,0x0
    800062f0:	948080e7          	jalr	-1720(ra) # 80005c34 <consputc>
    800062f4:	000cc503          	lbu	a0,0(s9)
    800062f8:	fe0518e3          	bnez	a0,800062e8 <__printf+0x4d0>
    800062fc:	f5dff06f          	j	80006258 <__printf+0x440>
    80006300:	02500513          	li	a0,37
    80006304:	00000097          	auipc	ra,0x0
    80006308:	930080e7          	jalr	-1744(ra) # 80005c34 <consputc>
    8000630c:	000c8513          	mv	a0,s9
    80006310:	00000097          	auipc	ra,0x0
    80006314:	924080e7          	jalr	-1756(ra) # 80005c34 <consputc>
    80006318:	f41ff06f          	j	80006258 <__printf+0x440>
    8000631c:	02500513          	li	a0,37
    80006320:	00000097          	auipc	ra,0x0
    80006324:	914080e7          	jalr	-1772(ra) # 80005c34 <consputc>
    80006328:	f31ff06f          	j	80006258 <__printf+0x440>
    8000632c:	00030513          	mv	a0,t1
    80006330:	00000097          	auipc	ra,0x0
    80006334:	7bc080e7          	jalr	1980(ra) # 80006aec <acquire>
    80006338:	b4dff06f          	j	80005e84 <__printf+0x6c>
    8000633c:	40c0053b          	negw	a0,a2
    80006340:	00a00713          	li	a4,10
    80006344:	02e576bb          	remuw	a3,a0,a4
    80006348:	00002d97          	auipc	s11,0x2
    8000634c:	370d8d93          	addi	s11,s11,880 # 800086b8 <digits>
    80006350:	ff700593          	li	a1,-9
    80006354:	02069693          	slli	a3,a3,0x20
    80006358:	0206d693          	srli	a3,a3,0x20
    8000635c:	00dd86b3          	add	a3,s11,a3
    80006360:	0006c683          	lbu	a3,0(a3)
    80006364:	02e557bb          	divuw	a5,a0,a4
    80006368:	f8d40023          	sb	a3,-128(s0)
    8000636c:	10b65e63          	bge	a2,a1,80006488 <__printf+0x670>
    80006370:	06300593          	li	a1,99
    80006374:	02e7f6bb          	remuw	a3,a5,a4
    80006378:	02069693          	slli	a3,a3,0x20
    8000637c:	0206d693          	srli	a3,a3,0x20
    80006380:	00dd86b3          	add	a3,s11,a3
    80006384:	0006c683          	lbu	a3,0(a3)
    80006388:	02e7d73b          	divuw	a4,a5,a4
    8000638c:	00200793          	li	a5,2
    80006390:	f8d400a3          	sb	a3,-127(s0)
    80006394:	bca5ece3          	bltu	a1,a0,80005f6c <__printf+0x154>
    80006398:	ce5ff06f          	j	8000607c <__printf+0x264>
    8000639c:	40e007bb          	negw	a5,a4
    800063a0:	00002d97          	auipc	s11,0x2
    800063a4:	318d8d93          	addi	s11,s11,792 # 800086b8 <digits>
    800063a8:	00f7f693          	andi	a3,a5,15
    800063ac:	00dd86b3          	add	a3,s11,a3
    800063b0:	0006c583          	lbu	a1,0(a3)
    800063b4:	ff100613          	li	a2,-15
    800063b8:	0047d69b          	srliw	a3,a5,0x4
    800063bc:	f8b40023          	sb	a1,-128(s0)
    800063c0:	0047d59b          	srliw	a1,a5,0x4
    800063c4:	0ac75e63          	bge	a4,a2,80006480 <__printf+0x668>
    800063c8:	00f6f693          	andi	a3,a3,15
    800063cc:	00dd86b3          	add	a3,s11,a3
    800063d0:	0006c603          	lbu	a2,0(a3)
    800063d4:	00f00693          	li	a3,15
    800063d8:	0087d79b          	srliw	a5,a5,0x8
    800063dc:	f8c400a3          	sb	a2,-127(s0)
    800063e0:	d8b6e4e3          	bltu	a3,a1,80006168 <__printf+0x350>
    800063e4:	00200793          	li	a5,2
    800063e8:	e2dff06f          	j	80006214 <__printf+0x3fc>
    800063ec:	00002c97          	auipc	s9,0x2
    800063f0:	2acc8c93          	addi	s9,s9,684 # 80008698 <CONSOLE_STATUS+0x688>
    800063f4:	02800513          	li	a0,40
    800063f8:	ef1ff06f          	j	800062e8 <__printf+0x4d0>
    800063fc:	00700793          	li	a5,7
    80006400:	00600c93          	li	s9,6
    80006404:	e0dff06f          	j	80006210 <__printf+0x3f8>
    80006408:	00700793          	li	a5,7
    8000640c:	00600c93          	li	s9,6
    80006410:	c69ff06f          	j	80006078 <__printf+0x260>
    80006414:	00300793          	li	a5,3
    80006418:	00200c93          	li	s9,2
    8000641c:	c5dff06f          	j	80006078 <__printf+0x260>
    80006420:	00300793          	li	a5,3
    80006424:	00200c93          	li	s9,2
    80006428:	de9ff06f          	j	80006210 <__printf+0x3f8>
    8000642c:	00400793          	li	a5,4
    80006430:	00300c93          	li	s9,3
    80006434:	dddff06f          	j	80006210 <__printf+0x3f8>
    80006438:	00400793          	li	a5,4
    8000643c:	00300c93          	li	s9,3
    80006440:	c39ff06f          	j	80006078 <__printf+0x260>
    80006444:	00500793          	li	a5,5
    80006448:	00400c93          	li	s9,4
    8000644c:	c2dff06f          	j	80006078 <__printf+0x260>
    80006450:	00500793          	li	a5,5
    80006454:	00400c93          	li	s9,4
    80006458:	db9ff06f          	j	80006210 <__printf+0x3f8>
    8000645c:	00600793          	li	a5,6
    80006460:	00500c93          	li	s9,5
    80006464:	dadff06f          	j	80006210 <__printf+0x3f8>
    80006468:	00600793          	li	a5,6
    8000646c:	00500c93          	li	s9,5
    80006470:	c09ff06f          	j	80006078 <__printf+0x260>
    80006474:	00800793          	li	a5,8
    80006478:	00700c93          	li	s9,7
    8000647c:	bfdff06f          	j	80006078 <__printf+0x260>
    80006480:	00100793          	li	a5,1
    80006484:	d91ff06f          	j	80006214 <__printf+0x3fc>
    80006488:	00100793          	li	a5,1
    8000648c:	bf1ff06f          	j	8000607c <__printf+0x264>
    80006490:	00900793          	li	a5,9
    80006494:	00800c93          	li	s9,8
    80006498:	be1ff06f          	j	80006078 <__printf+0x260>
    8000649c:	00002517          	auipc	a0,0x2
    800064a0:	20450513          	addi	a0,a0,516 # 800086a0 <CONSOLE_STATUS+0x690>
    800064a4:	00000097          	auipc	ra,0x0
    800064a8:	918080e7          	jalr	-1768(ra) # 80005dbc <panic>

00000000800064ac <printfinit>:
    800064ac:	fe010113          	addi	sp,sp,-32
    800064b0:	00813823          	sd	s0,16(sp)
    800064b4:	00913423          	sd	s1,8(sp)
    800064b8:	00113c23          	sd	ra,24(sp)
    800064bc:	02010413          	addi	s0,sp,32
    800064c0:	00005497          	auipc	s1,0x5
    800064c4:	d1048493          	addi	s1,s1,-752 # 8000b1d0 <pr>
    800064c8:	00048513          	mv	a0,s1
    800064cc:	00002597          	auipc	a1,0x2
    800064d0:	1e458593          	addi	a1,a1,484 # 800086b0 <CONSOLE_STATUS+0x6a0>
    800064d4:	00000097          	auipc	ra,0x0
    800064d8:	5f4080e7          	jalr	1524(ra) # 80006ac8 <initlock>
    800064dc:	01813083          	ld	ra,24(sp)
    800064e0:	01013403          	ld	s0,16(sp)
    800064e4:	0004ac23          	sw	zero,24(s1)
    800064e8:	00813483          	ld	s1,8(sp)
    800064ec:	02010113          	addi	sp,sp,32
    800064f0:	00008067          	ret

00000000800064f4 <uartinit>:
    800064f4:	ff010113          	addi	sp,sp,-16
    800064f8:	00813423          	sd	s0,8(sp)
    800064fc:	01010413          	addi	s0,sp,16
    80006500:	100007b7          	lui	a5,0x10000
    80006504:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006508:	f8000713          	li	a4,-128
    8000650c:	00e781a3          	sb	a4,3(a5)
    80006510:	00300713          	li	a4,3
    80006514:	00e78023          	sb	a4,0(a5)
    80006518:	000780a3          	sb	zero,1(a5)
    8000651c:	00e781a3          	sb	a4,3(a5)
    80006520:	00700693          	li	a3,7
    80006524:	00d78123          	sb	a3,2(a5)
    80006528:	00e780a3          	sb	a4,1(a5)
    8000652c:	00813403          	ld	s0,8(sp)
    80006530:	01010113          	addi	sp,sp,16
    80006534:	00008067          	ret

0000000080006538 <uartputc>:
    80006538:	00004797          	auipc	a5,0x4
    8000653c:	9f07a783          	lw	a5,-1552(a5) # 80009f28 <panicked>
    80006540:	00078463          	beqz	a5,80006548 <uartputc+0x10>
    80006544:	0000006f          	j	80006544 <uartputc+0xc>
    80006548:	fd010113          	addi	sp,sp,-48
    8000654c:	02813023          	sd	s0,32(sp)
    80006550:	00913c23          	sd	s1,24(sp)
    80006554:	01213823          	sd	s2,16(sp)
    80006558:	01313423          	sd	s3,8(sp)
    8000655c:	02113423          	sd	ra,40(sp)
    80006560:	03010413          	addi	s0,sp,48
    80006564:	00004917          	auipc	s2,0x4
    80006568:	9cc90913          	addi	s2,s2,-1588 # 80009f30 <uart_tx_r>
    8000656c:	00093783          	ld	a5,0(s2)
    80006570:	00004497          	auipc	s1,0x4
    80006574:	9c848493          	addi	s1,s1,-1592 # 80009f38 <uart_tx_w>
    80006578:	0004b703          	ld	a4,0(s1)
    8000657c:	02078693          	addi	a3,a5,32
    80006580:	00050993          	mv	s3,a0
    80006584:	02e69c63          	bne	a3,a4,800065bc <uartputc+0x84>
    80006588:	00001097          	auipc	ra,0x1
    8000658c:	834080e7          	jalr	-1996(ra) # 80006dbc <push_on>
    80006590:	00093783          	ld	a5,0(s2)
    80006594:	0004b703          	ld	a4,0(s1)
    80006598:	02078793          	addi	a5,a5,32
    8000659c:	00e79463          	bne	a5,a4,800065a4 <uartputc+0x6c>
    800065a0:	0000006f          	j	800065a0 <uartputc+0x68>
    800065a4:	00001097          	auipc	ra,0x1
    800065a8:	88c080e7          	jalr	-1908(ra) # 80006e30 <pop_on>
    800065ac:	00093783          	ld	a5,0(s2)
    800065b0:	0004b703          	ld	a4,0(s1)
    800065b4:	02078693          	addi	a3,a5,32
    800065b8:	fce688e3          	beq	a3,a4,80006588 <uartputc+0x50>
    800065bc:	01f77693          	andi	a3,a4,31
    800065c0:	00005597          	auipc	a1,0x5
    800065c4:	c3058593          	addi	a1,a1,-976 # 8000b1f0 <uart_tx_buf>
    800065c8:	00d586b3          	add	a3,a1,a3
    800065cc:	00170713          	addi	a4,a4,1
    800065d0:	01368023          	sb	s3,0(a3)
    800065d4:	00e4b023          	sd	a4,0(s1)
    800065d8:	10000637          	lui	a2,0x10000
    800065dc:	02f71063          	bne	a4,a5,800065fc <uartputc+0xc4>
    800065e0:	0340006f          	j	80006614 <uartputc+0xdc>
    800065e4:	00074703          	lbu	a4,0(a4)
    800065e8:	00f93023          	sd	a5,0(s2)
    800065ec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800065f0:	00093783          	ld	a5,0(s2)
    800065f4:	0004b703          	ld	a4,0(s1)
    800065f8:	00f70e63          	beq	a4,a5,80006614 <uartputc+0xdc>
    800065fc:	00564683          	lbu	a3,5(a2)
    80006600:	01f7f713          	andi	a4,a5,31
    80006604:	00e58733          	add	a4,a1,a4
    80006608:	0206f693          	andi	a3,a3,32
    8000660c:	00178793          	addi	a5,a5,1
    80006610:	fc069ae3          	bnez	a3,800065e4 <uartputc+0xac>
    80006614:	02813083          	ld	ra,40(sp)
    80006618:	02013403          	ld	s0,32(sp)
    8000661c:	01813483          	ld	s1,24(sp)
    80006620:	01013903          	ld	s2,16(sp)
    80006624:	00813983          	ld	s3,8(sp)
    80006628:	03010113          	addi	sp,sp,48
    8000662c:	00008067          	ret

0000000080006630 <uartputc_sync>:
    80006630:	ff010113          	addi	sp,sp,-16
    80006634:	00813423          	sd	s0,8(sp)
    80006638:	01010413          	addi	s0,sp,16
    8000663c:	00004717          	auipc	a4,0x4
    80006640:	8ec72703          	lw	a4,-1812(a4) # 80009f28 <panicked>
    80006644:	02071663          	bnez	a4,80006670 <uartputc_sync+0x40>
    80006648:	00050793          	mv	a5,a0
    8000664c:	100006b7          	lui	a3,0x10000
    80006650:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006654:	02077713          	andi	a4,a4,32
    80006658:	fe070ce3          	beqz	a4,80006650 <uartputc_sync+0x20>
    8000665c:	0ff7f793          	andi	a5,a5,255
    80006660:	00f68023          	sb	a5,0(a3)
    80006664:	00813403          	ld	s0,8(sp)
    80006668:	01010113          	addi	sp,sp,16
    8000666c:	00008067          	ret
    80006670:	0000006f          	j	80006670 <uartputc_sync+0x40>

0000000080006674 <uartstart>:
    80006674:	ff010113          	addi	sp,sp,-16
    80006678:	00813423          	sd	s0,8(sp)
    8000667c:	01010413          	addi	s0,sp,16
    80006680:	00004617          	auipc	a2,0x4
    80006684:	8b060613          	addi	a2,a2,-1872 # 80009f30 <uart_tx_r>
    80006688:	00004517          	auipc	a0,0x4
    8000668c:	8b050513          	addi	a0,a0,-1872 # 80009f38 <uart_tx_w>
    80006690:	00063783          	ld	a5,0(a2)
    80006694:	00053703          	ld	a4,0(a0)
    80006698:	04f70263          	beq	a4,a5,800066dc <uartstart+0x68>
    8000669c:	100005b7          	lui	a1,0x10000
    800066a0:	00005817          	auipc	a6,0x5
    800066a4:	b5080813          	addi	a6,a6,-1200 # 8000b1f0 <uart_tx_buf>
    800066a8:	01c0006f          	j	800066c4 <uartstart+0x50>
    800066ac:	0006c703          	lbu	a4,0(a3)
    800066b0:	00f63023          	sd	a5,0(a2)
    800066b4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800066b8:	00063783          	ld	a5,0(a2)
    800066bc:	00053703          	ld	a4,0(a0)
    800066c0:	00f70e63          	beq	a4,a5,800066dc <uartstart+0x68>
    800066c4:	01f7f713          	andi	a4,a5,31
    800066c8:	00e806b3          	add	a3,a6,a4
    800066cc:	0055c703          	lbu	a4,5(a1)
    800066d0:	00178793          	addi	a5,a5,1
    800066d4:	02077713          	andi	a4,a4,32
    800066d8:	fc071ae3          	bnez	a4,800066ac <uartstart+0x38>
    800066dc:	00813403          	ld	s0,8(sp)
    800066e0:	01010113          	addi	sp,sp,16
    800066e4:	00008067          	ret

00000000800066e8 <uartgetc>:
    800066e8:	ff010113          	addi	sp,sp,-16
    800066ec:	00813423          	sd	s0,8(sp)
    800066f0:	01010413          	addi	s0,sp,16
    800066f4:	10000737          	lui	a4,0x10000
    800066f8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800066fc:	0017f793          	andi	a5,a5,1
    80006700:	00078c63          	beqz	a5,80006718 <uartgetc+0x30>
    80006704:	00074503          	lbu	a0,0(a4)
    80006708:	0ff57513          	andi	a0,a0,255
    8000670c:	00813403          	ld	s0,8(sp)
    80006710:	01010113          	addi	sp,sp,16
    80006714:	00008067          	ret
    80006718:	fff00513          	li	a0,-1
    8000671c:	ff1ff06f          	j	8000670c <uartgetc+0x24>

0000000080006720 <uartintr>:
    80006720:	100007b7          	lui	a5,0x10000
    80006724:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006728:	0017f793          	andi	a5,a5,1
    8000672c:	0a078463          	beqz	a5,800067d4 <uartintr+0xb4>
    80006730:	fe010113          	addi	sp,sp,-32
    80006734:	00813823          	sd	s0,16(sp)
    80006738:	00913423          	sd	s1,8(sp)
    8000673c:	00113c23          	sd	ra,24(sp)
    80006740:	02010413          	addi	s0,sp,32
    80006744:	100004b7          	lui	s1,0x10000
    80006748:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000674c:	0ff57513          	andi	a0,a0,255
    80006750:	fffff097          	auipc	ra,0xfffff
    80006754:	534080e7          	jalr	1332(ra) # 80005c84 <consoleintr>
    80006758:	0054c783          	lbu	a5,5(s1)
    8000675c:	0017f793          	andi	a5,a5,1
    80006760:	fe0794e3          	bnez	a5,80006748 <uartintr+0x28>
    80006764:	00003617          	auipc	a2,0x3
    80006768:	7cc60613          	addi	a2,a2,1996 # 80009f30 <uart_tx_r>
    8000676c:	00003517          	auipc	a0,0x3
    80006770:	7cc50513          	addi	a0,a0,1996 # 80009f38 <uart_tx_w>
    80006774:	00063783          	ld	a5,0(a2)
    80006778:	00053703          	ld	a4,0(a0)
    8000677c:	04f70263          	beq	a4,a5,800067c0 <uartintr+0xa0>
    80006780:	100005b7          	lui	a1,0x10000
    80006784:	00005817          	auipc	a6,0x5
    80006788:	a6c80813          	addi	a6,a6,-1428 # 8000b1f0 <uart_tx_buf>
    8000678c:	01c0006f          	j	800067a8 <uartintr+0x88>
    80006790:	0006c703          	lbu	a4,0(a3)
    80006794:	00f63023          	sd	a5,0(a2)
    80006798:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000679c:	00063783          	ld	a5,0(a2)
    800067a0:	00053703          	ld	a4,0(a0)
    800067a4:	00f70e63          	beq	a4,a5,800067c0 <uartintr+0xa0>
    800067a8:	01f7f713          	andi	a4,a5,31
    800067ac:	00e806b3          	add	a3,a6,a4
    800067b0:	0055c703          	lbu	a4,5(a1)
    800067b4:	00178793          	addi	a5,a5,1
    800067b8:	02077713          	andi	a4,a4,32
    800067bc:	fc071ae3          	bnez	a4,80006790 <uartintr+0x70>
    800067c0:	01813083          	ld	ra,24(sp)
    800067c4:	01013403          	ld	s0,16(sp)
    800067c8:	00813483          	ld	s1,8(sp)
    800067cc:	02010113          	addi	sp,sp,32
    800067d0:	00008067          	ret
    800067d4:	00003617          	auipc	a2,0x3
    800067d8:	75c60613          	addi	a2,a2,1884 # 80009f30 <uart_tx_r>
    800067dc:	00003517          	auipc	a0,0x3
    800067e0:	75c50513          	addi	a0,a0,1884 # 80009f38 <uart_tx_w>
    800067e4:	00063783          	ld	a5,0(a2)
    800067e8:	00053703          	ld	a4,0(a0)
    800067ec:	04f70263          	beq	a4,a5,80006830 <uartintr+0x110>
    800067f0:	100005b7          	lui	a1,0x10000
    800067f4:	00005817          	auipc	a6,0x5
    800067f8:	9fc80813          	addi	a6,a6,-1540 # 8000b1f0 <uart_tx_buf>
    800067fc:	01c0006f          	j	80006818 <uartintr+0xf8>
    80006800:	0006c703          	lbu	a4,0(a3)
    80006804:	00f63023          	sd	a5,0(a2)
    80006808:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000680c:	00063783          	ld	a5,0(a2)
    80006810:	00053703          	ld	a4,0(a0)
    80006814:	02f70063          	beq	a4,a5,80006834 <uartintr+0x114>
    80006818:	01f7f713          	andi	a4,a5,31
    8000681c:	00e806b3          	add	a3,a6,a4
    80006820:	0055c703          	lbu	a4,5(a1)
    80006824:	00178793          	addi	a5,a5,1
    80006828:	02077713          	andi	a4,a4,32
    8000682c:	fc071ae3          	bnez	a4,80006800 <uartintr+0xe0>
    80006830:	00008067          	ret
    80006834:	00008067          	ret

0000000080006838 <kinit>:
    80006838:	fc010113          	addi	sp,sp,-64
    8000683c:	02913423          	sd	s1,40(sp)
    80006840:	fffff7b7          	lui	a5,0xfffff
    80006844:	00006497          	auipc	s1,0x6
    80006848:	9cb48493          	addi	s1,s1,-1589 # 8000c20f <end+0xfff>
    8000684c:	02813823          	sd	s0,48(sp)
    80006850:	01313c23          	sd	s3,24(sp)
    80006854:	00f4f4b3          	and	s1,s1,a5
    80006858:	02113c23          	sd	ra,56(sp)
    8000685c:	03213023          	sd	s2,32(sp)
    80006860:	01413823          	sd	s4,16(sp)
    80006864:	01513423          	sd	s5,8(sp)
    80006868:	04010413          	addi	s0,sp,64
    8000686c:	000017b7          	lui	a5,0x1
    80006870:	01100993          	li	s3,17
    80006874:	00f487b3          	add	a5,s1,a5
    80006878:	01b99993          	slli	s3,s3,0x1b
    8000687c:	06f9e063          	bltu	s3,a5,800068dc <kinit+0xa4>
    80006880:	00005a97          	auipc	s5,0x5
    80006884:	990a8a93          	addi	s5,s5,-1648 # 8000b210 <end>
    80006888:	0754ec63          	bltu	s1,s5,80006900 <kinit+0xc8>
    8000688c:	0734fa63          	bgeu	s1,s3,80006900 <kinit+0xc8>
    80006890:	00088a37          	lui	s4,0x88
    80006894:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006898:	00003917          	auipc	s2,0x3
    8000689c:	6a890913          	addi	s2,s2,1704 # 80009f40 <kmem>
    800068a0:	00ca1a13          	slli	s4,s4,0xc
    800068a4:	0140006f          	j	800068b8 <kinit+0x80>
    800068a8:	000017b7          	lui	a5,0x1
    800068ac:	00f484b3          	add	s1,s1,a5
    800068b0:	0554e863          	bltu	s1,s5,80006900 <kinit+0xc8>
    800068b4:	0534f663          	bgeu	s1,s3,80006900 <kinit+0xc8>
    800068b8:	00001637          	lui	a2,0x1
    800068bc:	00100593          	li	a1,1
    800068c0:	00048513          	mv	a0,s1
    800068c4:	00000097          	auipc	ra,0x0
    800068c8:	5e4080e7          	jalr	1508(ra) # 80006ea8 <__memset>
    800068cc:	00093783          	ld	a5,0(s2)
    800068d0:	00f4b023          	sd	a5,0(s1)
    800068d4:	00993023          	sd	s1,0(s2)
    800068d8:	fd4498e3          	bne	s1,s4,800068a8 <kinit+0x70>
    800068dc:	03813083          	ld	ra,56(sp)
    800068e0:	03013403          	ld	s0,48(sp)
    800068e4:	02813483          	ld	s1,40(sp)
    800068e8:	02013903          	ld	s2,32(sp)
    800068ec:	01813983          	ld	s3,24(sp)
    800068f0:	01013a03          	ld	s4,16(sp)
    800068f4:	00813a83          	ld	s5,8(sp)
    800068f8:	04010113          	addi	sp,sp,64
    800068fc:	00008067          	ret
    80006900:	00002517          	auipc	a0,0x2
    80006904:	dd050513          	addi	a0,a0,-560 # 800086d0 <digits+0x18>
    80006908:	fffff097          	auipc	ra,0xfffff
    8000690c:	4b4080e7          	jalr	1204(ra) # 80005dbc <panic>

0000000080006910 <freerange>:
    80006910:	fc010113          	addi	sp,sp,-64
    80006914:	000017b7          	lui	a5,0x1
    80006918:	02913423          	sd	s1,40(sp)
    8000691c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006920:	009504b3          	add	s1,a0,s1
    80006924:	fffff537          	lui	a0,0xfffff
    80006928:	02813823          	sd	s0,48(sp)
    8000692c:	02113c23          	sd	ra,56(sp)
    80006930:	03213023          	sd	s2,32(sp)
    80006934:	01313c23          	sd	s3,24(sp)
    80006938:	01413823          	sd	s4,16(sp)
    8000693c:	01513423          	sd	s5,8(sp)
    80006940:	01613023          	sd	s6,0(sp)
    80006944:	04010413          	addi	s0,sp,64
    80006948:	00a4f4b3          	and	s1,s1,a0
    8000694c:	00f487b3          	add	a5,s1,a5
    80006950:	06f5e463          	bltu	a1,a5,800069b8 <freerange+0xa8>
    80006954:	00005a97          	auipc	s5,0x5
    80006958:	8bca8a93          	addi	s5,s5,-1860 # 8000b210 <end>
    8000695c:	0954e263          	bltu	s1,s5,800069e0 <freerange+0xd0>
    80006960:	01100993          	li	s3,17
    80006964:	01b99993          	slli	s3,s3,0x1b
    80006968:	0734fc63          	bgeu	s1,s3,800069e0 <freerange+0xd0>
    8000696c:	00058a13          	mv	s4,a1
    80006970:	00003917          	auipc	s2,0x3
    80006974:	5d090913          	addi	s2,s2,1488 # 80009f40 <kmem>
    80006978:	00002b37          	lui	s6,0x2
    8000697c:	0140006f          	j	80006990 <freerange+0x80>
    80006980:	000017b7          	lui	a5,0x1
    80006984:	00f484b3          	add	s1,s1,a5
    80006988:	0554ec63          	bltu	s1,s5,800069e0 <freerange+0xd0>
    8000698c:	0534fa63          	bgeu	s1,s3,800069e0 <freerange+0xd0>
    80006990:	00001637          	lui	a2,0x1
    80006994:	00100593          	li	a1,1
    80006998:	00048513          	mv	a0,s1
    8000699c:	00000097          	auipc	ra,0x0
    800069a0:	50c080e7          	jalr	1292(ra) # 80006ea8 <__memset>
    800069a4:	00093703          	ld	a4,0(s2)
    800069a8:	016487b3          	add	a5,s1,s6
    800069ac:	00e4b023          	sd	a4,0(s1)
    800069b0:	00993023          	sd	s1,0(s2)
    800069b4:	fcfa76e3          	bgeu	s4,a5,80006980 <freerange+0x70>
    800069b8:	03813083          	ld	ra,56(sp)
    800069bc:	03013403          	ld	s0,48(sp)
    800069c0:	02813483          	ld	s1,40(sp)
    800069c4:	02013903          	ld	s2,32(sp)
    800069c8:	01813983          	ld	s3,24(sp)
    800069cc:	01013a03          	ld	s4,16(sp)
    800069d0:	00813a83          	ld	s5,8(sp)
    800069d4:	00013b03          	ld	s6,0(sp)
    800069d8:	04010113          	addi	sp,sp,64
    800069dc:	00008067          	ret
    800069e0:	00002517          	auipc	a0,0x2
    800069e4:	cf050513          	addi	a0,a0,-784 # 800086d0 <digits+0x18>
    800069e8:	fffff097          	auipc	ra,0xfffff
    800069ec:	3d4080e7          	jalr	980(ra) # 80005dbc <panic>

00000000800069f0 <kfree>:
    800069f0:	fe010113          	addi	sp,sp,-32
    800069f4:	00813823          	sd	s0,16(sp)
    800069f8:	00113c23          	sd	ra,24(sp)
    800069fc:	00913423          	sd	s1,8(sp)
    80006a00:	02010413          	addi	s0,sp,32
    80006a04:	03451793          	slli	a5,a0,0x34
    80006a08:	04079c63          	bnez	a5,80006a60 <kfree+0x70>
    80006a0c:	00005797          	auipc	a5,0x5
    80006a10:	80478793          	addi	a5,a5,-2044 # 8000b210 <end>
    80006a14:	00050493          	mv	s1,a0
    80006a18:	04f56463          	bltu	a0,a5,80006a60 <kfree+0x70>
    80006a1c:	01100793          	li	a5,17
    80006a20:	01b79793          	slli	a5,a5,0x1b
    80006a24:	02f57e63          	bgeu	a0,a5,80006a60 <kfree+0x70>
    80006a28:	00001637          	lui	a2,0x1
    80006a2c:	00100593          	li	a1,1
    80006a30:	00000097          	auipc	ra,0x0
    80006a34:	478080e7          	jalr	1144(ra) # 80006ea8 <__memset>
    80006a38:	00003797          	auipc	a5,0x3
    80006a3c:	50878793          	addi	a5,a5,1288 # 80009f40 <kmem>
    80006a40:	0007b703          	ld	a4,0(a5)
    80006a44:	01813083          	ld	ra,24(sp)
    80006a48:	01013403          	ld	s0,16(sp)
    80006a4c:	00e4b023          	sd	a4,0(s1)
    80006a50:	0097b023          	sd	s1,0(a5)
    80006a54:	00813483          	ld	s1,8(sp)
    80006a58:	02010113          	addi	sp,sp,32
    80006a5c:	00008067          	ret
    80006a60:	00002517          	auipc	a0,0x2
    80006a64:	c7050513          	addi	a0,a0,-912 # 800086d0 <digits+0x18>
    80006a68:	fffff097          	auipc	ra,0xfffff
    80006a6c:	354080e7          	jalr	852(ra) # 80005dbc <panic>

0000000080006a70 <kalloc>:
    80006a70:	fe010113          	addi	sp,sp,-32
    80006a74:	00813823          	sd	s0,16(sp)
    80006a78:	00913423          	sd	s1,8(sp)
    80006a7c:	00113c23          	sd	ra,24(sp)
    80006a80:	02010413          	addi	s0,sp,32
    80006a84:	00003797          	auipc	a5,0x3
    80006a88:	4bc78793          	addi	a5,a5,1212 # 80009f40 <kmem>
    80006a8c:	0007b483          	ld	s1,0(a5)
    80006a90:	02048063          	beqz	s1,80006ab0 <kalloc+0x40>
    80006a94:	0004b703          	ld	a4,0(s1)
    80006a98:	00001637          	lui	a2,0x1
    80006a9c:	00500593          	li	a1,5
    80006aa0:	00048513          	mv	a0,s1
    80006aa4:	00e7b023          	sd	a4,0(a5)
    80006aa8:	00000097          	auipc	ra,0x0
    80006aac:	400080e7          	jalr	1024(ra) # 80006ea8 <__memset>
    80006ab0:	01813083          	ld	ra,24(sp)
    80006ab4:	01013403          	ld	s0,16(sp)
    80006ab8:	00048513          	mv	a0,s1
    80006abc:	00813483          	ld	s1,8(sp)
    80006ac0:	02010113          	addi	sp,sp,32
    80006ac4:	00008067          	ret

0000000080006ac8 <initlock>:
    80006ac8:	ff010113          	addi	sp,sp,-16
    80006acc:	00813423          	sd	s0,8(sp)
    80006ad0:	01010413          	addi	s0,sp,16
    80006ad4:	00813403          	ld	s0,8(sp)
    80006ad8:	00b53423          	sd	a1,8(a0)
    80006adc:	00052023          	sw	zero,0(a0)
    80006ae0:	00053823          	sd	zero,16(a0)
    80006ae4:	01010113          	addi	sp,sp,16
    80006ae8:	00008067          	ret

0000000080006aec <acquire>:
    80006aec:	fe010113          	addi	sp,sp,-32
    80006af0:	00813823          	sd	s0,16(sp)
    80006af4:	00913423          	sd	s1,8(sp)
    80006af8:	00113c23          	sd	ra,24(sp)
    80006afc:	01213023          	sd	s2,0(sp)
    80006b00:	02010413          	addi	s0,sp,32
    80006b04:	00050493          	mv	s1,a0
    80006b08:	10002973          	csrr	s2,sstatus
    80006b0c:	100027f3          	csrr	a5,sstatus
    80006b10:	ffd7f793          	andi	a5,a5,-3
    80006b14:	10079073          	csrw	sstatus,a5
    80006b18:	fffff097          	auipc	ra,0xfffff
    80006b1c:	8e8080e7          	jalr	-1816(ra) # 80005400 <mycpu>
    80006b20:	07852783          	lw	a5,120(a0)
    80006b24:	06078e63          	beqz	a5,80006ba0 <acquire+0xb4>
    80006b28:	fffff097          	auipc	ra,0xfffff
    80006b2c:	8d8080e7          	jalr	-1832(ra) # 80005400 <mycpu>
    80006b30:	07852783          	lw	a5,120(a0)
    80006b34:	0004a703          	lw	a4,0(s1)
    80006b38:	0017879b          	addiw	a5,a5,1
    80006b3c:	06f52c23          	sw	a5,120(a0)
    80006b40:	04071063          	bnez	a4,80006b80 <acquire+0x94>
    80006b44:	00100713          	li	a4,1
    80006b48:	00070793          	mv	a5,a4
    80006b4c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006b50:	0007879b          	sext.w	a5,a5
    80006b54:	fe079ae3          	bnez	a5,80006b48 <acquire+0x5c>
    80006b58:	0ff0000f          	fence
    80006b5c:	fffff097          	auipc	ra,0xfffff
    80006b60:	8a4080e7          	jalr	-1884(ra) # 80005400 <mycpu>
    80006b64:	01813083          	ld	ra,24(sp)
    80006b68:	01013403          	ld	s0,16(sp)
    80006b6c:	00a4b823          	sd	a0,16(s1)
    80006b70:	00013903          	ld	s2,0(sp)
    80006b74:	00813483          	ld	s1,8(sp)
    80006b78:	02010113          	addi	sp,sp,32
    80006b7c:	00008067          	ret
    80006b80:	0104b903          	ld	s2,16(s1)
    80006b84:	fffff097          	auipc	ra,0xfffff
    80006b88:	87c080e7          	jalr	-1924(ra) # 80005400 <mycpu>
    80006b8c:	faa91ce3          	bne	s2,a0,80006b44 <acquire+0x58>
    80006b90:	00002517          	auipc	a0,0x2
    80006b94:	b4850513          	addi	a0,a0,-1208 # 800086d8 <digits+0x20>
    80006b98:	fffff097          	auipc	ra,0xfffff
    80006b9c:	224080e7          	jalr	548(ra) # 80005dbc <panic>
    80006ba0:	00195913          	srli	s2,s2,0x1
    80006ba4:	fffff097          	auipc	ra,0xfffff
    80006ba8:	85c080e7          	jalr	-1956(ra) # 80005400 <mycpu>
    80006bac:	00197913          	andi	s2,s2,1
    80006bb0:	07252e23          	sw	s2,124(a0)
    80006bb4:	f75ff06f          	j	80006b28 <acquire+0x3c>

0000000080006bb8 <release>:
    80006bb8:	fe010113          	addi	sp,sp,-32
    80006bbc:	00813823          	sd	s0,16(sp)
    80006bc0:	00113c23          	sd	ra,24(sp)
    80006bc4:	00913423          	sd	s1,8(sp)
    80006bc8:	01213023          	sd	s2,0(sp)
    80006bcc:	02010413          	addi	s0,sp,32
    80006bd0:	00052783          	lw	a5,0(a0)
    80006bd4:	00079a63          	bnez	a5,80006be8 <release+0x30>
    80006bd8:	00002517          	auipc	a0,0x2
    80006bdc:	b0850513          	addi	a0,a0,-1272 # 800086e0 <digits+0x28>
    80006be0:	fffff097          	auipc	ra,0xfffff
    80006be4:	1dc080e7          	jalr	476(ra) # 80005dbc <panic>
    80006be8:	01053903          	ld	s2,16(a0)
    80006bec:	00050493          	mv	s1,a0
    80006bf0:	fffff097          	auipc	ra,0xfffff
    80006bf4:	810080e7          	jalr	-2032(ra) # 80005400 <mycpu>
    80006bf8:	fea910e3          	bne	s2,a0,80006bd8 <release+0x20>
    80006bfc:	0004b823          	sd	zero,16(s1)
    80006c00:	0ff0000f          	fence
    80006c04:	0f50000f          	fence	iorw,ow
    80006c08:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006c0c:	ffffe097          	auipc	ra,0xffffe
    80006c10:	7f4080e7          	jalr	2036(ra) # 80005400 <mycpu>
    80006c14:	100027f3          	csrr	a5,sstatus
    80006c18:	0027f793          	andi	a5,a5,2
    80006c1c:	04079a63          	bnez	a5,80006c70 <release+0xb8>
    80006c20:	07852783          	lw	a5,120(a0)
    80006c24:	02f05e63          	blez	a5,80006c60 <release+0xa8>
    80006c28:	fff7871b          	addiw	a4,a5,-1
    80006c2c:	06e52c23          	sw	a4,120(a0)
    80006c30:	00071c63          	bnez	a4,80006c48 <release+0x90>
    80006c34:	07c52783          	lw	a5,124(a0)
    80006c38:	00078863          	beqz	a5,80006c48 <release+0x90>
    80006c3c:	100027f3          	csrr	a5,sstatus
    80006c40:	0027e793          	ori	a5,a5,2
    80006c44:	10079073          	csrw	sstatus,a5
    80006c48:	01813083          	ld	ra,24(sp)
    80006c4c:	01013403          	ld	s0,16(sp)
    80006c50:	00813483          	ld	s1,8(sp)
    80006c54:	00013903          	ld	s2,0(sp)
    80006c58:	02010113          	addi	sp,sp,32
    80006c5c:	00008067          	ret
    80006c60:	00002517          	auipc	a0,0x2
    80006c64:	aa050513          	addi	a0,a0,-1376 # 80008700 <digits+0x48>
    80006c68:	fffff097          	auipc	ra,0xfffff
    80006c6c:	154080e7          	jalr	340(ra) # 80005dbc <panic>
    80006c70:	00002517          	auipc	a0,0x2
    80006c74:	a7850513          	addi	a0,a0,-1416 # 800086e8 <digits+0x30>
    80006c78:	fffff097          	auipc	ra,0xfffff
    80006c7c:	144080e7          	jalr	324(ra) # 80005dbc <panic>

0000000080006c80 <holding>:
    80006c80:	00052783          	lw	a5,0(a0)
    80006c84:	00079663          	bnez	a5,80006c90 <holding+0x10>
    80006c88:	00000513          	li	a0,0
    80006c8c:	00008067          	ret
    80006c90:	fe010113          	addi	sp,sp,-32
    80006c94:	00813823          	sd	s0,16(sp)
    80006c98:	00913423          	sd	s1,8(sp)
    80006c9c:	00113c23          	sd	ra,24(sp)
    80006ca0:	02010413          	addi	s0,sp,32
    80006ca4:	01053483          	ld	s1,16(a0)
    80006ca8:	ffffe097          	auipc	ra,0xffffe
    80006cac:	758080e7          	jalr	1880(ra) # 80005400 <mycpu>
    80006cb0:	01813083          	ld	ra,24(sp)
    80006cb4:	01013403          	ld	s0,16(sp)
    80006cb8:	40a48533          	sub	a0,s1,a0
    80006cbc:	00153513          	seqz	a0,a0
    80006cc0:	00813483          	ld	s1,8(sp)
    80006cc4:	02010113          	addi	sp,sp,32
    80006cc8:	00008067          	ret

0000000080006ccc <push_off>:
    80006ccc:	fe010113          	addi	sp,sp,-32
    80006cd0:	00813823          	sd	s0,16(sp)
    80006cd4:	00113c23          	sd	ra,24(sp)
    80006cd8:	00913423          	sd	s1,8(sp)
    80006cdc:	02010413          	addi	s0,sp,32
    80006ce0:	100024f3          	csrr	s1,sstatus
    80006ce4:	100027f3          	csrr	a5,sstatus
    80006ce8:	ffd7f793          	andi	a5,a5,-3
    80006cec:	10079073          	csrw	sstatus,a5
    80006cf0:	ffffe097          	auipc	ra,0xffffe
    80006cf4:	710080e7          	jalr	1808(ra) # 80005400 <mycpu>
    80006cf8:	07852783          	lw	a5,120(a0)
    80006cfc:	02078663          	beqz	a5,80006d28 <push_off+0x5c>
    80006d00:	ffffe097          	auipc	ra,0xffffe
    80006d04:	700080e7          	jalr	1792(ra) # 80005400 <mycpu>
    80006d08:	07852783          	lw	a5,120(a0)
    80006d0c:	01813083          	ld	ra,24(sp)
    80006d10:	01013403          	ld	s0,16(sp)
    80006d14:	0017879b          	addiw	a5,a5,1
    80006d18:	06f52c23          	sw	a5,120(a0)
    80006d1c:	00813483          	ld	s1,8(sp)
    80006d20:	02010113          	addi	sp,sp,32
    80006d24:	00008067          	ret
    80006d28:	0014d493          	srli	s1,s1,0x1
    80006d2c:	ffffe097          	auipc	ra,0xffffe
    80006d30:	6d4080e7          	jalr	1748(ra) # 80005400 <mycpu>
    80006d34:	0014f493          	andi	s1,s1,1
    80006d38:	06952e23          	sw	s1,124(a0)
    80006d3c:	fc5ff06f          	j	80006d00 <push_off+0x34>

0000000080006d40 <pop_off>:
    80006d40:	ff010113          	addi	sp,sp,-16
    80006d44:	00813023          	sd	s0,0(sp)
    80006d48:	00113423          	sd	ra,8(sp)
    80006d4c:	01010413          	addi	s0,sp,16
    80006d50:	ffffe097          	auipc	ra,0xffffe
    80006d54:	6b0080e7          	jalr	1712(ra) # 80005400 <mycpu>
    80006d58:	100027f3          	csrr	a5,sstatus
    80006d5c:	0027f793          	andi	a5,a5,2
    80006d60:	04079663          	bnez	a5,80006dac <pop_off+0x6c>
    80006d64:	07852783          	lw	a5,120(a0)
    80006d68:	02f05a63          	blez	a5,80006d9c <pop_off+0x5c>
    80006d6c:	fff7871b          	addiw	a4,a5,-1
    80006d70:	06e52c23          	sw	a4,120(a0)
    80006d74:	00071c63          	bnez	a4,80006d8c <pop_off+0x4c>
    80006d78:	07c52783          	lw	a5,124(a0)
    80006d7c:	00078863          	beqz	a5,80006d8c <pop_off+0x4c>
    80006d80:	100027f3          	csrr	a5,sstatus
    80006d84:	0027e793          	ori	a5,a5,2
    80006d88:	10079073          	csrw	sstatus,a5
    80006d8c:	00813083          	ld	ra,8(sp)
    80006d90:	00013403          	ld	s0,0(sp)
    80006d94:	01010113          	addi	sp,sp,16
    80006d98:	00008067          	ret
    80006d9c:	00002517          	auipc	a0,0x2
    80006da0:	96450513          	addi	a0,a0,-1692 # 80008700 <digits+0x48>
    80006da4:	fffff097          	auipc	ra,0xfffff
    80006da8:	018080e7          	jalr	24(ra) # 80005dbc <panic>
    80006dac:	00002517          	auipc	a0,0x2
    80006db0:	93c50513          	addi	a0,a0,-1732 # 800086e8 <digits+0x30>
    80006db4:	fffff097          	auipc	ra,0xfffff
    80006db8:	008080e7          	jalr	8(ra) # 80005dbc <panic>

0000000080006dbc <push_on>:
    80006dbc:	fe010113          	addi	sp,sp,-32
    80006dc0:	00813823          	sd	s0,16(sp)
    80006dc4:	00113c23          	sd	ra,24(sp)
    80006dc8:	00913423          	sd	s1,8(sp)
    80006dcc:	02010413          	addi	s0,sp,32
    80006dd0:	100024f3          	csrr	s1,sstatus
    80006dd4:	100027f3          	csrr	a5,sstatus
    80006dd8:	0027e793          	ori	a5,a5,2
    80006ddc:	10079073          	csrw	sstatus,a5
    80006de0:	ffffe097          	auipc	ra,0xffffe
    80006de4:	620080e7          	jalr	1568(ra) # 80005400 <mycpu>
    80006de8:	07852783          	lw	a5,120(a0)
    80006dec:	02078663          	beqz	a5,80006e18 <push_on+0x5c>
    80006df0:	ffffe097          	auipc	ra,0xffffe
    80006df4:	610080e7          	jalr	1552(ra) # 80005400 <mycpu>
    80006df8:	07852783          	lw	a5,120(a0)
    80006dfc:	01813083          	ld	ra,24(sp)
    80006e00:	01013403          	ld	s0,16(sp)
    80006e04:	0017879b          	addiw	a5,a5,1
    80006e08:	06f52c23          	sw	a5,120(a0)
    80006e0c:	00813483          	ld	s1,8(sp)
    80006e10:	02010113          	addi	sp,sp,32
    80006e14:	00008067          	ret
    80006e18:	0014d493          	srli	s1,s1,0x1
    80006e1c:	ffffe097          	auipc	ra,0xffffe
    80006e20:	5e4080e7          	jalr	1508(ra) # 80005400 <mycpu>
    80006e24:	0014f493          	andi	s1,s1,1
    80006e28:	06952e23          	sw	s1,124(a0)
    80006e2c:	fc5ff06f          	j	80006df0 <push_on+0x34>

0000000080006e30 <pop_on>:
    80006e30:	ff010113          	addi	sp,sp,-16
    80006e34:	00813023          	sd	s0,0(sp)
    80006e38:	00113423          	sd	ra,8(sp)
    80006e3c:	01010413          	addi	s0,sp,16
    80006e40:	ffffe097          	auipc	ra,0xffffe
    80006e44:	5c0080e7          	jalr	1472(ra) # 80005400 <mycpu>
    80006e48:	100027f3          	csrr	a5,sstatus
    80006e4c:	0027f793          	andi	a5,a5,2
    80006e50:	04078463          	beqz	a5,80006e98 <pop_on+0x68>
    80006e54:	07852783          	lw	a5,120(a0)
    80006e58:	02f05863          	blez	a5,80006e88 <pop_on+0x58>
    80006e5c:	fff7879b          	addiw	a5,a5,-1
    80006e60:	06f52c23          	sw	a5,120(a0)
    80006e64:	07853783          	ld	a5,120(a0)
    80006e68:	00079863          	bnez	a5,80006e78 <pop_on+0x48>
    80006e6c:	100027f3          	csrr	a5,sstatus
    80006e70:	ffd7f793          	andi	a5,a5,-3
    80006e74:	10079073          	csrw	sstatus,a5
    80006e78:	00813083          	ld	ra,8(sp)
    80006e7c:	00013403          	ld	s0,0(sp)
    80006e80:	01010113          	addi	sp,sp,16
    80006e84:	00008067          	ret
    80006e88:	00002517          	auipc	a0,0x2
    80006e8c:	8a050513          	addi	a0,a0,-1888 # 80008728 <digits+0x70>
    80006e90:	fffff097          	auipc	ra,0xfffff
    80006e94:	f2c080e7          	jalr	-212(ra) # 80005dbc <panic>
    80006e98:	00002517          	auipc	a0,0x2
    80006e9c:	87050513          	addi	a0,a0,-1936 # 80008708 <digits+0x50>
    80006ea0:	fffff097          	auipc	ra,0xfffff
    80006ea4:	f1c080e7          	jalr	-228(ra) # 80005dbc <panic>

0000000080006ea8 <__memset>:
    80006ea8:	ff010113          	addi	sp,sp,-16
    80006eac:	00813423          	sd	s0,8(sp)
    80006eb0:	01010413          	addi	s0,sp,16
    80006eb4:	1a060e63          	beqz	a2,80007070 <__memset+0x1c8>
    80006eb8:	40a007b3          	neg	a5,a0
    80006ebc:	0077f793          	andi	a5,a5,7
    80006ec0:	00778693          	addi	a3,a5,7
    80006ec4:	00b00813          	li	a6,11
    80006ec8:	0ff5f593          	andi	a1,a1,255
    80006ecc:	fff6071b          	addiw	a4,a2,-1
    80006ed0:	1b06e663          	bltu	a3,a6,8000707c <__memset+0x1d4>
    80006ed4:	1cd76463          	bltu	a4,a3,8000709c <__memset+0x1f4>
    80006ed8:	1a078e63          	beqz	a5,80007094 <__memset+0x1ec>
    80006edc:	00b50023          	sb	a1,0(a0)
    80006ee0:	00100713          	li	a4,1
    80006ee4:	1ae78463          	beq	a5,a4,8000708c <__memset+0x1e4>
    80006ee8:	00b500a3          	sb	a1,1(a0)
    80006eec:	00200713          	li	a4,2
    80006ef0:	1ae78a63          	beq	a5,a4,800070a4 <__memset+0x1fc>
    80006ef4:	00b50123          	sb	a1,2(a0)
    80006ef8:	00300713          	li	a4,3
    80006efc:	18e78463          	beq	a5,a4,80007084 <__memset+0x1dc>
    80006f00:	00b501a3          	sb	a1,3(a0)
    80006f04:	00400713          	li	a4,4
    80006f08:	1ae78263          	beq	a5,a4,800070ac <__memset+0x204>
    80006f0c:	00b50223          	sb	a1,4(a0)
    80006f10:	00500713          	li	a4,5
    80006f14:	1ae78063          	beq	a5,a4,800070b4 <__memset+0x20c>
    80006f18:	00b502a3          	sb	a1,5(a0)
    80006f1c:	00700713          	li	a4,7
    80006f20:	18e79e63          	bne	a5,a4,800070bc <__memset+0x214>
    80006f24:	00b50323          	sb	a1,6(a0)
    80006f28:	00700e93          	li	t4,7
    80006f2c:	00859713          	slli	a4,a1,0x8
    80006f30:	00e5e733          	or	a4,a1,a4
    80006f34:	01059e13          	slli	t3,a1,0x10
    80006f38:	01c76e33          	or	t3,a4,t3
    80006f3c:	01859313          	slli	t1,a1,0x18
    80006f40:	006e6333          	or	t1,t3,t1
    80006f44:	02059893          	slli	a7,a1,0x20
    80006f48:	40f60e3b          	subw	t3,a2,a5
    80006f4c:	011368b3          	or	a7,t1,a7
    80006f50:	02859813          	slli	a6,a1,0x28
    80006f54:	0108e833          	or	a6,a7,a6
    80006f58:	03059693          	slli	a3,a1,0x30
    80006f5c:	003e589b          	srliw	a7,t3,0x3
    80006f60:	00d866b3          	or	a3,a6,a3
    80006f64:	03859713          	slli	a4,a1,0x38
    80006f68:	00389813          	slli	a6,a7,0x3
    80006f6c:	00f507b3          	add	a5,a0,a5
    80006f70:	00e6e733          	or	a4,a3,a4
    80006f74:	000e089b          	sext.w	a7,t3
    80006f78:	00f806b3          	add	a3,a6,a5
    80006f7c:	00e7b023          	sd	a4,0(a5)
    80006f80:	00878793          	addi	a5,a5,8
    80006f84:	fed79ce3          	bne	a5,a3,80006f7c <__memset+0xd4>
    80006f88:	ff8e7793          	andi	a5,t3,-8
    80006f8c:	0007871b          	sext.w	a4,a5
    80006f90:	01d787bb          	addw	a5,a5,t4
    80006f94:	0ce88e63          	beq	a7,a4,80007070 <__memset+0x1c8>
    80006f98:	00f50733          	add	a4,a0,a5
    80006f9c:	00b70023          	sb	a1,0(a4)
    80006fa0:	0017871b          	addiw	a4,a5,1
    80006fa4:	0cc77663          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80006fa8:	00e50733          	add	a4,a0,a4
    80006fac:	00b70023          	sb	a1,0(a4)
    80006fb0:	0027871b          	addiw	a4,a5,2
    80006fb4:	0ac77e63          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80006fb8:	00e50733          	add	a4,a0,a4
    80006fbc:	00b70023          	sb	a1,0(a4)
    80006fc0:	0037871b          	addiw	a4,a5,3
    80006fc4:	0ac77663          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80006fc8:	00e50733          	add	a4,a0,a4
    80006fcc:	00b70023          	sb	a1,0(a4)
    80006fd0:	0047871b          	addiw	a4,a5,4
    80006fd4:	08c77e63          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80006fd8:	00e50733          	add	a4,a0,a4
    80006fdc:	00b70023          	sb	a1,0(a4)
    80006fe0:	0057871b          	addiw	a4,a5,5
    80006fe4:	08c77663          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80006fe8:	00e50733          	add	a4,a0,a4
    80006fec:	00b70023          	sb	a1,0(a4)
    80006ff0:	0067871b          	addiw	a4,a5,6
    80006ff4:	06c77e63          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80006ff8:	00e50733          	add	a4,a0,a4
    80006ffc:	00b70023          	sb	a1,0(a4)
    80007000:	0077871b          	addiw	a4,a5,7
    80007004:	06c77663          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80007008:	00e50733          	add	a4,a0,a4
    8000700c:	00b70023          	sb	a1,0(a4)
    80007010:	0087871b          	addiw	a4,a5,8
    80007014:	04c77e63          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80007018:	00e50733          	add	a4,a0,a4
    8000701c:	00b70023          	sb	a1,0(a4)
    80007020:	0097871b          	addiw	a4,a5,9
    80007024:	04c77663          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80007028:	00e50733          	add	a4,a0,a4
    8000702c:	00b70023          	sb	a1,0(a4)
    80007030:	00a7871b          	addiw	a4,a5,10
    80007034:	02c77e63          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80007038:	00e50733          	add	a4,a0,a4
    8000703c:	00b70023          	sb	a1,0(a4)
    80007040:	00b7871b          	addiw	a4,a5,11
    80007044:	02c77663          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80007048:	00e50733          	add	a4,a0,a4
    8000704c:	00b70023          	sb	a1,0(a4)
    80007050:	00c7871b          	addiw	a4,a5,12
    80007054:	00c77e63          	bgeu	a4,a2,80007070 <__memset+0x1c8>
    80007058:	00e50733          	add	a4,a0,a4
    8000705c:	00b70023          	sb	a1,0(a4)
    80007060:	00d7879b          	addiw	a5,a5,13
    80007064:	00c7f663          	bgeu	a5,a2,80007070 <__memset+0x1c8>
    80007068:	00f507b3          	add	a5,a0,a5
    8000706c:	00b78023          	sb	a1,0(a5)
    80007070:	00813403          	ld	s0,8(sp)
    80007074:	01010113          	addi	sp,sp,16
    80007078:	00008067          	ret
    8000707c:	00b00693          	li	a3,11
    80007080:	e55ff06f          	j	80006ed4 <__memset+0x2c>
    80007084:	00300e93          	li	t4,3
    80007088:	ea5ff06f          	j	80006f2c <__memset+0x84>
    8000708c:	00100e93          	li	t4,1
    80007090:	e9dff06f          	j	80006f2c <__memset+0x84>
    80007094:	00000e93          	li	t4,0
    80007098:	e95ff06f          	j	80006f2c <__memset+0x84>
    8000709c:	00000793          	li	a5,0
    800070a0:	ef9ff06f          	j	80006f98 <__memset+0xf0>
    800070a4:	00200e93          	li	t4,2
    800070a8:	e85ff06f          	j	80006f2c <__memset+0x84>
    800070ac:	00400e93          	li	t4,4
    800070b0:	e7dff06f          	j	80006f2c <__memset+0x84>
    800070b4:	00500e93          	li	t4,5
    800070b8:	e75ff06f          	j	80006f2c <__memset+0x84>
    800070bc:	00600e93          	li	t4,6
    800070c0:	e6dff06f          	j	80006f2c <__memset+0x84>

00000000800070c4 <__memmove>:
    800070c4:	ff010113          	addi	sp,sp,-16
    800070c8:	00813423          	sd	s0,8(sp)
    800070cc:	01010413          	addi	s0,sp,16
    800070d0:	0e060863          	beqz	a2,800071c0 <__memmove+0xfc>
    800070d4:	fff6069b          	addiw	a3,a2,-1
    800070d8:	0006881b          	sext.w	a6,a3
    800070dc:	0ea5e863          	bltu	a1,a0,800071cc <__memmove+0x108>
    800070e0:	00758713          	addi	a4,a1,7
    800070e4:	00a5e7b3          	or	a5,a1,a0
    800070e8:	40a70733          	sub	a4,a4,a0
    800070ec:	0077f793          	andi	a5,a5,7
    800070f0:	00f73713          	sltiu	a4,a4,15
    800070f4:	00174713          	xori	a4,a4,1
    800070f8:	0017b793          	seqz	a5,a5
    800070fc:	00e7f7b3          	and	a5,a5,a4
    80007100:	10078863          	beqz	a5,80007210 <__memmove+0x14c>
    80007104:	00900793          	li	a5,9
    80007108:	1107f463          	bgeu	a5,a6,80007210 <__memmove+0x14c>
    8000710c:	0036581b          	srliw	a6,a2,0x3
    80007110:	fff8081b          	addiw	a6,a6,-1
    80007114:	02081813          	slli	a6,a6,0x20
    80007118:	01d85893          	srli	a7,a6,0x1d
    8000711c:	00858813          	addi	a6,a1,8
    80007120:	00058793          	mv	a5,a1
    80007124:	00050713          	mv	a4,a0
    80007128:	01088833          	add	a6,a7,a6
    8000712c:	0007b883          	ld	a7,0(a5)
    80007130:	00878793          	addi	a5,a5,8
    80007134:	00870713          	addi	a4,a4,8
    80007138:	ff173c23          	sd	a7,-8(a4)
    8000713c:	ff0798e3          	bne	a5,a6,8000712c <__memmove+0x68>
    80007140:	ff867713          	andi	a4,a2,-8
    80007144:	02071793          	slli	a5,a4,0x20
    80007148:	0207d793          	srli	a5,a5,0x20
    8000714c:	00f585b3          	add	a1,a1,a5
    80007150:	40e686bb          	subw	a3,a3,a4
    80007154:	00f507b3          	add	a5,a0,a5
    80007158:	06e60463          	beq	a2,a4,800071c0 <__memmove+0xfc>
    8000715c:	0005c703          	lbu	a4,0(a1)
    80007160:	00e78023          	sb	a4,0(a5)
    80007164:	04068e63          	beqz	a3,800071c0 <__memmove+0xfc>
    80007168:	0015c603          	lbu	a2,1(a1)
    8000716c:	00100713          	li	a4,1
    80007170:	00c780a3          	sb	a2,1(a5)
    80007174:	04e68663          	beq	a3,a4,800071c0 <__memmove+0xfc>
    80007178:	0025c603          	lbu	a2,2(a1)
    8000717c:	00200713          	li	a4,2
    80007180:	00c78123          	sb	a2,2(a5)
    80007184:	02e68e63          	beq	a3,a4,800071c0 <__memmove+0xfc>
    80007188:	0035c603          	lbu	a2,3(a1)
    8000718c:	00300713          	li	a4,3
    80007190:	00c781a3          	sb	a2,3(a5)
    80007194:	02e68663          	beq	a3,a4,800071c0 <__memmove+0xfc>
    80007198:	0045c603          	lbu	a2,4(a1)
    8000719c:	00400713          	li	a4,4
    800071a0:	00c78223          	sb	a2,4(a5)
    800071a4:	00e68e63          	beq	a3,a4,800071c0 <__memmove+0xfc>
    800071a8:	0055c603          	lbu	a2,5(a1)
    800071ac:	00500713          	li	a4,5
    800071b0:	00c782a3          	sb	a2,5(a5)
    800071b4:	00e68663          	beq	a3,a4,800071c0 <__memmove+0xfc>
    800071b8:	0065c703          	lbu	a4,6(a1)
    800071bc:	00e78323          	sb	a4,6(a5)
    800071c0:	00813403          	ld	s0,8(sp)
    800071c4:	01010113          	addi	sp,sp,16
    800071c8:	00008067          	ret
    800071cc:	02061713          	slli	a4,a2,0x20
    800071d0:	02075713          	srli	a4,a4,0x20
    800071d4:	00e587b3          	add	a5,a1,a4
    800071d8:	f0f574e3          	bgeu	a0,a5,800070e0 <__memmove+0x1c>
    800071dc:	02069613          	slli	a2,a3,0x20
    800071e0:	02065613          	srli	a2,a2,0x20
    800071e4:	fff64613          	not	a2,a2
    800071e8:	00e50733          	add	a4,a0,a4
    800071ec:	00c78633          	add	a2,a5,a2
    800071f0:	fff7c683          	lbu	a3,-1(a5)
    800071f4:	fff78793          	addi	a5,a5,-1
    800071f8:	fff70713          	addi	a4,a4,-1
    800071fc:	00d70023          	sb	a3,0(a4)
    80007200:	fec798e3          	bne	a5,a2,800071f0 <__memmove+0x12c>
    80007204:	00813403          	ld	s0,8(sp)
    80007208:	01010113          	addi	sp,sp,16
    8000720c:	00008067          	ret
    80007210:	02069713          	slli	a4,a3,0x20
    80007214:	02075713          	srli	a4,a4,0x20
    80007218:	00170713          	addi	a4,a4,1
    8000721c:	00e50733          	add	a4,a0,a4
    80007220:	00050793          	mv	a5,a0
    80007224:	0005c683          	lbu	a3,0(a1)
    80007228:	00178793          	addi	a5,a5,1
    8000722c:	00158593          	addi	a1,a1,1
    80007230:	fed78fa3          	sb	a3,-1(a5)
    80007234:	fee798e3          	bne	a5,a4,80007224 <__memmove+0x160>
    80007238:	f89ff06f          	j	800071c0 <__memmove+0xfc>

000000008000723c <__putc>:
    8000723c:	fe010113          	addi	sp,sp,-32
    80007240:	00813823          	sd	s0,16(sp)
    80007244:	00113c23          	sd	ra,24(sp)
    80007248:	02010413          	addi	s0,sp,32
    8000724c:	00050793          	mv	a5,a0
    80007250:	fef40593          	addi	a1,s0,-17
    80007254:	00100613          	li	a2,1
    80007258:	00000513          	li	a0,0
    8000725c:	fef407a3          	sb	a5,-17(s0)
    80007260:	fffff097          	auipc	ra,0xfffff
    80007264:	b3c080e7          	jalr	-1220(ra) # 80005d9c <console_write>
    80007268:	01813083          	ld	ra,24(sp)
    8000726c:	01013403          	ld	s0,16(sp)
    80007270:	02010113          	addi	sp,sp,32
    80007274:	00008067          	ret

0000000080007278 <__getc>:
    80007278:	fe010113          	addi	sp,sp,-32
    8000727c:	00813823          	sd	s0,16(sp)
    80007280:	00113c23          	sd	ra,24(sp)
    80007284:	02010413          	addi	s0,sp,32
    80007288:	fe840593          	addi	a1,s0,-24
    8000728c:	00100613          	li	a2,1
    80007290:	00000513          	li	a0,0
    80007294:	fffff097          	auipc	ra,0xfffff
    80007298:	ae8080e7          	jalr	-1304(ra) # 80005d7c <console_read>
    8000729c:	fe844503          	lbu	a0,-24(s0)
    800072a0:	01813083          	ld	ra,24(sp)
    800072a4:	01013403          	ld	s0,16(sp)
    800072a8:	02010113          	addi	sp,sp,32
    800072ac:	00008067          	ret

00000000800072b0 <console_handler>:
    800072b0:	fe010113          	addi	sp,sp,-32
    800072b4:	00813823          	sd	s0,16(sp)
    800072b8:	00113c23          	sd	ra,24(sp)
    800072bc:	00913423          	sd	s1,8(sp)
    800072c0:	02010413          	addi	s0,sp,32
    800072c4:	14202773          	csrr	a4,scause
    800072c8:	100027f3          	csrr	a5,sstatus
    800072cc:	0027f793          	andi	a5,a5,2
    800072d0:	06079e63          	bnez	a5,8000734c <console_handler+0x9c>
    800072d4:	00074c63          	bltz	a4,800072ec <console_handler+0x3c>
    800072d8:	01813083          	ld	ra,24(sp)
    800072dc:	01013403          	ld	s0,16(sp)
    800072e0:	00813483          	ld	s1,8(sp)
    800072e4:	02010113          	addi	sp,sp,32
    800072e8:	00008067          	ret
    800072ec:	0ff77713          	andi	a4,a4,255
    800072f0:	00900793          	li	a5,9
    800072f4:	fef712e3          	bne	a4,a5,800072d8 <console_handler+0x28>
    800072f8:	ffffe097          	auipc	ra,0xffffe
    800072fc:	6dc080e7          	jalr	1756(ra) # 800059d4 <plic_claim>
    80007300:	00a00793          	li	a5,10
    80007304:	00050493          	mv	s1,a0
    80007308:	02f50c63          	beq	a0,a5,80007340 <console_handler+0x90>
    8000730c:	fc0506e3          	beqz	a0,800072d8 <console_handler+0x28>
    80007310:	00050593          	mv	a1,a0
    80007314:	00001517          	auipc	a0,0x1
    80007318:	31c50513          	addi	a0,a0,796 # 80008630 <CONSOLE_STATUS+0x620>
    8000731c:	fffff097          	auipc	ra,0xfffff
    80007320:	afc080e7          	jalr	-1284(ra) # 80005e18 <__printf>
    80007324:	01013403          	ld	s0,16(sp)
    80007328:	01813083          	ld	ra,24(sp)
    8000732c:	00048513          	mv	a0,s1
    80007330:	00813483          	ld	s1,8(sp)
    80007334:	02010113          	addi	sp,sp,32
    80007338:	ffffe317          	auipc	t1,0xffffe
    8000733c:	6d430067          	jr	1748(t1) # 80005a0c <plic_complete>
    80007340:	fffff097          	auipc	ra,0xfffff
    80007344:	3e0080e7          	jalr	992(ra) # 80006720 <uartintr>
    80007348:	fddff06f          	j	80007324 <console_handler+0x74>
    8000734c:	00001517          	auipc	a0,0x1
    80007350:	3e450513          	addi	a0,a0,996 # 80008730 <digits+0x78>
    80007354:	fffff097          	auipc	ra,0xfffff
    80007358:	a68080e7          	jalr	-1432(ra) # 80005dbc <panic>
	...
