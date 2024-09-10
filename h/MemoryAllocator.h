//
// Created by os on 5/16/24.
//

#ifndef PROJECT_BASE_MEMORYALLOCATOR_H
#define PROJECT_BASE_MEMORYALLOCATOR_H

#include "../lib/hw.h"

typedef struct memmeta {
    size_t size;
    void* next;
}MemMeta;

class MemoryAllocator {
    static MemMeta* firstFree;
    static MemMeta* firstUsed;
public:
    static void* mem_alloc (size_t size);
    static int mem_free (void* ptr);
};

#endif //PROJECT_BASE_MEMORYALLOCATOR_H
