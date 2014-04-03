if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

" sample setting global variable
"if !exists("g:reddit_apicall_timeout")
"    let g:reddit_apicall_timeout=40
"endif



" define command in vimrc
command! -nargs=0 JsonFormat call JsonFormat()
nnoremap <C-S>j :JsonFormat<CR>

" Vim comments start with a double quote.
" Function definition is VimL. We can mix VimL and Python in
" function definition.
function! JsonFormat()


" We start the python code like the next line.

python << EOF
# the vim module contains everything we need to interface with vim from
# python. We need urllib2 for the web service consumer.
import vim
# we need json for parsing the response
import json

# we define a timeout that we'll use in the API call. We don't want
# users to wait much.
# sample read global variable 
#TIMEOUT = vim.eval("g:reddit_apicall_timeout")
# sample call vim command from python:
# vim.command("[vim-command-here]")

try:
    # load the text as json and pretty-print it.
    js = json.loads(''.join(vim.current.buffer[:]))
    # Get the posts and parse the json response
    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.
    # Here we delete all lines in the current buffer
    del vim.current.buffer[:]
    # append formatted json
    joutput = json.dumps(js, sort_keys=True, indent=4).split('\n')
    for l in joutput:
        vim.current.buffer.append(l)
except Exception as e:
    print e

EOF
" Here the python code is closed. We can continue writing VimL or python again.
endfunction
