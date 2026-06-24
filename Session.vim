let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
doautoall SessionLoadPre
silent only
silent tabonly
cd ~/dotfiles/nvim/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess+=aoO
badd +167 plugin/40_plugins.lua
badd +164 plugin/30_mini.lua
badd +15 after/lsp/lua_ls.lua
badd +1 after/lsp/dotnet.lua
badd +1 health://
badd +1 after/lsp/easy_dotnet.lua
badd +71 plugin/20_keymaps.lua
badd +27 plugin/10_options.lua
argglobal
%argdel
edit plugin/40_plugins.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 60 + 61) / 123)
exe 'vert 1resize ' . ((&columns * 265 + 133) / 267)
exe '2resize ' . ((&lines * 60 + 61) / 123)
exe 'vert 2resize ' . ((&columns * 1 + 133) / 267)
exe '3resize ' . ((&lines * 59 + 61) / 123)
argglobal
balt plugin/30_mini.lua
setlocal foldmethod=indent
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=10
setlocal foldminlines=1
setlocal foldnestmax=10
setlocal foldenable
163
sil! normal! zo
322
sil! normal! zo
331
sil! normal! zo
332
sil! normal! zo
let s:l = 166 - ((52 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 166
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("plugin/30_mini.lua", ":p")) | buffer plugin/30_mini.lua | else | edit plugin/30_mini.lua | endif
if &buftype ==# 'terminal'
  silent file plugin/30_mini.lua
endif
balt plugin/40_plugins.lua
setlocal foldmethod=indent
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=10
setlocal foldminlines=1
setlocal foldnestmax=10
setlocal foldenable
72
sil! normal! zo
222
sil! normal! zo
534
sil! normal! zo
536
sil! normal! zo
536
sil! normal! zo
538
sil! normal! zo
540
sil! normal! zo
738
sil! normal! zo
let s:l = 164 - ((20 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 164
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("after/lsp/lua_ls.lua", ":p")) | buffer after/lsp/lua_ls.lua | else | edit after/lsp/lua_ls.lua | endif
if &buftype ==# 'terminal'
  silent file after/lsp/lua_ls.lua
endif
balt plugin/40_plugins.lua
setlocal foldmethod=indent
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=10
setlocal foldminlines=1
setlocal foldnestmax=10
setlocal foldenable
14
sil! normal! zo
15
sil! normal! zo
let s:l = 15 - ((14 * winheight(0) + 29) / 59)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 05|
wincmd w
exe '1resize ' . ((&lines * 60 + 61) / 123)
exe 'vert 1resize ' . ((&columns * 265 + 133) / 267)
exe '2resize ' . ((&lines * 60 + 61) / 123)
exe 'vert 2resize ' . ((&columns * 1 + 133) / 267)
exe '3resize ' . ((&lines * 59 + 61) / 123)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
