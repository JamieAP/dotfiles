set nocompatible
set number
filetype off
syntax on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/vim-easy-align'

call vundle#end()            " required
filetype plugin indent on    " required
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
