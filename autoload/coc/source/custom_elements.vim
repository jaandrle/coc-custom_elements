" vim source for custom_elements
let s:sources= []
let s:list_tags= []
let s:list= []

function! coc#source#custom_elements#AddSource(path)
    let s:sources+= [ a:path ]
    let json= json_decode(join(readfile(a:path)))
    for i_tag in json.tags
        let s:list_tags+= [ { 'word': i_tag.name, 'info': i_tag.description } ]
        let s:list+= map(i_tag.attributes, { key, val -> { 'word': val.name, 'info': val.description } })
    endfor
endfunction
function! coc#source#custom_elements#OpenSource(...)
    let src_id= a:0 ? a:1 : 0
    execute 'e '.s:sources[src_id]
endfunction
function! coc#source#custom_elements#Update() abort
    let sources= s:sources
    let s:sources= []
    let s:list= []
    let s:list_tags= []
    for item in sources
        call coc#source#custom_elements#AddSource(item)
    endfor
endfunction

function! coc#source#custom_elements#init() abort
    return {
        \ 'priority': 9,
        \ 'shortcut': 'HTML CE',
        \ 'triggerCharacters': '<',
        \ 'filetypes': [ 'html', 'javascript' ]
        \}
endfunction

function! coc#source#custom_elements#complete(opt, cb) abort
    let pre_char= a:opt.line[a:opt.col-1]
    if pre_char=='<' || pre_char=='"' || pre_char==''''
        call a:cb(s:list_tags, s:list_tags)
    else
        call a:cb(s:list, s:list)
    endif
endfunction

function! coc#source#custom_elements#hover(word) abort
    if s:sources->len()==0 | return 0 | endif
    
    let out= (s:list_tags[:]->filter({ k, v -> v.word==a:word })[:]->map({ k, v -> v.info })
            \ + s:list[:]->filter({ k, v -> v.word==a:word })[:]->map({ k, v -> v.info }))
            \ ->join('\n\n')
    if out=='' | return 0 | endif
    
    call popup_atcursor(out->split('\n'), {})
    return 1
endfunction
