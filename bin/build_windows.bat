call "C:\Program Files\7-Zip\7z.exe" a -r ld54.zip -w ..\lua\* -xr!bin -xr!builds -xr!steam -xr!.git -xr!.yue
rename ld54.zip ld54.love
copy /b "love.exe"+"ld54.love" "ld54.exe"
del ld54.love
mkdir ld54
for %%I in (*.dll) do copy %%I ld54\
for %%I in (*.txt) do copy %%I ld54\
copy ld54.exe ld54\
del ld54.exe
call "C:\Program Files\7-Zip\7z.exe" a ld54.zip ld54\
del /q ld54\
rmdir /q ld54\
copy ld54.zip ..\builds\windows\
del ld54.zip
