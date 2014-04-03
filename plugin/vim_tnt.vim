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


function! UrlPathEncode()
python << endOfPython

from vim_tnt import quote_plus

try:
    print "url-path-encoded: %s" % quote_plus(''.join(vim.current.buffer[:]))
except Exception as e:
    print e

endOfPython
endfunction


function! UrlPathDecode()
python << endOfPython

from vim_tnt import unquote_plus

try:
    print "url-path-decoded: %s" % unquote_plus(''.join(vim.current.buffer[:]))
except Exception as e:
    print e

endOfPython
endfunction


function! UrlEncode()
python << endOfPython

from vim_tnt import quote

try:
    print "url-encoded: %s" % quote(''.join(vim.current.buffer[:]))
except Exception as e:
    print e

endOfPython
endfunction


function! UrlDecode()
python << endOfPython

from vim_tnt import unquote

try:
    print "url-decoded: %s" % unquote(''.join(vim.current.buffer[:]))
except Exception as e:
    print e

endOfPython
endfunction



" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! JsonFormat call JsonFormat()
command! UrlPathEncode call UrlPathEncode()
command! UrlPathDecode call UrlPathDecode()
command! UrlEncode call UrlEncode()
command! UrlDecode call UrlDecode()
