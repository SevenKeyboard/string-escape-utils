#Requires AutoHotkey v2.0.0+
;==============================================================
; StringEscapeUtils — Small helpers to convert between raw strings and escape sequences
;
; GitHub: https://github.com/SevenKeyboard/string-escape-utils
; Author: SevenKeyboard Ltd. (2025)
; License: The Unlicense
;==============================================================
class VersionManager_StringEscapeUtils
{
    static _ := this._init()
    static _init()    {
        global
        STRINGESCAPEUTILS_VERSION := "1.0.0"
    }
}
strEscape(str)    {
    static seq:=map("a","`a", "b","`b", "f","`f", "n","`n", "r","`r", "s","`s", "t","`t", "v","`v")
    spo:=1
    while regexMatch(str,"``([abfnrstv])",&m,spo)
        ret.=(subStr(str,spo,m.Pos[0]-spo) . seq[m[1]]), spo:=m.Pos[0]+m.Len[0]
    return ret.=subStr(str,spo)
}
strUnescape(str)    {
    static seq:=map(chr(0x0007),"``a", chr(0x0008),"``b", chr(0x000C),"``f", chr(0x000A),"``n", chr(0x000D),"``r", chr(0x0009),"``t", chr(0x000B),"``v", chr(0x0020),"``s")
    ret:=""
    loop parse, str
        ret.=(seq.has(A_LoopField)?seq[A_LoopField]:A_LoopField)
    return ret
}