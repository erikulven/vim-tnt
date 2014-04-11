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

" copied from xolox's answer at stackoverflow. Thanks xolox!
"http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! SelectedText()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction


function! JsonFormat()
python << endOfPython

from vim_tnt import format_json

try:
    js = format_json(''.join(vim.current.buffer[:]))
    del vim.current.buffer[:]
    counter = 0
    for l in js:
        vim.current.buffer.append(l, counter)
        counter += 1
    vim.command("set ft=javascript")
except Exception as e:
    print e


endOfPython
endfunction


function! UrlPathEncode(url)
python << endOfPython

from vim_tnt import quote_plus, actual_text

try:
    selected = vim.eval("a:url") or actual_text()
    if selected is not None:
        print "url-path-encoded: %s" % quote_plus(selected)
    else:
        print "No selection!"
except Exception as e:
    print e

endOfPython
endfunction


function! UrlPathDecode(url)
python << endOfPython

from vim_tnt import unquote_plus, actual_text

try:
    selected = vim.eval("a:url") or actual_text()
    print "url-path-decoded: %s" % unquote_plus(selected)
except Exception as e:
    print e

endOfPython
endfunction


function! UrlEncode(url)
python << endOfPython

from vim_tnt import quote, actual_text

try:
    selected = vim.eval("a:url") or actual_text()
    print "url-encoded: %s" % quote(selected)
except Exception as e:
    print e

endOfPython
endfunction


function! UrlDecode(url)
python << endOfPython

from vim_tnt import unquote, actual_text

try:
    selected = vim.eval("a:url") or actual_text()
    print "url-decoded: %s" % unquote(selected)
except Exception as e:
    print e

endOfPython
endfunction


function! FoldPyDocstrings()
python << endOfPython

from vim_tnt import fold_python_docstrings

try:
    fold_python_docstrings()
except Exception as e:
    print e

endOfPython
endfunction


" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! JsonFormat call JsonFormat()
" command! UrlPathEncode call UrlPathEncode()
" command! UrlPathDecode call UrlPathDecode()
" command! UrlEncode call UrlEncode()
" command! UrlDecode call UrlDecode()
" command! SelectedText call SelectedText()
command! FoldPyDoc call FoldPyDocstrings()
