memcpy:
    ; スタックフレームの構築
    push bp
    mov bp, sp

    ; レジスタの保存
    push cx
    push si
    push di

    ; バイト単位でのコピー
    cld
    mov di, [bp+4]
    mov si, [bp+6]
    mov cx, [bp+8]
    rep movsb

    ; レジスタの復帰
    pop di
    pop si
    pop cx
    
    ; スタックフレームの破棄
    mov sp, bp
    pop bp
    ret