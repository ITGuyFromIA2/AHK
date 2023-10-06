#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#+y::
waitTime=750 ;
FinalPath=C:\Users\chartiert\OneDrive - Network Systems Plus Inc\Documents\ChromeExport_2022 ;

ToggleLock(1)
Send ^t ; Open a new tab in the browser

WinWait, New Tab - Google Chrome,, 20
If ErrorLevel ; The new browser tab was not found
 Exit, 1
Sleep, 100
WinActivate, %winTitle%

Send chrome://bookmarks{ENTER} ; Open the browser's "bookmarks" page
WinWait, Bookmarks,, 20
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