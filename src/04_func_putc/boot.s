BOOT_LOAD equ 0x7c00 ; ブートプログラムのロード位置
ORG BOOT_LOAD ; ロードアドレスをアセンブラに指示

;-------------
; マクロ
;-------------
%include "../include/macro.s"

;-------------
; エントリーポイント
;-------------
entry:
    jmp ipl ; IPLへジャンプ

    ; BPB(BIOS Parameter Block)
    times 90 - ($ - $$) db 0x90 ; NOPで90バイト分のBPB領域を埋める
    

ipl: ; IPL(Initial Program Loader)

    ; セグメントレジスタを設定する
    cli ; 割り込みを禁止する
    mov ax, 0x0000 ; AX=0x0000
    mov ds, ax ; DS=0x0000
    mov es, ax ; ES=0x0000
    mov ss, ax ; ss=0x0000
    mov sp, BOOT_LOAD ; sp=0x7c00

    sti ; セグメントレジスタの初期化が終わったので、割り込みを許可する

    mov [BOOT.DRIVE], dl ; ブートドライブを保存
    
    ; 文字を表示
    cdecl   putc, word 'X'
    cdecl   putc, word 'Y'
    cdecl   putc, word 'Z'
    
    ; 処理の終了
    jmp $ ; while(1); 無限ループ

ALIGN 2, db 0
BOOT: ; ブートドライブに関する情報
.DRIVE: dw 0 ; ドライブ番号を保存する場所。(アセンブル段階では0を記入しておく)

;-------------
; モジュール
;-------------
%include    "../modules/real/putc.s"

; ブートフラグ
    times 510 - ($ - $$) db 0x00 ; 510バイト目まで0x00で埋める
    db 0x55, 0xAA ; ブートフラグ


