#include "Typedefs.h"

extern "C" void* __cdecl memset(void *, int, size_t);
#pragma intrinsic(memset)
extern "C" void* _cdecl memcpy(void* dest, const void* src, size_t count);
#pragma function(memcpy)

extern "C" {
	int _fltused{0x9875};

	#pragma function(memset)
    void* _cdecl memset(void* dest, int c, size_t count) {
        u8* bytes = (u8*)dest;
        while (count--) {
            *bytes++ = (u8)c;
        }
        return dest;
    }

    #pragma function(memcpy)
    void* _cdecl memcpy(void* dest, const void* src, size_t count) {
        u8* dest8 = (u8*)dest;
        const u8* src8 = (const u8*)src;
        while (count--) {
            *dest8++ = *src8++;
        }
        return dest;
    }
}
