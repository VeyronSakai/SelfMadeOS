#!/bin/sh
nasm boot.s -o boot.img -l boot.lst
qemu-system-i386 -rtc base=localtime -drive file=boot.img,format=raw -boot order=c