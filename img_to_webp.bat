@echo off
title IMG to WEBP
setlocal enabledelayedexpansion
:: ---------- START ----------
:start
cls
echo.
color f
echo Hi there, welcome to Bulk File Renamer
echo         by Github: @curlynoemi
echo.
echo ---------------------------------------------------------
echo.

:: ---------- CHECK IF CWEB IS INSTALLED ----------
where cwebp >nul 2>nul
if %errorlevel% neq 0 (
    goto nowebp
)

:: ---------- CONVERSION ----------
echo Enter the folder path of the files you want to convert. 
echo It must include ONLY the files you want to convert.
echo.
set /p "folderPath= "
set /p "allProceed=Can I proceed? (y/n): "

if /i "%allProceed%"=="y" (
    cls
    echo.
    for %%i in ("%folderPath%\*.jpg" "%folderPath%\*.jpeg" "%folderPath%\*.png") do (
        if exist "%%i" (
            set "fileName=%%~nxi"
            echo Converting !fileName! to WebP...
            cwebp "%%i" -q 100 -o "!folderPath!\!fileName:.=!_webp"
            cls
            echo.
        )
    ) 
    goto :success
) else (goto error)

:: ---------- NO WEBP INSTALLED ----------
:nowebp
cls
echo.
color 4
echo Seems like you haven't installed cwebp.
echo https://github.com/curlynoemi/batch_tools?tab=readme-ov-file#-bulk-image-to-webp-converter
pause >nul
goto start

:: ---------- SUCCESS ----------
:success
cls
echo.
color 2
echo All done!
pause >nul
goto start

:: ---------- ERROR ----------
:error
cls
echo
color 4
echo Oops. Something went wrong, try again.
pause >nul
goto start
