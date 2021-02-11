PATH C:\Program Files\7-Zip;%Path%
dir /b /o:n /a:d src
for /f "usebackq tokens=*" %%d in (`dir /b /o:n /a:d src`) do (
    if NOT %%d == global (7z a -tzip out/%%d.zip src/%%d src/global)
)
