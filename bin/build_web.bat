cd /D "%~dp0"
call "C:\Program Files\7-Zip\7z.exe" a -r ld54.zip -w ..\lua\* -xr!bin -xr!builds -xr!steam -xr!.git -xr!*.yue
rename ld54.zip ld54.love
call npx love.js.cmd -m 52228800 -t ld54 E:\code\ld54\bin\ld54.love ..\builds\web
del ld54.love
copy index.html ..\builds\web\index.html
