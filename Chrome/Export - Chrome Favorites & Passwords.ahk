#SingleInstance Force

MsgBox, After clicking OK, the following will happen:`n1) All Chrome windows for this user will be closed`n2) Mouse and Keyboard movement will be restricted until script completion`n`nWhen prompted for a password, please enter the password you would use to log onto the computer/RDS.

ToggleLock(1)

;Setting some variables here

;ProgramFiles Directory
EnvGet, pf, ProgramFiles(x86) ; For 64-bit browsers: ProgramW6432
EnvGet, pf64, ProgramFiles ; For 64-bit browsers: ProgramW6432

;Chrome Installation Directory
dir = %pf%\Google\Chrome\Application ; Browser's drive and directory
dir64=%pf64%\Google\Chrome\Application ; Browser's drive and directory

;Prefix for URL
protocol = chrome ; Start of the URL, and also the name of the Windows process

;New Tab Name
tabName = New Tab - Google Chrome ; How the browser names new tabs

;Passwords Page title
PassPageTitle = Settings - Password Manager ;

;Bookmarks page title
BookPageTitle = Bookmarks ;

;FinalPath for export of passwords CSV and favorites file
FinalPath=%A_MyDocuments%\ChromeExport_2022 ;

;Location of Favorites
;EnvGet, appLocal, LOCALAPPDATA ;
EnvGet, appLocal, %A_AppData% ;

;ChromeFavorites=%appLocal%\Google\Chrome\User Data\Default\BookMarks* ;
ChromeFavorites=%appLocal%\Google\Chrome\Default\BookMarks* ;


waitTime=1000 ;
waitTime2=1000 ;


;Setting a few things BASED on the variables above
; -------------------------------------

;chrome.exe
proc = %protocol%.exe ; Full name of the Windows executable file

tempapp = %dir%\%proc% ; Full path to the browser
tempapp64=%dir64%\%proc% ;

if FileExist(tempapp64)
	app=%tempapp64%
else if FileExist(tempapp) 
	app=%tempapp%
else {
	ToggleLock(0)
	MsgBox, Unable to find Chrome.exe
	exit
}

winTitle = ahk_exe %proc% ; Identify the window by the executable file's name
Menu, Tray, Icon, %app% ; Use the browser's icon for this script

;See whether the browser is already running
	Process, exist, %proc% ; 

	If (ErrorLevel = 0) {
		ToggleLock(0)
		; msgbox, Chrome NOT found ;
		ToggleLock(1)
	} Else {
		ToggleLock(0)
		; msgbox, Chrome found ;
		ToggleLock(1)
		runwait, Taskkill /IM chrome.exe /FI "USERNAME eq %A_UserName%" /F
	
	}


	;msgbox, Chrome will be (Re)opening shortly ;

;Wait for Chrome to CLOSE all the way, giving it 3 seconds
	sleep, 3000 ;

;Start Chrome
	Run, "%app%" "https://google.com" --hide-crash-restore-bubble
 
;Wait for Chrome to launch
	WinWait, %winTitle%,, 200
 
If ErrorLevel
{
 MsgBox, 48, Error, Browser window was not found.`n`nRef: %A_ScriptFullPath%
 Exit, 1
}

;Activate Chrome Window
	WinActivate, %winTitle%

;Open New tab
	Send ^t ; Open a new tab in the browser

;Wait for 'New Tab'
	WinWait, %tabName%,, 20
	
If ErrorLevel ; The new browser tab was not found
 Exit, 1

;Sleep 100ms
	Sleep, 100
	
;Activate the tab
	WinActivate, %winTitle%
	Sleep, 100

;Open Passwords page
	Send %protocol%://settings/passwords{ENTER} ; Open the browser's "p" page
	WinWait, %PassPageTitle%,, 20

;7x Tabs to get to 'Export' button
	send {tab 7}
	sleep, %waitTime% ;(wait specified seconds)
;Space to select
	send {space}
	sleep, %waitTime% ;(wait specified seconds)  

;Space AGAIN to select
	send {space}
	sleep, %waitTime% ;(wait specified seconds)  

;Tabx2 to get to proper 'Export button'
	send {tab 2}
	sleep, %waitTime% ;(wait specified seconds) 

;Space to confirm
	send {space}
	ToggleLock(0)

;Create Destination Directory if not exists
FileCreateDir, %FinalPath%

;Wait for 'Save As' page
	WinWait, Save As ;
	ToggleLock(1)

;Send Final Path
	send, %FinalPath% ;
	sleep, %waitTime2% ;(wait specified seconds) 

;Send 'Enter' to confirm path
	send {enter} ;
	sleep, %waitTime2% ;(wait specified seconds) 

;Send Enter again for filename confirmation using default
	send {enter} ;
	
ToggleLock(0)

;WAIT for 'Save As' to close
	winwaitclose, Save As ;
	ToggleLock(1)
	
;*************************DONE exporting passwords to Documents\ChromeExport_2022*************************

;FileCopy, %ChromeFavorites%, %FinalPath%\*.* , 1 ;
sleep, 2000 ;

Send ^t ; Open a new tab in the browser

WinWait, %tabName%,, 20
If ErrorLevel ; The new browser tab was not found
 Exit, 1
Sleep, 100
WinActivate, %winTitle%

Send %protocol%://bookmarks{ENTER} ; Open the browser's "bookmarks" page
WinWait, %BookPageTitle%,, 20
sleep, %waitTime% ;(wait specified seconds) 

send {tab}
sleep, %waitTime% ;(wait specified seconds) 
send {space}
sleep, %waitTime% ;(wait specified seconds) 
send {up 2}
sleep, %waitTime% ;(wait specified seconds) 
send {enter}
sleep, %waitTime% ;(wait specified seconds) 


send, %FinalPath% ;
;sleep, 500 ;
sleep, %waitTime2% ;(wait specified seconds) 
send {enter} ;
sleep, %waitTime2% ;(wait specified seconds) 
send {enter} ;
ToggleLock(0)

	winwaitclose, Save As ;
MsgBox, Script has finished exporting passwords and favorites
Exitapp





;*************************************** Functions *************************************

; Locks/Unlocks keystrokes and mouse clicks.
ToggleLock(cmd)
{
  SetFormat, IntegerFast, Hex
Count := 0
  If (cmd)
  {
    Loop 0x1FF  ; Blocks keystrokes
    Hotkey, sc%A_Index%, DUMMY, On
    Loop 0x7    ; Blocks mouse clicks
    Hotkey, *vk%A_Index%, DUMMY, On
  }
Else
  {
    Loop 0x1FF  ; Unblocks keystrokes
    Hotkey, sc%A_Index%, DUMMY, Off
    Loop 0x7    ; Unblocks mouse clicks
    Hotkey, *vk%A_Index%, DUMMY, Off
  }
}

DUMMY:
Return


;*************************************** End Functions *************************************