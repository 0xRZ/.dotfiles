let s:plug_dir = expand('/tmp/plugged/vim-plug')
if !filereadable(s:plug_dir .. '/plug.vim')
  execute printf('!curl -fLo %s/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', s:plug_dir)
end

call plug#begin(s:plug_dir)

call plug#end()
PlugInstall | quit

lua << EOF
EOF

nnoremap <silent> <space>a :<CR>
