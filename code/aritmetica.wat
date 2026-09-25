(module $aritmetica.wasm
  (type (;0;) (func))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (func $__wasm_call_ctors (type 0))
  (func $soma (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    local.get 0
    i32.store offset=12
    local.get 4
    local.get 1
    i32.store offset=8
    local.get 4
    i32.load offset=12
    local.set 5
    local.get 4
    i32.load offset=8
    local.set 6
    local.get 5
    local.get 6
    i32.add
    local.set 7
    local.get 7
    return)
  (func $soma_segura (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 32
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    local.get 0
    i32.store offset=28
    local.get 5
    local.get 1
    i32.store offset=24
    local.get 5
    local.get 2
    i32.store offset=20
    local.get 5
    i32.load offset=20
    local.set 6
    i32.const 0
    local.set 7
    local.get 6
    local.get 7
    i32.store8
    local.get 5
    i32.load offset=28
    local.set 8
    local.get 5
    i32.load offset=24
    local.set 9
    local.get 8
    local.get 9
    i32.add
    local.set 10
    local.get 5
    local.get 10
    i32.store offset=16
    local.get 5
    i32.load offset=28
    local.set 11
    i32.const 31
    local.set 12
    local.get 11
    local.get 12
    i32.shr_s
    local.set 13
    i32.const 1
    local.set 14
    local.get 13
    local.get 14
    i32.and
    local.set 15
    local.get 5
    local.get 15
    i32.store offset=12
    local.get 5
    i32.load offset=24
    local.set 16
    i32.const 31
    local.set 17
    local.get 16
    local.get 17
    i32.shr_s
    local.set 18
    i32.const 1
    local.set 19
    local.get 18
    local.get 19
    i32.and
    local.set 20
    local.get 5
    local.get 20
    i32.store offset=8
    local.get 5
    i32.load offset=16
    local.set 21
    i32.const 31
    local.set 22
    local.get 21
    local.get 22
    i32.shr_s
    local.set 23
    i32.const 1
    local.set 24
    local.get 23
    local.get 24
    i32.and
    local.set 25
    local.get 5
    local.get 25
    i32.store offset=4
    local.get 5
    i32.load offset=12
    local.set 26
    block  ;; label = @1
      block  ;; label = @2
        local.get 26
        i32.eqz
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=8
        local.set 27
        local.get 27
        i32.eqz
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=4
        local.set 28
        i32.const 1
        local.set 29
        local.get 29
        local.set 30
        local.get 28
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 5
      i32.load offset=12
      local.set 31
      i32.const 0
      local.set 32
      local.get 32
      local.set 33
      block  ;; label = @2
        local.get 31
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=8
        local.set 34
        i32.const 0
        local.set 35
        local.get 35
        local.set 33
        local.get 34
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=4
        local.set 36
        i32.const 0
        local.set 37
        local.get 36
        local.set 38
        local.get 37
        local.set 39
        local.get 38
        local.get 39
        i32.ne
        local.set 40
        local.get 40
        local.set 33
      end
      local.get 33
      local.set 41
      local.get 41
      local.set 30
    end
    local.get 30
    local.set 42
    i32.const 1
    local.set 43
    local.get 42
    local.get 43
    i32.and
    local.set 44
    local.get 5
    local.get 44
    i32.store8 offset=3
    local.get 5
    i32.load8_u offset=3
    local.set 45
    i32.const 1
    local.set 46
    local.get 45
    local.get 46
    i32.and
    local.set 47
    block  ;; label = @1
      local.get 47
      i32.eqz
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=20
      local.set 48
      i32.const 1
      local.set 49
      local.get 48
      local.get 49
      i32.store8
    end
    local.get 5
    i32.load offset=16
    local.set 50
    local.get 50
    return)
  (func $sub (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    local.get 0
    i32.store offset=12
    local.get 4
    local.get 1
    i32.store offset=8
    local.get 4
    i32.load offset=12
    local.set 5
    local.get 4
    i32.load offset=8
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    return)
  (func $sub_segura (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 32
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    local.get 0
    i32.store offset=28
    local.get 5
    local.get 1
    i32.store offset=24
    local.get 5
    local.get 2
    i32.store offset=20
    local.get 5
    i32.load offset=20
    local.set 6
    i32.const 0
    local.set 7
    local.get 6
    local.get 7
    i32.store8
    local.get 5
    i32.load offset=28
    local.set 8
    local.get 5
    i32.load offset=24
    local.set 9
    local.get 8
    local.get 9
    i32.sub
    local.set 10
    local.get 5
    local.get 10
    i32.store offset=16
    local.get 5
    i32.load offset=28
    local.set 11
    i32.const 31
    local.set 12
    local.get 11
    local.get 12
    i32.shr_s
    local.set 13
    i32.const 1
    local.set 14
    local.get 13
    local.get 14
    i32.and
    local.set 15
    local.get 5
    local.get 15
    i32.store offset=12
    local.get 5
    i32.load offset=24
    local.set 16
    i32.const 31
    local.set 17
    local.get 16
    local.get 17
    i32.shr_s
    local.set 18
    i32.const 1
    local.set 19
    local.get 18
    local.get 19
    i32.and
    local.set 20
    local.get 5
    local.get 20
    i32.store offset=8
    local.get 5
    i32.load offset=16
    local.set 21
    i32.const 31
    local.set 22
    local.get 21
    local.get 22
    i32.shr_s
    local.set 23
    i32.const 1
    local.set 24
    local.get 23
    local.get 24
    i32.and
    local.set 25
    local.get 5
    local.get 25
    i32.store offset=4
    local.get 5
    i32.load offset=12
    local.set 26
    block  ;; label = @1
      block  ;; label = @2
        local.get 26
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=8
        local.set 27
        local.get 27
        i32.eqz
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=4
        local.set 28
        i32.const 1
        local.set 29
        local.get 29
        local.set 30
        local.get 28
        br_if 1 (;@1;)
      end
      local.get 5
      i32.load offset=12
      local.set 31
      i32.const 0
      local.set 32
      local.get 32
      local.set 33
      block  ;; label = @2
        local.get 31
        i32.eqz
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=8
        local.set 34
        i32.const 0
        local.set 35
        local.get 35
        local.set 33
        local.get 34
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=4
        local.set 36
        i32.const 0
        local.set 37
        local.get 36
        local.set 38
        local.get 37
        local.set 39
        local.get 38
        local.get 39
        i32.ne
        local.set 40
        i32.const -1
        local.set 41
        local.get 40
        local.get 41
        i32.xor
        local.set 42
        local.get 42
        local.set 33
      end
      local.get 33
      local.set 43
      local.get 43
      local.set 30
    end
    local.get 30
    local.set 44
    i32.const 1
    local.set 45
    local.get 44
    local.get 45
    i32.and
    local.set 46
    local.get 5
    local.get 46
    i32.store8 offset=3
    local.get 5
    i32.load8_u offset=3
    local.set 47
    i32.const 1
    local.set 48
    local.get 47
    local.get 48
    i32.and
    local.set 49
    block  ;; label = @1
      local.get 49
      i32.eqz
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=20
      local.set 50
      i32.const 1
      local.set 51
      local.get 50
      local.get 51
      i32.store8
    end
    local.get 5
    i32.load offset=16
    local.set 52
    local.get 52
    return)
  (func $mul (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    local.get 0
    i32.store offset=12
    local.get 4
    local.get 1
    i32.store offset=8
    local.get 4
    i32.load offset=12
    local.set 5
    local.get 4
    i32.load offset=8
    local.set 6
    local.get 5
    local.get 6
    i32.mul
    local.set 7
    local.get 7
    return)
  (func $mul_segura (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i64 i64 i64 i64 i64 i64 i32 i32 i32 i64 i64 i64 i64 i32 i32 i32 i32 i32 i64 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 32
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    local.get 0
    i32.store offset=28
    local.get 5
    local.get 1
    i32.store offset=24
    local.get 5
    local.get 2
    i32.store offset=20
    local.get 5
    i32.load offset=20
    local.set 6
    i32.const 0
    local.set 7
    local.get 6
    local.get 7
    i32.store8
    local.get 5
    i32.load offset=28
    local.set 8
    local.get 8
    local.set 9
    local.get 9
    i64.extend_i32_s
    local.set 10
    local.get 5
    i32.load offset=24
    local.set 11
    local.get 11
    local.set 12
    local.get 12
    i64.extend_i32_s
    local.set 13
    local.get 10
    local.get 13
    i64.mul
    local.set 14
    local.get 5
    local.get 14
    i64.store offset=8
    local.get 5
    i64.load offset=8
    local.set 15
    i64.const 2147483647
    local.set 16
    local.get 15
    local.set 17
    local.get 16
    local.set 18
    local.get 17
    local.get 18
    i64.gt_s
    local.set 19
    i32.const 1
    local.set 20
    local.get 19
    local.get 20
    i32.and
    local.set 21
    block  ;; label = @1
      block  ;; label = @2
        local.get 21
        br_if 0 (;@2;)
        local.get 5
        i64.load offset=8
        local.set 22
        i64.const -2147483648
        local.set 23
        local.get 22
        local.set 24
        local.get 23
        local.set 25
        local.get 24
        local.get 25
        i64.lt_s
        local.set 26
        i32.const 1
        local.set 27
        local.get 26
        local.get 27
        i32.and
        local.set 28
        local.get 28
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 5
      i32.load offset=20
      local.set 29
      i32.const 1
      local.set 30
      local.get 29
      local.get 30
      i32.store8
    end
    local.get 5
    i64.load offset=8
    local.set 31
    local.get 31
    i32.wrap_i64
    local.set 32
    local.get 32
    return)
  (memory (;0;) 2)
  (global $__stack_pointer (mut i32) (i32.const 66560))
  (global (;1;) i32 (i32.const 1024))
  (global (;2;) i32 (i32.const 1024))
  (global (;3;) i32 (i32.const 1024))
  (global (;4;) i32 (i32.const 66560))
  (global (;5;) i32 (i32.const 1024))
  (global (;6;) i32 (i32.const 66560))
  (global (;7;) i32 (i32.const 131072))
  (global (;8;) i32 (i32.const 0))
  (global (;9;) i32 (i32.const 1))
  (export "memory" (memory 0))
  (export "__wasm_call_ctors" (func $__wasm_call_ctors))
  (export "soma" (func $soma))
  (export "soma_segura" (func $soma_segura))
  (export "sub" (func $sub))
  (export "sub_segura" (func $sub_segura))
  (export "mul" (func $mul))
  (export "mul_segura" (func $mul_segura))
  (export "__dso_handle" (global 1))
  (export "__data_end" (global 2))
  (export "__stack_low" (global 3))
  (export "__stack_high" (global 4))
  (export "__global_base" (global 5))
  (export "__heap_base" (global 6))
  (export "__heap_end" (global 7))
  (export "__memory_base" (global 8))
  (export "__table_base" (global 9))
  (@custom "name" "\00\10\0faritmetica.wasm\01I\07\00\11__wasm_call_ctors\01\04soma\02\0bsoma_segura\03\03sub\04\0asub_segura\05\03mul\06\0amul_segura\07\12\01\00\0f__stack_pointer")
  (@custom "producers" "\01\0cprocessed-by\01\05clang\0618.1.8")
  (@custom "target_features" "\02+\0fmutable-globals+\08sign-ext"))
