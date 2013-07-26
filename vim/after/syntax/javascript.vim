" Highlight CodeKit include statements

syntax region CodeKitInclude matchgroup=CodeKitIncludeKeyword
       \ start=/\/\/@codekit-\(ap\|pre\)pend / end=/;/

highlight default link CodeKitInclude String
highlight default link CodeKitIncludeKeyword PreProc
