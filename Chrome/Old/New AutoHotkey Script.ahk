#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

MsgBox, After clicking OK, the following will happen:`n1) All Chrome windows for this user will be closed`n2) Mouse and Keyboard movement will be restricted until script completion`n`nWhen prompted for a password, please enter the password you would use to log onto the computer/RDS.
run, Taskkill /IM chrome.exe /FI "USERNAME eq %A_UserName%" /F