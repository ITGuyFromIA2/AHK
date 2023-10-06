; This script opens the "About" page in a Chrome-based Web browser
; -------------------------------------
; To use a different Chrome variant, change the following variables

;NEED msgbox to confirm close of browser

;Setting various variables

EnvGet, pf, ProgramFiles ; For 64-bit browsers: ProgramW6432
dir = %pf%\Google\Chrome\Application ; Browser's drive and directory
protocol = chrome ; Start of the URL, and also the name of the Windows process
tabName = New Tab - Google Chrome ; How the browser names new tabs
PassPageTitle = Settings - Password Manager ;

; -------------------------------------

proc = %protocol%.exe ; Full name of the Windows executable file
app = %dir%\%proc% ; Full path to the browser
winTitle = ahk_exe %proc% ; Identify the window by the executable file's name
Menu, Tray, Icon, %app% ; Use the browser's icon for this script
Process, exist, %proc% ; See whether the browser is already running




;'Check to see if running... close if IS running]
if ErrorLevel 
{
Process,Close,%proc% ;need to kill if 
Process, exist, %proc% ; See whether the browser is already running
}

If NOT ErrorLevel ; Browser is not currently running, so run it
 Run, "%app%"
 
WinWait, %winTitle%,, 200
If ErrorLevel
{
 MsgBox, 48, Error, Browser window was not found.`n`nRef: %A_ScriptFullPath%
 Exit, 1
}

WinActivate, %winTitle%
;Send ^t ; Open a new tab in the browser

WinWait, %tabName%,, 20
If ErrorLevel ; The new browser tab was not found
 Exit, 1
Sleep, 100
WinActivate, %winTitle%


Send %protocol%://settings/passwords{ENTER} ; Open the browser's "p" page
WinWait, %PassPageTitle%,, 20

;sleep, 2000 ;(wait 2 seconds) 

send {tab 7}
sleep, 1000 ;(wait 2 seconds) 
send {space}
sleep, 1000 ;(wait 2 seconds) 
send {space}
sleep, 1000 ;(wait 2 seconds) 
send {tab 2}
sleep, 1000 ;(wait 2 seconds) 
send {space}


FinalPath=%A_MyDocuments%\ChromeExport_2022 ;

FileCreateDir, %FinalPath%
WinWait, Save As
send, %FinalPath% ;
sleep, 500 ;

send {enter} ;

sleep, 500 ;

send {enter} ;

; DONE exporting passwords to Documents\ChromeExport_2022
EnvGet, appLocal, LOCALAPPDATA ;
ChromeFavorites=%appLocal%\Google\Chrome\User Data\Default\BookMarks* ;
FileCopy, %ChromeFavorites%, %FinalPath%\*.* , 1 ;

Exit