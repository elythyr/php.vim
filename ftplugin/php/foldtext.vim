if exists('b:phpfold_text') && !b:phpfold_text
  finish
endif

set foldtext=PhpFoldText()

function! PhpFoldText() " {{{
  let l:firstline = getline(v:foldstart)

  if l:firstline =~ '\v^\s*/\*\*?\s*$' " Multi lines Comments
    let l:result = s:MultiLinesComment()
  else
    let l:result = foldtext()
  endif

  return l:result
endfunction " }}}

function! s:MultiLinesComment()
  " Find the first non empty line and trim the content
  for l:linenr in range(v:foldstart, v:foldend)
    let l:content = substitute(getline(l:linenr), '\v^\s*%(%(/\*\*?)|*)\s*(.{-})\s*$', '\1', '')

    if !empty(l:content)
      break
    endif
  endfor

  let l:numberwidth    = max([strlen(line('$') + 1), v:version < 701 ? 4 : &numberwidth])
  let l:spaceavailable = winwidth(0) - &foldcolumn - (&number ? l:numberwidth : 0)

  " Creates the end of the line
  let l:end  = printf(' %*d lines +%s', l:numberwidth, v:foldend - v:foldstart + 1, v:folddashes)
  let l:spaceavailable -= strwidth(l:end)

  let l:text = substitute(getline(v:foldstart), '\v^(\s*/\*\*?)', '\1', '') " The comment type
  let l:text .= ' ' . l:content " The content

  let l:text = strpart(l:text, 0, l:spaceavailable) " Shrink to fit in the window
  let l:spaceavailable -= strwidth(l:text)

  " Creates the string to fill the space between the left an right part
  let l:filler = repeat(matchstr(&fillchars, 'fold:\zs.'), l:spaceavailable)

  return l:text . l:filler . l:end
endfunction
