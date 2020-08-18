%macro  cdecl 1-*.nolist

    %rep %0 - 1
        push    %{-1:-1}
        %rotate -1
    %endrep
    %rotate -1 ; 関数の位置を第一引数にする
        call    %1 ; 関数を呼び出す
    %if 1 < %0 ; 引数を持つ場合
        add     sp, (__BITS__ >> 3) * (%0 - 1)
    %endif

%endmacro