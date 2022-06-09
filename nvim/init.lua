local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')
  Plug 'rust-lang/rust.vim'
  Plug 'EdenEast/nightfox.nvim'
  Plug('neoclide/coc.nvim', { branch = 'release' })
  Plug('junegunn/fzf', {
    ['do'] = function()
      vim.call('fzf#install')
    end
  })
  Plug 'junegunn/fzf.vim'
vim.call('plug#end')

-- set editor options using vimscript
vim.cmd 'source ~/.config/nvim/settings.vim'

vim.g.coc_global_extensions = {'coc-rust-analyzer'}