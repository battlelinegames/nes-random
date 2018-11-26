@del random.o
@del random.nes
@del random.map.txt
@del random.labels.txt
@del random.nes.ram.nl
@del random.nes.0.nl
@del random.nes.1.nl
@echo.
@echo Compiling...
cc65\bin\ca65 .\src\random.asm -g -o random.o
@IF ERRORLEVEL 1 GOTO failure
@echo.
@echo Linking...
cc65\bin\ld65 -o random.nes -C random.cfg random.o -m random.map.txt -Ln random.labels.txt --dbgfile random.nes.dbg
@IF ERRORLEVEL 1 GOTO failure
@echo.
@echo Success!
@time /t
@pause
@GOTO endbuild
:failure
@echo.
@echo Build error!
@pause
:endbuild
