let wasmInstance = null;

    // 1. Carregar o arquivo WebAssembly compilado (.wasm)
    async function carregarWasm() {
        try {
            const response = await fetch('aritmetica.wasm');
            const bytes = await response.arrayBuffer();
            // Aloca a memória para o ponteiro 'teve_overflow' se necessário
            const memory = new WebAssembly.Memory({ initial: 1 });
            const results = await WebAssembly.instantiate(bytes, {
                env: { memory }
            });
            wasmInstance = results.instance;
            console.log("WASM carregado com sucesso!");
        } catch (err) {
            console.error("Erro ao carregar WASM:", err);
        }
    }
    carregarWasm();

    // Utility: Converter número JS para binário de 32 bits (Complemento de Dois)
    function int32ParaBinario(num) {
        return (num >>> 0).toString(2).padStart(32, '0');
    }

    // Renderizar os blocos em branco/iniciais
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

    // 2. Animação Passo a Passo da Soma Bit a Bit (LSB ao MSB)
    async function executarAnimacao() {
        const a = parseInt(document.getElementById('numA').value) || 0;
        const b = parseInt(document.getElementById('numB').value) || 0;

        const binA = int32ParaBinario(a);
        const binB = int32ParaBinario(b);

        document.getElementById('overflow-alert').style.display = 'none';

        // Atualizar visualmente operandos A e B
        for (let i = 0; i < 32; i++) {
            const elA = document.getElementById(`grid-a-${i}`);
            const elB = document.getElementById(`grid-b-${i}`);
            elA.innerText = binA[i];
            elB.innerText = binB[i];
            elA.className = `bit-box ${binA[i] === '1' ? 'active' : ''}`;
            elB.className = `bit-box ${binB[i] === '1' ? 'active' : ''}`;
        }

        // Animação da direita para a esquerda (bit 31 até 0, sendo 31 o LSB na string)
        let carry = 0;
        for (let i = 31; i >= 0; i--) {
            const bitA = parseInt(binA[i]);
            const bitB = parseInt(binB[i]);
            
            // Highlight na coluna atual
            const elA = document.getElementById(`grid-a-${i}`);
            const elB = document.getElementById(`grid-b-${i}`);
            const elRes = document.getElementById(`grid-res-${i}`);
            const elCarry = document.getElementById(`grid-carry-${i}`);

            elA.classList.add('current');
            elB.classList.add('current');

            // Calcular bit da soma e próximo carry
            const sumBit = bitA ^ bitB ^ carry;
            const nextCarry = (bitA & bitB) | (carry & (bitA ^ bitB));

            // Tempo de espera (Delay) para criar o efeito de animação passo a passo
            await new Promise(r => setTimeout(r, 100));

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

        // 3. Execução da Função WASM e Checagem de Overflow
        if (wasmInstance) {
            // Exemplo invocando sua função do WASM (caso tenha exportado)
            // Lembre-se de passar ponteiro/memória se sua função em C usar bool*
            const resultadoWasm = wasmInstance.exports.soma(a, b);
            
            // Exemplo de detecção visual do flag de overflow
            // Detecção visual em complemento de dois:
            // Se dois positivos gerarem um negativo, ou dois negativos gerarem um positivo
            const overflow = ((a > 0 && b > 0 && resultadoWasm < 0) || (a < 0 && b < 0 && resultadoWasm >= 0));

            if (overflow) {
                const alertBox = document.getElementById('overflow-alert');
                alertBox.style.display = 'block';
                // Efeito visual com GSAP para tremer a tela no overflow
                gsap.fromTo('.container', { x: -10 }, { x: 10, duration: 0.05, repeat: 5, yoyo: true });
            }
        }
    }
