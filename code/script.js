let wasmInstance = null;

// 1. Carregar o arquivo WebAssembly compilado (.wasm)
async function carregarWasm() {
    try {
        const response = await fetch('aritmetica.wasm');
        const bytes = await response.arrayBuffer();
        const memory = new WebAssembly.Memory({ initial: 1 });
        const results = await WebAssembly.instantiate(bytes, {
            env: { memory }
        });
        wasmInstance = results.instance;
        console.log("WASM carregado com sucesso!");
    } catch (err) {
        console.warn("WASM ainda não encontrado ou erro no fetch. O simulador JS será utilizado.", err);
    }
}
carregarWasm();

// Utilitário: Converter número JS para binário de 32 bits (Complemento de Dois)
function int32ParaBinario(num) {
    return (num >>> 0).toString(2).padStart(32, '0');
}

// Criar grades iniciais
function criarGrids() {
    ['grid-carry', 'grid-a', 'grid-b', 'grid-res'].forEach(id => {
        const grid = document.getElementById(id);
        grid.innerHTML = '';
        for (let i = 0; i < 32; i++) {
            const div = document.createElement('div');
            div.className = 'bit-box';
            div.id = `${id}-${i}`;
            div.innerText = '0';
            grid.appendChild(div);
        }
    });
}
criarGrids();

// Atualiza os rótulos ao trocar a operação
function atualizarInterfaceOperacao() {
    const op = document.getElementById('operacao').value;
    const labelCarry = document.getElementById('label-carry');
    const rowCarry = document.getElementById('row-carry');

    if (op === 'soma') {
        rowCarry.style.display = 'flex';
        labelCarry.innerText = 'Carry In / Out (Vai um):';
    } else if (op === 'sub') {
        rowCarry.style.display = 'flex';
        labelCarry.innerText = 'Borrow (Pede Emprestado):';
    } else if (op === 'mul') {
        rowCarry.style.display = 'flex';
        labelCarry.innerText = 'Shift / Bits Ativos do Multiplicador:';
    }
}

// Simulador JS de segurança (Executado caso o WASM ainda não esteja presente)
function executarSimulacaoJS(op, a, b) {
    let res = 0;
    let overflow = false;

    if (op === 'soma') {
        res = (a + b) | 0;
        overflow = ((a > 0 && b > 0 && res < 0) || (a < 0 && b < 0 && res >= 0));
    } else if (op === 'sub') {
        res = (a - b) | 0;
        overflow = ((a > 0 && b < 0 && res < 0) || (a < 0 && b > 0 && res >= 0));
    } else if (op === 'mul') {
        res = Math.imul(a, b);
        const prod = BigInt(a) * BigInt(b);
        overflow = (prod > 2147483647n || prod < -2147483648n);
    }

    return { res, overflow };
}

// Execução no Módulo WASM
function executarViaWasm(op, a, b) {
    if (!wasmInstance) return null;

    const exports = wasmInstance.exports;
    const ptrOverflow = 4; // Endereço de memória para a flag teve_overflow
    let res = 0;
    let overflow = false;

    try {
        if (op === 'soma') {
            if (exports.soma_segura) {
                res = exports.soma_segura(a, b, ptrOverflow);
                overflow = Boolean(new Uint8Array(exports.memory.buffer)[ptrOverflow]);
            } else if (exports.soma) {
                res = exports.soma(a, b);
                overflow = ((a > 0 && b > 0 && res < 0) || (a < 0 && b < 0 && res >= 0));
            }
        } else if (op === 'sub') {
            if (exports.sub_segura) {
                res = exports.sub_segura(a, b, ptrOverflow);
                overflow = Boolean(new Uint8Array(exports.memory.buffer)[ptrOverflow]);
            } else if (exports.sub) {
                res = exports.sub(a, b);
                overflow = ((a > 0 && b < 0 && res < 0) || (a < 0 && b > 0 && res >= 0));
            }
        } else if (op === 'mul') {
            if (exports.mul_segura) {
                res = exports.mul_segura(a, b, ptrOverflow);
                overflow = Boolean(new Uint8Array(exports.memory.buffer)[ptrOverflow]);
            } else if (exports.mul) {
                res = exports.mul(a, b);
                const prod = BigInt(a) * BigInt(b);
                overflow = (prod > 2147483647n || prod < -2147483648n);
            }
        }
        return { res, overflow };
    } catch (e) {
        console.warn("Falha ao invocar função do WASM, utilizando simulador...", e);
        return null;
    }
}

// 2. Animações Principais da Interface
async function executarAnimacao() {
    const btn = document.getElementById('btnCalcular');
    btn.disabled = true;

    const a = parseInt(document.getElementById('numA').value) || 0;
    const b = parseInt(document.getElementById('numB').value) || 0;
    const op = document.getElementById('operacao').value;

    const binA = int32ParaBinario(a);
    const binB = int32ParaBinario(b);

    document.getElementById('overflow-alert').style.display = 'none';
    criarGrids();

    // Renderizar operandos A e B
    for (let i = 0; i < 32; i++) {
        const elA = document.getElementById(`grid-a-${i}`);
        const elB = document.getElementById(`grid-b-${i}`);
        elA.innerText = binA[i];
        elB.innerText = binB[i];
        elA.className = `bit-box ${binA[i] === '1' ? 'active' : ''}`;
        elB.className = `bit-box ${binB[i] === '1' ? 'active' : ''}`;
    }

    // Executa a operação no WASM ou no Simulador
    let calculo = executarViaWasm(op, a, b);
    if (!calculo) {
        calculo = executarSimulacaoJS(op, a, b);
    }

    const binResultadoFinal = int32ParaBinario(calculo.res);

    // --- ANIMAÇÃO DE SOMA ---
    if (op === 'soma') {
        let carry = 0;
        for (let i = 31; i >= 0; i--) {
            const bitA = parseInt(binA[i]);
            const bitB = parseInt(binB[i]);

            const elA = document.getElementById(`grid-a-${i}`);
            const elB = document.getElementById(`grid-b-${i}`);
            const elRes = document.getElementById(`grid-res-${i}`);

            elA.classList.add('current');
            elB.classList.add('current');

            const sumBit = bitA ^ bitB ^ carry;
            const nextCarry = (bitA & bitB) | (carry & (bitA ^ bitB));

            await new Promise(r => setTimeout(r, 60));

            elRes.innerText = sumBit;
            if (sumBit === 1) elRes.classList.add('active');

            carry = nextCarry;
            if (i > 0) {
                const elNextCarry = document.getElementById(`grid-carry-${i - 1}`);
                elNextCarry.innerText = carry;
                if (carry === 1) elNextCarry.classList.add('carry');
            }

            elA.classList.remove('current');
            elB.classList.remove('current');
        }
    } 
    // --- ANIMAÇÃO DE SUBTRAÇÃO ---
    else if (op === 'sub') {
        let borrow = 0;
        for (let i = 31; i >= 0; i--) {
            const bitA = parseInt(binA[i]);
            const bitB = parseInt(binB[i]);

            const elA = document.getElementById(`grid-a-${i}`);
            const elB = document.getElementById(`grid-b-${i}`);
            const elRes = document.getElementById(`grid-res-${i}`);

            elA.classList.add('current');
            elB.classList.add('current');

            const diffBit = bitA ^ bitB ^ borrow;
            const nextBorrow = ((~bitA & bitB) | ((~(bitA ^ bitB)) & borrow)) & 1;

            await new Promise(r => setTimeout(r, 60));

            elRes.innerText = diffBit;
            if (diffBit === 1) elRes.classList.add('active');

            borrow = nextBorrow;
            if (i > 0) {
                const elNextBorrow = document.getElementById(`grid-carry-${i - 1}`);
                elNextBorrow.innerText = borrow;
                if (borrow === 1) elNextBorrow.classList.add('borrow');
            }

            elA.classList.remove('current');
            elB.classList.remove('current');
        }
    } 
    // --- ANIMAÇÃO DE MULTIPLICAÇÃO ---
    else if (op === 'mul') {
        for (let i = 31; i >= 0; i--) {
            const bitB = binB[i];
            const elB = document.getElementById(`grid-b-${i}`);
            const elShift = document.getElementById(`grid-carry-${i}`);
            
            elB.classList.add('current');

            if (bitB === '1') {
                elShift.innerText = '1';
                elShift.classList.add('active');
            } else {
                elShift.innerText = '0';
            }

            // Atualização progressiva do acumulador no resultado
            const elRes = document.getElementById(`grid-res-${i}`);
            elRes.innerText = binResultadoFinal[i];
            if (binResultadoFinal[i] === '1') elRes.classList.add('active');

            await new Promise(r => setTimeout(r, 50));
            elB.classList.remove('current');
        }
    }

    // 3. Exibir Alerta de Overflow
    if (calculo.overflow) {
        const alertBox = document.getElementById('overflow-alert');
        alertBox.style.display = 'block';
        if (typeof gsap !== 'undefined') {
            gsap.fromTo('.container', { x: -10 }, { x: 10, duration: 0.05, repeat: 5, yoyo: true });
        }
    }

    btn.disabled = false;
}
