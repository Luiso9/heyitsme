#include ./lib/findText.ahk
#Persistent ; Keep the script running
SetTitleMatchMode, 2 ; Allows partial matching of window titles
SetWorkingDir %A_ScriptDir%

global StopScript := false

colorHex := "./color.txt"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; For the god sake, dont touch obsufucated text
;     Text:="|<>*118$51.zzzzzzzzzhsXDnwzrxiNUM61xy0U5vSrjDk60D/mwnzNn9sS7anvSNj/mwaQ0nBvSrc1vSNaNaNyTPnC7VsTnzzzzzzzzw"
; Please
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

f::
    hwnd := WinExist("ahk_exe RobloxPlayerBeta.exe")
    if !hwnd {
        MsgBox, RobloxPlayerBeta.exe not found
        return
    }
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    WinWaitActive, ahk_exe RobloxPlayerBeta.exe, , 5

    ; FIXME : find input in color picker, or uncomment line 29 - 37 for automatically detect the hex input 
    coordX := 1255
    coordY := 289

    ; Text:="|<>*118$51.zzzzzzzzzhsXDnwzrxiNUM61xy0U5vSrjDk60D/mwnzNn9sS7anvSNj/mwaQ0nBvSrc1vSNaNaNyTPnC7VsTnzzzzzzzzw"

    ; if (ok:=FindText(coordX, coordY, 1275-150000, 289-150000, 1275+150000, 289+150000, 0, 0, Text))
    ; {
    ;     FindText().Click(process_imageX, process_imageY, "L")
    ; }
    ; else {
    ;     MsgBox, No color Picker Found
    ; }

    ; TODO : If Color cannot be found, comment the OCR (line 25 to 30) and set ur Color Picker coordinate into coordX and coordY

    ; read color.txt
    FileRead, fileContent, %colorHex%
    if (ErrorLevel) {
        MsgBox, Could not read the file.
        ExitApp
    }

    totalLines := 0
    Loop, Parse, fileContent, `n, `r
    {
        if (A_LoopField != "")
            totalLines++ ; Count total non-empty lines, such a dumbideas
    }

    lineCount := 0
    Loop, Parse, fileContent, `n, `r
    {
        line := A_LoopField
        if (line == "")
            continue

        lineCount++
        StringTrimRight, line, line, 4
        Clipboard := line

        ShowNotification("Processing line " . lineCount . " of " . totalLines . ": " . line, 5000)

        ProcessLine(line, coordX, coordY)
        Sleep, 500
    }
    ShowNotification("All lines processed. Exiting.", 5000)
ExitApp ; Supposed to exit the app when all no more line to copies
Return

; start script
ProcessLine(line, coordX, coordY) {
    WinActivate, ahk_exe autodraw.exe
    WinWaitActive, ahk_exe autodraw.exe, , 5 ; Wait up to 5 seconds
    if !WinActive("ahk_exe autodraw.exe") {
        MsgBox, Failed to activate autodraw.exe. Exiting.
        ExitApp
    }

    ; TODO: Edit coordinate to ur Open file button ffrom auto draw, that one with image logo (If OCR Broken)
    Click, 445, 437
    Sleep, 500
    WinWaitActive, Open Image
    Sleep, 500
    ; TODO: Edit coordinate to ur File name: input bar (If OCR Broken)
    input_bar:="|<>*152$64.00000000001zzzzzzzzzzrzzzzzzzzzzTzzzzzzzzzxzzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrzzzzzzzzzzTzzzzzzzzzxzzzzzzzzzzk0000000000U"

    if (ok:=FindText(inputX, inputY, 545-150000, 566-150000, 545+150000, 566+150000, 0, 0, input_bar))
    {
        FindText().Click(inputX, inputY, "L")
    }
    Sleep, 500

    Send ^v
    Sleep, 500
    Send, {Down}
    Sleep, 500
    Send, {Enter} ; dont merge down and enter, it might break the flow
    Sleep, 500

    WinActivate, ahk_exe RobloxPlayerBeta.exe
    Sleep, 500
    MouseClick, left, coordX, coordY
    MouseClick, left, coordX, coordY
    Sleep, 500
    Send ^v

    Sleep, 500
    WinActivate, ahk_exe autodraw.exe
    WinWaitActive, ahk_exe autodraw.exe

    ; Processing the Image & drawing
    process_image:="|<>*163$49.zzzzzzzzs7zzzzzzwtzzzzzzyQzzzzzzzCEEsQAC7b8m9YYmPkAtYwsDDtyNmS0UkwzCNDDyTCTb8aH39bDnksQA67zzzzzzzzU"
    ; TODO: Change to coordinate for Process Image button (If OCR Broken)
    if (ok:=FindText(process_imageX, process_imageY, 825-150000, 588-150000, 825+150000, 588+150000, 0, 0, process_image))
    {
        Sleep, 500
        FindText().Click(process_imageX, process_imageY, "L")
    }
    Sleep, 500

    begin_drawing:="|<>*164$50.zzzzzzzzw3zzzwzzzCTzzzDzznnzzzzzzwwV1AoUsDD9aG99YnnmTYWGNAwwb1egaHDC9aMX9YnnaNa8mNAw3b1WQaMDzzzzzzznzzzzzzzAzzzzzzzsTzzzzzzzzU"
    ; TODO: Change to coordinate for Start Drawing button (If OCR Broken)
    if (ok:=FindText(beginX, beginY, 997-150000, 589-150000, 997+150000, 589+150000, 0, 0, begin_drawing))
    {
        Sleep, 500
        FindText().Click(beginX, beginY, "L")
    }
    Sleep, 500

    ; DONE : IMPLEMENT DRAWING FINISHED
    WinActive("Preview")
    MouseMove, 684, 321
    Sleep, 500
    Send, {Shift}
    WaitForMouseToStay(5000) ; Wait for the mouse to stay still for 5 sec, i think its the ideal time

    Sleep, 500
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShowNotification(message, duration := 3000) {
    Gui, Notification:Destroy
    Gui, Notification:+AlwaysOnTop -Caption +ToolWindow
    Gui, Notification:Color, Black
    Gui, Notification:Font, s10 Bold, Arial
    Gui, Notification:Add, Text, cWhite Center, %message%

    ScreenWidth := A_ScreenWidth
    GuiWidth := 250
    GuiHeight := 50
    XPos := ScreenWidth - GuiWidth - 10
    YPos := 10

    Gui, Notification:Show, x%XPos% y%YPos% w%GuiWidth% h%GuiHeight% NoActivate, Notification
    SetTimer, CloseNotification, %duration%
}

CloseNotification:
    Gui, Notification:Destroy
    SetTimer, CloseNotification, Off
Return

;;;;;;;;;;;;;;;;;;

WaitForMouseToStay(timeout := 1000) {
    start := A_TickCount
    MouseGetPos, lastX, lastY
    while (A_TickCount - start < timeout) {
        MouseGetPos, currX, currY
        if (currX != lastX || currY != lastY) {
            start := A_TickCount ; reset timer if mouse moves
            lastX := currX
            lastY := currY
        }
        Sleep, 3000
    }
}

;;;;;;;;;;;;;;;;;;

^f:: ; Ctrl + F to stop the script
    StopScript := true
    GuiControl,, StatusText, Script stopping...
    Sleep, 500
ExitApp
Return