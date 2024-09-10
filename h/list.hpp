//
// Created by os on 8/21/24.
//

#ifndef PROJECT_BASE_LIST_HPP
#define PROJECT_BASE_LIST_HPP

#include "../h/syscall_c.hpp"

class TCB;

class List {
public:

    typedef struct elem{
        TCB* data;
        elem* next;
    }Elem;

    Elem* head;

    List () : head(0) {};

    void addFront (TCB* data){
        Elem* newElem = (Elem*)mem_alloc(sizeof(Elem));

        newElem->data = data;
        newElem->next = head;
        head = newElem;
    }

    void addRear (TCB* data){
        Elem* curr = 0;
        Elem* newElem = (Elem*)mem_alloc(sizeof(Elem));

        newElem->data = data;
        newElem->next = 0;
        if (head) {
            for (curr = head; curr->next != 0; curr = curr->next);
            curr->next = newElem;
        }
        else head = newElem;
    }

    TCB* popFront () {
        if (head == 0) return 0;
        TCB* tmpTCB = head->data;
        Elem* tmpElem = head;

        head = head->next;
        if(mem_free(tmpElem)) {};
        tmpElem = 0;
        return tmpTCB;
    }

    TCB* peekFront () {
        if (head == 0) return 0;
        return head->data;
    }
};


#endif //PROJECT_BASE_LIST_HPP
