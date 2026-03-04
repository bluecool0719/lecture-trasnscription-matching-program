@echo off
chcp 65001 > nul
title 라이브러리 설치 중...
echo.
echo  처음 한 번만 실행하면 됩니다.
echo  라이브러리를 다운로드하는 중...
echo.

if not exist libs mkdir libs

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "$libs = @{'react.js'='https://unpkg.com/react@18/umd/react.development.js';'react-dom.js'='https://unpkg.com/react-dom@18/umd/react-dom.development.js';'babel.js'='https://unpkg.com/@babel/standalone/babel.min.js';'pdf.js'='https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js';'pdf.worker.js'='https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';'docx.js'='https://unpkg.com/docx@8.5.0/build/index.js';'filesaver.js'='https://unpkg.com/file-saver@2.0.5/dist/FileSaver.min.js';'jspdf.js'='https://unpkg.com/jspdf@2.5.1/dist/jspdf.umd.min.js'}; foreach ($f in $libs.Keys) { Write-Host ('다운로드: '+$f); Invoke-WebRequest -Uri $libs[$f] -OutFile ('libs\'+$f) -UseBasicParsing }"

echo.
echo  설치 완료! 이제 run.bat 을 실행하세요.
echo.
pause
