StrEscape(str)    { ;  v1.1  v2.0
    static init:=false, ahkVer, seq
    if (!init)    {
        init:=true
        switch (ahkVer:=verCompare(A_AhkVersion,"2.0-")>=0?2:1)
        {
            case 1:     fn:="object"    ,seq:=%fn%("a","`a", "b","`b", "f","`f", "n","`n", "r","`r", "t","`t", "v","`v")
            case 2:     fn:="map"       ,seq:=%fn%("a","`a", "b","`b", "f","`f", "n","`n", "r","`r", "s","`s", "t","`t", "v","`v")
        }
    }
    spo:=1
    switch (ahkVer)
    {
        case 1:
            while regexMatch(str,"O)``([abfnrtv])",m,spo)
                ret.=(subStr(str,spo,m.pos(0)-spo) . seq[m[1]]), spo:=m.pos(0)+m.len(0)
        case 2:
            while regexMatch(str,"``([abfnrstv])",&m,spo)
                ret.=(subStr(str,spo,m.Pos[0]-spo) . seq[m[1]]), spo:=m.Pos[0]+m.Len[0]
    }
    return ret.=subStr(str,spo)
}