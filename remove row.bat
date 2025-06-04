echo ========================================
echo   BATCH REMOVE FIRST 7 ROWS TOOL
echo ========================================
echo.

:: Pilih mode operasi
echo Pilih mode:
echo 1. Proses satu file
echo 2. Proses semua file CSV dalam folder
echo 3. Proses semua file TXT dalam folder
echo 4. Proses semua file dalam folder (semua ekstensi)
echo.
set /p mode="Pilih mode (1-4): "

if "%mode%"=="1" goto :single_file
if "%mode%"=="2" goto :batch_csv
if "%mode%"=="3" goto :batch_txt  
if "%mode%"=="4" goto :batch_all

:single_file
set /p file="Masukkan path file: "
call :process_single_file "%file%"
goto :end

:batch_csv
set /p folder="Masukkan path folder: "
echo Memproses semua file CSV dalam folder...
for %%f in ("%folder%\*.csv") do (
    echo Memproses: %%f
    call :process_single_file "%%f"
)
goto :end

:batch_txt
set /p folder="Masukkan path folder: "
echo Memproses semua file TXT dalam folder...
for %%f in ("%folder%\*.txt") do (
    echo Memproses: %%f
    call :process_single_file "%%f"
)
goto :end

:batch_all
set /p folder="Masukkan path folder: "
echo Memproses semua file dalam folder...
for %%f in ("%folder%\*.*") do (
    if "%%~xf" NEQ ".bat" if "%%~xf" NEQ ".exe" (
        echo Memproses: %%f
        call :process_single_file "%%f"
    )
)
goto :end

:process_single_file
set "input=%~1"
if not exist "%input%" (
    echo File tidak ditemukan: %input%
    goto :eof
)

:: Buat nama output
for %%i in ("%input%") do (
    set "output=%%~di%%~pi%%~ni_cleaned%%~xi"
)

:: Hapus 7 baris pertama
more +8 "%input%" > "%output%"

if exist "%output%" (
    echo ✓ Berhasil: %output%
) else (
    echo ✗ Gagal: %input%
)
goto :eof

:end
echo.
echo Semua proses selesai!
pause