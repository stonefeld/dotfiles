" ---------- Terminal ---------- "
" Goto to the corresponding terminal buffer.
nmap <leader>tj :call GoToBuffer(0)<CR>
nmap <leader>tk :call GoToBuffer(1)<CR>
nmap <leader>tl :call GoToBuffer(2)<CR>
nmap <leader>t; :call GoToBuffer(3)<CR>

" Set terminal buffer shortcut.
nmap <leader>tsj :call SetBuffer(0)<CR>
nmap <leader>tsk :call SetBuffer(1)<CR>
nmap <leader>tsl :call SetBuffer(2)<CR>
nmap <leader>ts; :call SetBuffer(3)<CR>

" Open different instances of neovim terminal.
nnoremap <leader>tt :terminal<CR>
nnoremap <leader>tg :terminal lazygit<CR>
nnoremap <leader>tf :terminal ranger<CR>

function! GoToBuffer(ctrlId)
  if (a:ctrlId > 9) || (a:ctrlId < 0)
    echo "CtrlID must be between 0 - 9"
    return
  end

  let contents = g:win_ctrl_buf_list[a:ctrlId]
  if type(l:contents) != v:t_list
    echo "Nothing There"
    return
  end

  let bufh = l:contents[1]
  call nvim_win_set_buf(0, l:bufh)
endfunction

let g:win_ctrl_buf_list = [0, 0, 0, 0]
function! SetBuffer(ctrlId)
  if has_key(b:, "terminal_job_id") == 0
    echo "You must be in a terminal to execute this ommand"
    return
  end

  if (a:ctrlId > 9) || (a:ctrlId < 0)
    echo "CtrlID must be between 0 - 9"
    return
  end

  let g:win_ctrl_buf_list[a:ctrlId] = [b:terminal_job_id, nvim_win_get_buf(0)]
endfunction

function! SendTerminalCommand(ctrlId, command)
  if (a:ctrlId > 9) || (a:ctrlId < 0)
    echo "CtrlID must be between 0 - 9"
    return
  end

  let contents = g:win_ctrl_buf_list[a:ctrlId]
  if type(l:contents) != v:t_list
    echo "Nothing There"
    return
  end

  let job_id = l:contents[0]
  call chansend(job_id, command)
endfunction

" Disable scrolloff on terminal to avoid glitch.
augroup Terminal
  autocmd!

  autocmd TermEnter * set scrolloff=0
  autocmd TermEnter * set sidescrolloff=0
  autocmd TermEnter * set nocursorline
  autocmd TermEnter * set nonu
  autocmd TermEnter * set norelativenumber
  autocmd TermEnter * set scrollback=458

  autocmd TermLeave * set scrolloff=8
  autocmd TermLeave * set sidescrolloff=8
  autocmd TermLeave * set cursorline
  autocmd TermLeave * set nu
  autocmd TermLeave * set relativenumber
augroup END
