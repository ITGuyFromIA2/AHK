msgbox % ProcessExist(Chrome.exe, A_UserName)

ProcessExist(processName, processOwnerUserName := "") {
    query := "Select ProcessId from Win32_Process WHERE Name LIKE '%" . processName . "%'"
    
    for Process in ComObjGet("winmgmts:").ExecQuery(query, "WQL", 48) {
        if (processOwnerUserName != "") {
            currentProcessOwnerUserName := ComVar()
            Process.GetOwner(currentProcessOwnerUserName.ref)
            if (currentProcessOwnerUserName[] != processOwnerUserName)
                continue
        }
        return Process.processID
    }
}


ComVar(Type=0xC)
{
    static base := { __Get: "ComVarGet", __Set: "ComVarSet", __Delete: "ComVarDel" }
    ; Create an array of 1 VARIANT.  This method allows built-in code to take
    ; care of all conversions between VARIANT and AutoHotkey internal types.
    arr := ComObjArray(Type, 1)
    ; Lock the array and retrieve a pointer to the VARIANT.
    DllCall("oleaut32\SafeArrayAccessData", "ptr", ComObjValue(arr), "ptr*", arr_data)
    ; Store the array and an object which can be used to pass the VARIANT ByRef.
    return { ref: ComObjParameter(0x4000|Type, arr_data), _: arr, base: base }
}
ComVarGet(cv, p*) { ; Called when script accesses an unknown field.
    if p.MaxIndex() = "" ; No name/parameters, i.e. cv[]
        return cv._[0]
}
ComVarSet(cv, v, p*) { ; Called when script sets an unknown field.
    if p.MaxIndex() = "" ; No name/parameters, i.e. cv[]:=v
        return cv._[0] := v
}
ComVarDel(cv) { ; Called when the object is being freed.
    ; This must be done to allow the internal array to be freed.
    DllCall("oleaut32\SafeArrayUnaccessData", "ptr", ComObjValue(cv._))
}