@echo off
chcp 65001 > nul
title 강의록 자동 생성기

echo.
echo  잠시 후 브라우저가 자동으로 열립니다...
echo  이 창을 닫으면 프로그램이 종료됩니다.
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1"

pause
