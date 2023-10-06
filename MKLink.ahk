Loop %0%  ; For each parameter (or file dropped onto a script):
{
    GivenPath := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    Loop %GivenPath%, 1
        LongPath = %A_LoopFileLongPath%
	Loop %Name%, 1
        Name = %A_LoopFileName%
    
	SplitPath, file, name, dir, ext, name_no_ext, drive
	
	TempSplit := StrSplit(LongPath, "\")
	FolderName := TempSplit[TempSplit.MaxIndex()]	; take the last element of the created array
	
	
	
	
	
	; Get user Profile
	EnvGet, UserProf, userprofile
	
	DestFolder=UserProf\CustomShortcuts ;
	;Create Destination Directory if not exists
	FileCreateDir, %DestFolder%
	
	MsgBox GivenPath: %GivenPath%`n`nLongPath: %LongPath%`n`nFile\Folder Name: %FolderName%`n`nUser Profile: %UserProf%
	
	InputBox, LinkName , New Shortcut, Please name your new shortcut for source:`n`t%LongPath%, , 375, 150, , , Locale, 60, %FolderName%
	
	run, %DestFolder%
}