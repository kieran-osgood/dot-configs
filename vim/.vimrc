" https://github.com/JetBrains/ideavim?tab=readme-ov-file
"
" Helpful reminder that you can enable jetbrains to print action
" https://github.com/JetBrains/ideavim?tab=readme-ov-file#finding-action-ids
if has('ide')
    " Syncs p/P with system clipboard
    set clipboard+=unnamed

    """ Map leader to space ---------------------
    let mapleader=" "
    " set selectmode=mouse,key,cmd,ideaselection


    " Show a few lines of context around the cursor. Note that this makes the
    " text scroll if you mouse-click near the start or end of the window.
    set scrolloff=5

    " Do incremental searching.
    set incsearch

    " Don't use Ex mode, use Q for formatting.
    " map Q gq

    set relativenumber

    map         gcc <Action>(CommentByLineComment)
    " Didnt work for some reason 
    " xmap    gc <Action>(CommentByLineComment) 
    map         gh <Action>(ShowErrorDescription)
    map <leader>cf <Action>(ReformatCode)
    map <leader>ca <Action>(ShowIntentionActions)
    map <leader>rr <Action>(RenameElement)

    " Treesitter emulation - overrides in insert to give code completion
    map <C-space> <Action>(EditorSelectWord)
    imap <C-space> <Action>(CodeCompletion)

    map <leader>vr <Action>(IdeaVim.ReloadVimRc.reload)
    " duplicate line 
    nnoremap <C-d> yyp

    nnoremap <leader>ut :action ToggleDistractionFreeMode<CR>
    nnoremap <leader><leader> :action GotoFile<CR>

    nnoremap <leader>wv :action SplitVertically<CR>
    nnoremap <leader>ws :action SplitHorizontally<CR>

    nnoremap <leader>wa :action CloseAllEditors<CR>


    " code navigation
    " nnoremap gd :action GotoImplementation<CR>

    " code selection
    nnoremap <C-j> :action MoveLineDown<CR>
    nnoremap <C-k> :action MoveLineUp<CR>

    " debugging
    nnoremap <leader>dd :action Debug<CR>
    nnoremap <leader>ds :action Stop<CR>
    nnoremap <leader>db :action ToggleLineBreakpoint<CR>
    nnoremap ]d :action GotoNextError<CR>
    nnoremap [d :action GotoPreviousError<CR>

    " mappings and options that exist only in IdeaVim
    " map <leader>gd <Action>(GotoFile)
    " map <leader>g <Action>(FindInPath)
    " map <leader>b <Action>(Switcher)
    set which-key
    " Ensures whichkey doesnt disappear after timeout
    set notimeout

    Plug 'machakann/vim-highlightedyank'

    Plug 'terryma/vim-multiple-cursors'
      " Remap multiple-cursors shortcuts to match terryma/vim-multiple-cursors
      nmap <C-n> <Plug>NextWholeOccurrence
      xmap <C-n> <Plug>NextWholeOccurrence
      nmap g<C-n> <Plug>NextOccurrence
      xmap g<C-n> <Plug>NextOccurrence
      xmap <C-x> <Plug>SkipOccurrence
      xmap <C-p> <Plug>RemoveOccurrence

      " Note that the default <A-n> and g<A-n> shortcuts don't work on Mac due to dead keys.
      " <A-n> is used to enter accented text e.g. ñ
      " Feel free to pick your own mappings that are not affected. I like to use <leader>
      nmap <leader><C-n> <Plug>AllWholeOccurrences
      xmap <leader><C-n> <Plug>AllWholeOccurrences
      nmap <leader>g<C-n> <Plug>AllOccurrences
      xmap <leader>g<C-n> <Plug>AllOccurrences
else
    " some mappings for Vim/Neovim
endif
