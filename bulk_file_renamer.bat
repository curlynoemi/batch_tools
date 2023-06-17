@echo off
title Bilk File Renamer
setlocal enabledelayedexpansion

:start
cls
color f
echo Hi there, welcome to Bulk File Renamer
echo         by Github: @curlynoemi
echo.
echo ---------------------------------------------------------
echo.
echo What can I help you with? (type the corresponding number)
echo.
echo [1] - Add a portion
echo [2] - Rename a portion
echo [3] - Rename entirely
echo.
echo ---------------------------------------------------------
echo.
echo The folder MUST include only the files you want to Edit.
echo Else you might edit unwanted files.
echo.
set /p "menu= "
if "%menu%"=="1" (
    goto addPortion
) else if "%menu%"=="2" (
    goto renamePortion
) else if "%menu%"=="3" (
    goto renameEntirely
) 



rem ---------- ADD A PORTION OF THE FILE NAME ----------
:addPortion
cls
color f
set /p "folderPath=Enter the folder path: "
set /p "textToAdd=Enter what you want to add: "
echo Where do you want to put the text?
echo [b] At the Beginning
echo [e] At the End
set /p "addWhere= "
set /p "partProceed=Can I proceed? (y/n): "

if /i "%partProceed%"=="y" (
    for %%F in ("%folderPath%\*") do (
        set "fileName=%%~nF"
        set "fileExt=%%~xF"

        rem Edit the BEGINNING
        if /i "%addWhere%"=="b" (
        set "newFileName=!textToAdd!!fileName!!fileExt!"
        ren "%%F" "!newFileName!"

        rem Edit the END
        ) else if /i "%addWhere%"=="e" (
        set "newFileName=!fileName!!textToAdd!!fileExt!"
        ren "%%F" "!newFileName!"
        )
    )
    call:success
) else (goto error)



rem ---------- REPLACE PART OF THE FILE NAME ----------
:renamePortion
cls
color f
set /p "folderPath=Enter the folder path: "
set /p "textToRemove=Enter the text you want to replace: "
echo Enter the replacement
set /p "textToAdd=(live blank if you only want to remove): "
set /p "allProceed=Can I proceed? (y/n): "

if /i "%allProceed%"=="y" (
    for %%F in ("%folderPath%\*") do (
        set "fileName=%%~nF"
        set "fileExt=%%~xF"
        set "newFileName=!fileName:%textToRemove%=%textToAdd%!!fileExt!"
        ren "%%F" "!newFileName!"
    )
    call:success
) else (goto error)



rem ---------- REPLACE ALL OF THE FILE NAME ----------
:renameEntirely
cls
color f
set /p "folderPath=Enter the folder path: "
set /p "textToAdd=Enter how you want to call the files: "
set /p "allProceed=Can I proceed? (y/n): "

if /i "%allProceed%"=="y" (
    set "counter=1"
    for %%F in ("%folderPath%\*") do (
        set "fileName=%%~nF"
        set "fileExt=%%~xF"
        set "newFileName=!textToAdd!!counter!!fileExt!"
        ren "%%F" "!newFileName!"
        set /a "counter+=1"
    )
    call:success
) else (goto error)



rem ---------- OTHER ----------

:success
cls
echo.
color 2
echo All done!
timeout /t 10 >nul
exit

:error
cls
color 4
echo Ops. Something went wrong, try again.
pause >nul
goto start
