@echo off
setlocal enabledelayedexpansion
title Makefile
set SCRIPT_PATH=%~dp0
set PROTO_PATH=%SCRIPT_PATH%..\proto\*.proto
for %%I in (erl.exe) do if "%%~$PATH:I"=="" (
	echo cannot find erl.exe, please install erlang and put the path into PATH
	goto saygoodbye
)
erl -make
for /f "delims=" %%I in ('dir /b /a-d /s %PROTO_PATH%') do (
	set filename=%%I
	for %%a in ("!filename!") do echo compile: %%~na%%~xa
	erl -pa ebin -noshell -s protobuffs_compile scan_file_src %%I -s erlang halt
)