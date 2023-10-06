; DONE exporting passwords to Documents\ChromeExport_2022
FinalPath=%A_MyDocuments%\ChromeExport_2022 ;
;MsgBox, %FinalPath%\ ;
EnvGet, appLocal, LOCALAPPDATA ;
;MsgBox, %appLocal%\ ;
ChromeFavorites=%appLocal%\Google\Chrome\User Data\Default\BookMarks* ;
;MsgBox, %ChromeFavorites% ;

FileCopy, %ChromeFavorites%, %FinalPath%\*.* , 1 ;