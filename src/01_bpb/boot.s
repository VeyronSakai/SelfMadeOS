; エントリーポイント
entry:
    jmp ipl ; IPLへジャンプ

    ; BPB(BIOS Parameter Block)
    times 90 - ($ - $$) db 0x90 ; NOPで90バイト分のBPB領域を埋める

    ; IPL(Initial Program Loader)
ipl:
    ; 処理の終了
    jmp $ ; while(1); 無限ループ

; ブートフラグ
    times 510 - ($ - $$) db 0x00 ; 510バイト目まで0x00で埋める
    db 0x55, 0xAA ; ブートフラグ