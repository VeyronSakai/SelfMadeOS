putc:
    ; スタックフレームの構築
    push    bp              ;   +4| 出力文字、引数
    mov     bp, sp          ;   +2| 呼び出し元のアドレス
                            ; BP+0| 元のBP

    ; レジスタの保存
    push    ax
    push    bx

    ; 処理の開始
    mov     al, [bp+4]      ; 出力文字を取得
    mov     ah, 0x0E        ; テレタイプ式1文字入力
    mov     bx, 0x0000      ; ページ番号と文字色を0に設定
    int     0x10            ; ビデオBIOSコール

    ; レジスタの復帰
    pop     bx
    pop     ax

    ; スタックフレームの破棄
    mov     sp, bp
    pop     bp

    ret