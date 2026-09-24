#include <stdint.h>
#include <stdbool.h>

// Macro para exportar a função para o WebAssembly
#define WASM_EXPORT __attribute__((visibility("default")))

// Protótipo da função de teste do Map2Check
extern int32_t __VERIFIER_nondet_int32(void);

// Soma básica (vulnerável a overflow)
WASM_EXPORT int32_t soma(int32_t a, int32_t b) {
    return a + b;
}

// TODO: Implementar detecção lógica de overflow (como o MIPS faria!)
// Retorna o resultado. Se houver overflow, *teve_overflow = true.
WASM_EXPORT int32_t soma_segura(int32_t a, int32_t b, bool* teve_overflow) {
    *teve_overflow = false;
    // DICA: Analise os sinais dos operandos 'a' e 'b' e compare
    // com o sinal do resultado. Lembre-se do MSB (Most Significant Bit).
    int32_t resultado = a + b;
    
    // Condicao overflow = a.b.!(resultado) + !a.!b.(resultado)
    // Expressão obtida por Karnaugh
    // Nota: Descobriu-se que shift rights conservam o sinal
    // Portanto houve de aplicar AND 1 para retornar 1 (em vez de -1)
    int32_t sa = (a >> 31) & 1;
    int32_t sb = (b >> 31) & 1;
    int32_t sr = (resultado >> 31) & 1;

    bool condicao_of = (sa && sb && !sr) || (!sa && !sb && sr);

    if (condicao_of) *teve_overflow = true;

    return resultado;
}

// TODO: Implementar 'sub' e 'sub_segura'
WASM_EXPORT int32_t sub(int32_t a, int32_t b) {
    return a - b;
}

WASM_EXPORT int32_t sub_segura(int32_t a, int32_t b, bool* teve_overflow) {
    *teve_overflow = false;
    int32_t resultado = a - b;
    
    // Condicao overflow = !a.b.(resultado) + a.!b.!(resultado)
    // Expressão obtida por Karnaugh
    // Nota: Descobriu-se que shift rights conservam o sinal
    // Portanto houve de aplicar AND 1 para retornar 1 (em vez de -1)
    int32_t sa = (a >> 31) & 1;
    int32_t sb = (b >> 31) & 1;
    int32_t sr = (resultado >> 31) & 1;

    bool condicao_of = (!sa && sb && sr) || (sa && !sb && !sr);

    if (condicao_of) *teve_overflow = true;

    return resultado;
}

// TODO: Implementar 'mul' e 'mul_segura'

WASM_EXPORT int32_t mul(int32_t a, int32_t b) {
    return a * b;
}

WASM_EXPORT int32_t mul_segura(int32_t a, int32_t b, bool* teve_overflow) {
    *teve_overflow = false;

    // Multiplicação de x32 * x32 = x64
    // Duplo int64_t para melhorar a legibilidade
    // Mas podia ser apenas em 'a' conforme tipagem fraca do C
    int64_t resultado = (int64_t) a * (int64_t) b;

    // Verificação overflow para x32
    if (resultado > INT32_MAX || resultado < INT32_MIN) *teve_overflow = true;

    // Retorno em x32 (Nota: A multi. completa poderia ser retornada em x64)
    return (int32_t) resultado;
}



int main() {
    // O Map2Check vai gerar valores aleatórios/extremos para 'a' e 'b'
    int32_t a = __VERIFIER_nondet_int32();
    int32_t b = __VERIFIER_nondet_int32();

    // 1. Para testar o CONTRAEXEMPLO (a ferramenta DEVE achar a falha na 'soma'):
    soma(a, b);

    // 2. Depois de validar a falha, comente a linha acima e descomente abaixo
    // para provar que a 'soma_segura' corrigiu o problema:
    /*
    bool overflow = false;
    soma_segura(a, b, &overflow);
    */

    return 0;
}

