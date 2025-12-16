StrUnescape(str)    { ;  ahk1.1  ahk2.0
    static init:=false, ahkVer, seq
    if (!init)    {
        init:=true
        switch (ahkVer:=verCompare(A_AhkVersion,"2.0-")>=0?2:1)
        {
            case 1:     fn:="object"    ,seq:=%fn%(chr(0x0007),"``a", chr(0x0008),"``b", chr(0x000C),"``f", chr(0x000A),"``n", chr(0x000D),"``r", chr(0x0009),"``t", chr(0x000B),"``v")
            case 2:     fn:="map"       ,seq:=%fn%(chr(0x0007),"``a", chr(0x0008),"``b", chr(0x000C),"``f", chr(0x000A),"``n", chr(0x000D),"``r", chr(0x0009),"``t", chr(0x000B),"``v", chr(0x0020),"``s")
        }
    }
    ret:=""
    switch (ahkVer)
    {
        case 1:
            loop Parse, str
                ret.=(seq.hasKey(A_LoopField)?seq[A_LoopField]:A_LoopField)
        case 2:
            loop Parse, str
                ret.=(seq.has(A_LoopField)?seq[A_LoopField]:A_LoopField)
    }
    return ret
}