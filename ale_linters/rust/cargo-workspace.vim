let g:ale_rust_cargo_use_check = get(g:, 'ale_rust_cargo_use_check', 0)

function! ale_linters#rust#cargoworkspace#GetCargoExecutable(bufnr) abort
    if ale#path#FindNearestFile(a:bufnr, 'Cargo.toml') !=# ''
        return 'cargo'
    else
        " if there is no Cargo.toml file, we don't use cargo even if it exists,
        " so we return '', because executable('') apparently always fails
        return ''
    endif
endfunction

function! ale_linters#rust#cargoworkspace#GetCommand(buffer) abort
    let l:command = ale#Var(a:buffer, 'rust_cargo_use_check')
    \   ? 'check'
    \   : 'build'

    return 'cargo-workspace ' . l:command . ' --frozen --message-format=json -q'
endfunction

call ale#linter#Define('rust', {
\   'name': 'cargo-workspace',
\   'executable_callback': 'ale_linters#rust#cargoworkspace#GetCargoExecutable',
\   'command_callback': 'ale_linters#rust#cargoworkspace#GetCommand',
\   'callback': 'ale#handlers#rust#HandleRustErrors',
\   'output_stream': 'stdout',
\   'lint_file': 1,
\})
