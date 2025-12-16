#Requires AutoHotkey v1.1.05+
;==============================================================
; StringEscapeUtils — Small helpers to convert between raw strings and escape sequences
;
; GitHub: https://github.com/SevenKeyboard/string-escape-utils
; Author: SevenKeyboard Ltd. (2025)
; License: The Unlicense
;==============================================================
class VersionManager_StringEscapeUtils
{
    static _ := VersionManager_StringEscapeUtils._init()
    _init()    {
        global
        STRINGESCAPEUTILS_VERSION := "1.0.0"
    }
}
strEscape(str)    {
    static seq:=object("a","`a", "b","`b", "f","`f", "n","`n", "r","`r", "t","`t", "v","`v")
    spo:=1
    while regexMatch(str,"O)``([abfnrtv])",m,spo)
        ret.=(subStr(str,spo,m.pos(0)-spo) . seq[m[1]]), spo:=m.pos(0)+m.len(0)
    return ret.=subStr(str,spo)
}
strUnescape(str)    {
    static seq:=object(chr(0x0007),"``a", chr(0x0008),"``b", chr(0x000C),"``f", chr(0x000A),"``n", chr(0x000D),"``r", chr(0x0009),"``t", chr(0x000B),"``v")
    ret:=""
    loop Parse, str
        ret.=(seq.hasKey(A_LoopField)?seq[A_LoopField]:A_LoopField)
    return ret
}