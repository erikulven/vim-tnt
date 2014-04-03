if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

" --------------------------------
" Add our plugin to the path
" --------------------------------
python import sys
python import vim
python sys.path.append(vim.eval('expand("<sfile>:h")'))


" --------------------------------
"  Function(s)
" --------------------------------
function! JsonFormat()
python << endOfPython

from vim_tnt import format_json

try:
    js = format_json(''.join(vim.current.buffer[:]))
    del vim.current.buffer[:]
    for l in js:
        vim.current.buffer.append(l)
except Exception as e:
    print e


endOfPython
endfunction

" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! JsonFormat call JsonFormat()
