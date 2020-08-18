BOOT_LOAD equ 0x7c00 ; ブートプログラムのロード位置
ORG BOOT_LOAD ; ロードアドレスをアセンブラに指示

entry: ; エントリーポイント
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
    mov al, 'A' ; AL = 出力文字
    mov ah, 0x0E ; テレタイプ式1文字
    mov bx, 0x0000 ; ページ番号と文字色を０に設定
    int 0x10 ; ビデオBIOSコール
    
    ; 処理の終了
    jmp $ ; while(1); 無限ループ

ALIGN 2, db 0
BOOT: ; ブートドライブに関する情報
.DRIVE: dw 0 ; ドライブ番号を保存する場所。(アセンブル段階では0を記入しておく)

; ブートフラグ
    times 510 - ($ - $$) db 0x00 ; 510バイト目まで0x00で埋める
    db 0x55, 0xAA ; ブートフラグ


