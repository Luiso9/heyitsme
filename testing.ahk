
f::
begin_drawing:="|<>*164$50.zzzzzzzzw3zzzwzzzCTzzzDzznnzzzzzzwwV1AoUsDD9aG99YnnmTYWGNAwwb1egaHDC9aMX9YnnaNa8mNAw3b1WQaMDzzzzzzznzzzzzzzAzzzzzzzsTzzzzzzzzU"
; FIX ME: Change to coordinate for Start Drawing button
if (ok:=FindText(beginX, beginY, 997-150000, 589-150000, 997+150000, 589+150000, 0, 0, begin_drawing))
{
    Sleep, 1000
    FindText().Click(beginX, beginY, "L")
}
return
