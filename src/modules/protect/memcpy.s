memcpy:
    ; スタックフレームの構築
    push ebp
    mov ebp, esp

    ; レジスタの保存
    push ecx
    push esi
    push edi

    ; バイト単位でのコピー
    cld
    mov edi, [ebp+8]
    mov esi, [ebp+12]
    mov ecx, [ebp+16]
    rep movsb ; while(*DI++ = *SI++)

    ; レジスタの復帰
    pop edi 
    pop esi
    pop ecx
    
    ; スタックフレームの破棄
    mov esp, ebp
    pop ebp
    ret