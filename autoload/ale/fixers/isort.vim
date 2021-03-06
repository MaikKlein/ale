" Author: w0rp <devw0rp@gmail.com>
" Description: Fixing Python imports with isort.

function! ale#fixers#isort#Fix(buffer) abort
    let l:config = ale#path#FindNearestFile(a:buffer, '.isort.cfg')
    let l:config_options = !empty(l:config)
    \   ? ' --settings-path ' . ale#Escape(l:config)
    \   : ''

    return {
    \   'command': 'isort' . l:config_options . ' -',
    \}
endfunction
