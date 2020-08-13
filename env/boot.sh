#!/bin/sh

qemu-system-i386 -rtc base=localtime -drive file=$1,format=raw -boot order=c