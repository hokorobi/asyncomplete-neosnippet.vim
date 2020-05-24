let g:asyncomplete_neosnippet_match_pattern = get(g:, 'asyncomplete_buffer_match_pattern', '\w\+$')

function! asyncomplete#sources#neosnippet#get_source_options(opts)
    let l:defaults={'name': 'neosnippet',
                \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
                \ 'whitelist': ['*']}
    return extend(l:defaults, a:opts)
endfunction

function! asyncomplete#sources#neosnippet#completor(opt, ctx)
    let l:snips = values(neosnippet#helpers#get_completion_snippets())

    let l:matches = []

    let l:col = a:ctx['col']
    let l:typed = a:ctx['typed']

    let l:kw = matchstr(l:typed, g:asyncomplete_neosippet_match_pattern)
    let l:kwlen = len(l:kw)

    let l:matches = map(l:snips,'{"word":v:val["word"],"dup":1,"icase":1,"menu": "Snips: " . v:val["menu_abbr"]}')
    let l:startcol = l:col - l:kwlen

    call asyncomplete#complete(a:opt['name'], a:ctx, l:startcol, l:matches)
endfunction
