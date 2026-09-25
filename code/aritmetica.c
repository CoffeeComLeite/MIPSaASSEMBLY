#include <stdint.h>
#include <stdbool.h>
#include <limits.h>

#define WASM_EXPORT __attribute__((visibility("default")))

extern int32_t __VERIFIER_nondet_int32(void);
extern void __VERIFIER_error(void);

WASM_EXPORT int32_t soma(int32_t a, int32_t b) {
    return a + b;
}

WASM_EXPORT int32_t soma_segura(int32_t a, int32_t b, bool* teve_overflow) {
    *teve_overflow = false;
    int32_t resultado = a + b;

    int32_t sa = (a >> 31) & 1;
    int32_t sb = (b >> 31) & 1;
    int32_t sr = (resultado >> 31) & 1;

    bool condicao_of = (sa && sb && !sr) || (!sa && !sb && sr);

    if (condicao_of) *teve_overflow = true;

    return resultado;
}

WASM_EXPORT int32_t sub(int32_t a, int32_t b) {
    return a - b;
}

WASM_EXPORT int32_t sub_segura(int32_t a, int32_t b, bool* teve_overflow) {
    *teve_overflow = false;
    int32_t resultado = a - b;

    int32_t sa = (a >> 31) & 1;
    int32_t sb = (b >> 31) & 1;
    int32_t sr = (resultado >> 31) & 1;

    bool condicao_of = (!sa && sb && sr) || (sa && !sb && !sr);

    if (condicao_of) *teve_overflow = true;

    return resultado;
}

WASM_EXPORT int32_t mul(int32_t a, int32_t b) {
    return a * b;
}

WASM_EXPORT int32_t mul_segura(int32_t a, int32_t b, bool* teve_overflow) {
    *teve_overflow = false;

    int64_t resultado = (int64_t)a * (int64_t)b;

    if (resultado > INT32_MAX || resultado < INT32_MIN) *teve_overflow = true;

    return (int32_t)resultado;
}

int main(void) {
    int32_t a = INT32_MAX;
    int32_t b = 1;

    int32_t r1 = soma(a, b);
    (void)r1;

    bool overflow = false;
    int32_t r2 = soma_segura(a, b, &overflow);
    (void)r2;

    if (overflow) {
        __VERIFIER_error();
    }

    return 0;
}
